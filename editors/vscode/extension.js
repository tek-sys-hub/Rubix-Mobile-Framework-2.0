const vscode = require('vscode');
const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');

let rubixTerminal = null;

function getRubixTerminal() {
    if (!rubixTerminal || rubixTerminal.exitStatus !== undefined) {
        rubixTerminal = vscode.window.createTerminal('Rubix');
    }
    return rubixTerminal;
}

const HOVER_DOCS = {
    'Integer': '```rubix\ntype Integer: 64-bit signed machine integer\n```\nNative 64-bit signed two\'s-complement integer.',
    'Int': '```rubix\ntype Int = Integer\n```\nAlias for 64-bit signed Integer.',
    'String': '```rubix\ntype String: UTF-8 byte slice (ptr + length)\n```\nNull-safe immutable string slice.',
    'Boolean': '```rubix\ntype Boolean: true | false\n```\n1-byte boolean flag (0 or 1).',
    'Bool': '```rubix\ntype Bool = Boolean\n```\nAlias for Boolean.',
    'Option': '```rubix\nenum Option[T] {\n    Some(T),\n    None\n}\n```\nNull-safe optional value wrapper. Prevents null pointer dereferences.',
    'Result': '```rubix\nenum Result[T, E] {\n    Ok(T),\n    Err(E)\n}\n```\nStandard error handling sum type for recoverable errors.',
    'Some': '```rubix\nSome(val: T): Option[T]\n```\nWraps a present value inside an `Option`.',
    'None': '```rubix\nNone(): Option[T]\n```\nRepresents the absence of a value inside an `Option`.',
    'Ok': '```rubix\nOk(val: T): Result[T, E]\n```\nWraps a successful return value inside a `Result`.',
    'Err': '```rubix\nErr(err: E): Result[T, E]\n```\nWraps an error value inside a `Result`.',
    'alloc': '```rubix\nfn alloc(size: Integer): Integer\n```\nAllocates contiguous memory from the dynamic virtual heap arena with $O(1)$ bump pointer latency.',
    'arena_reset': '```rubix\nfn arena_reset(): Integer\n```\nInstantly recycles the entire heap arena back to base in $O(1)$ time without fragmentation or GC pauses.',
    'read_file': '```rubix\nfn read_file(path: String): String\n```\nSafely reads entire file into memory using exact `sys_fstat` kernel allocation.',
    'write_file': '```rubix\nfn write_file(path: String, content: String): Boolean\n```\nWrites content to disk at the specified path.',
    'file_exists': '```rubix\nfn file_exists(path: String): Boolean\n```\nReturns `true` if the file exists on the filesystem.',
    'string_length': '```rubix\nfn string_length(s: String): Integer\n```\nReturns the character length of the string.',
    'substring': '```rubix\nfn substring(s: String, start: Integer, end: Integer): String\n```\nExtracts a bounds-safe substring slice from `start` to `end`.',
    'char_at': '```rubix\nfn char_at(s: String, idx: Integer): String\n```\nReturns a 1-character string at index `idx` with bounds validation.',
    'byte_at': '```rubix\nfn byte_at(s: String, idx: Integer): Integer\n```\nReturns raw byte ASCII value at index `idx`.',
    'print': '```rubix\nprint <expr>\n```\nBuilt-in statement to print integers, strings, booleans, or variants to standard output.',
    'mut': '```rubix\nmut <ident> = <value>\n```\nDeclares a mutable local variable.',
    'let': '```rubix\nlet <ident> = <value>\n```\nDeclares an immutable local binding.',
    'fn': '```rubix\nfn <name>(<params>): <ReturnType> {\n    <body>\n}\n```\nDeclares a function.',
    'loop': '```rubix\nloop <condition> {\n    <body>\n}\n```\nHardware-aligned tight loop expression.',
    'match': '```rubix\nmatch <expr> {\n    <pattern> => <value>,\n    _ => <default>\n}\n```\nExpression-oriented pattern match.'
};

function activate(context) {
    const diagnosticCollection = vscode.languages.createDiagnosticCollection('rubix');
    context.subscriptions.push(diagnosticCollection);

    // 1. Diagnostic linter on save and open
    function validateDocument(document) {
        if (document.languageId !== 'rubix') return;
        const filePath = document.fileName;
        if (!fs.existsSync(filePath)) return;

        exec(`rubix check "${filePath}"`, { env: process.env }, (err, stdout, stderr) => {
            const diagnostics = [];
            const output = (stdout || '') + '\n' + (stderr || '');

            if (err) {
                const lines = output.split('\n');
                let found = false;
                for (const line of lines) {
                    const lineMatch = line.match(/(?:line\s+(\d+)|:(\d+):(?:\d+:)?)/i);
                    if (lineMatch) {
                        const lineNum = Math.max(0, parseInt(lineMatch[1] || lineMatch[2], 10) - 1);
                        const range = new vscode.Range(lineNum, 0, lineNum, 100);
                        diagnostics.push(new vscode.Diagnostic(range, line.trim(), vscode.DiagnosticSeverity.Error));
                        found = true;
                    }
                }
                if (!found) {
                    const range = new vscode.Range(0, 0, 0, 80);
                    diagnostics.push(new vscode.Diagnostic(range, output.trim() || 'Rubix validation error', vscode.DiagnosticSeverity.Error));
                }
            }
            diagnosticCollection.set(document.uri, diagnostics);
        });
    }

    context.subscriptions.push(
        vscode.workspace.onDidSaveTextDocument(validateDocument),
        vscode.workspace.onDidOpenTextDocument(validateDocument)
    );

    if (vscode.window.activeTextEditor) {
        validateDocument(vscode.window.activeTextEditor.document);
    }

    // 2. Command: Run Active File
    const runCommand = vscode.commands.registerCommand('rubix.run', () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor || editor.document.languageId !== 'rubix') {
            vscode.window.showWarningMessage('Please open a .bix file to run.');
            return;
        }

        editor.document.save().then(() => {
            const terminal = getRubixTerminal();
            terminal.show(true);
            terminal.sendText(`rubix run "${editor.document.fileName}"`);
        });
    });

    // 3. Command: Build Standalone Executable
    const buildCommand = vscode.commands.registerCommand('rubix.build', () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor || editor.document.languageId !== 'rubix') {
            vscode.window.showWarningMessage('Please open a .bix file to build.');
            return;
        }

        editor.document.save().then(() => {
            const filePath = editor.document.fileName;
            const parsed = path.parse(filePath);
            const outDir = path.join(parsed.dir, 'bin');
            const outBin = path.join(outDir, parsed.name);

            if (!fs.existsSync(outDir)) {
                fs.mkdirSync(outDir, { recursive: true });
            }

            const terminal = getRubixTerminal();
            terminal.show(true);
            terminal.sendText(`rubix build "${filePath}" -o "${outBin}"`);
        });
    });

    // 4. Command: Check Active File
    const checkCommand = vscode.commands.registerCommand('rubix.check', () => {
        const editor = vscode.window.activeTextEditor;
        if (editor && editor.document.languageId === 'rubix') {
            validateDocument(editor.document);
            vscode.window.showInformationMessage(`Checking Rubix file: ${path.basename(editor.document.fileName)}`);
        }
    });

    // 5. Command: Format Document
    const formatCommand = vscode.commands.registerCommand('rubix.format', () => {
        const editor = vscode.window.activeTextEditor;
        if (!editor || editor.document.languageId !== 'rubix') return;

        editor.document.save().then(() => {
            exec(`rubix fmt "${editor.document.fileName}"`, { env: process.env }, (err) => {
                if (err) {
                    vscode.window.showErrorMessage(`Formatting failed: ${err.message}`);
                } else {
                    vscode.window.showInformationMessage('Rubix code formatted.');
                }
            });
        });
    });

    // 6. Command: Rubix Doctor Health Check
    const doctorCommand = vscode.commands.registerCommand('rubix.doctor', () => {
        exec('rubix doctor', { env: process.env }, (err, stdout, stderr) => {
            if (err) {
                vscode.window.showErrorMessage(`Rubix Doctor Failed:\n${stderr || stdout}`);
            } else {
                vscode.window.showInformationMessage(`Rubix Doctor:\n${stdout.trim()}`);
            }
        });
    });

    // 7. Command: Create New Project
    const initCommand = vscode.commands.registerCommand('rubix.init', async () => {
        const name = await vscode.window.showInputBox({
            prompt: 'Enter name for your new Rubix project',
            placeHolder: 'my_rubix_app'
        });

        if (name) {
            const cwd = vscode.workspace.workspaceFolders?.[0]?.uri.fsPath || process.cwd();
            exec(`rubix init "${name}"`, { cwd, env: process.env }, (err) => {
                if (err) {
                    vscode.window.showErrorMessage(`Failed to create project: ${err.message}`);
                } else {
                    vscode.window.showInformationMessage(`Created new Rubix project: ${name}`);
                    const mainBix = path.join(cwd, name, 'src', 'main.bix');
                    if (fs.existsSync(mainBix)) {
                        vscode.workspace.openTextDocument(mainBix).then(doc => vscode.window.showTextDocument(doc));
                    }
                }
            });
        }
    });

    // 8. Document Formatting Provider
    const formattingProvider = vscode.languages.registerDocumentFormattingEditProvider('rubix', {
        provideDocumentFormattingEdits(document) {
            return new Promise((resolve) => {
                const tmpFile = path.join(os.tmpdir(), `rubix_fmt_${Date.now()}.bix`);
                fs.writeFileSync(tmpFile, document.getText());

                exec(`rubix fmt "${tmpFile}"`, { env: process.env }, (err) => {
                    if (!err && fs.existsSync(tmpFile)) {
                        const formatted = fs.readFileSync(tmpFile, 'utf8');
                        try { fs.unlinkSync(tmpFile); } catch (_) {}
                        const fullRange = new vscode.Range(
                            document.positionAt(0),
                            document.positionAt(document.getText().length)
                        );
                        resolve([vscode.TextEdit.replace(fullRange, formatted)]);
                    } else {
                        try { if (fs.existsSync(tmpFile)) fs.unlinkSync(tmpFile); } catch (_) {}
                        resolve([]);
                    }
                });
            });
        }
    });

    // 9. Hover Provider
    const hoverProvider = vscode.languages.registerHoverProvider('rubix', {
        provideHover(document, position) {
            const range = document.getWordRangeAtPosition(position);
            if (!range) return null;
            const word = document.getText(range);

            if (HOVER_DOCS[word]) {
                const md = new vscode.MarkdownString(HOVER_DOCS[word]);
                md.isTrusted = true;
                return new vscode.Hover(md, range);
            }
            return null;
        }
    });

    context.subscriptions.push(
        runCommand,
        buildCommand,
        checkCommand,
        formatCommand,
        doctorCommand,
        initCommand,
        formattingProvider,
        hoverProvider
    );
}

function deactivate() {
    if (rubixTerminal) {
        rubixTerminal.dispose();
    }
}

module.exports = {
    activate,
    deactivate
};
