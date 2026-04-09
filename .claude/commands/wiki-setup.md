---
name: wiki-setup
description: Set up your wiki — choose your project size and get started
---

# Wiki Setup

Guide the user through initial wiki configuration. This determines the search strategy and tooling.

## Procedure

### Step 1: Ask about project size

Present this to the user:

```
Welcome to wiki-knowledge-compiler setup!

How large is (or will be) the knowledge base you're building?

1. Small  — A handful of documents, personal notes, one project
2. Medium — Multiple projects, a research area, growing collection
3. Large  — Hundreds of sources, cross-domain, comprehensive

Enter 1, 2, or 3:
```

### Step 2: Configure based on choice

**If Small (1):**
1. Set `wiki.config.md` → `size: small`, `backend: grep`
2. No additional tools needed
3. Tell the user: `✓ Configured for small project. Search uses built-in Grep. Works well up to ~100 pages. Run /wiki-setup again if you outgrow it.`

**If Medium (2) or Large (3) — auto-install qmd:**

These sizes use [qmd](https://github.com/tobi/qmd) for smarter search. Follow this sequence:

1. Check if qmd is already installed by running `which qmd` (or `where qmd` on Windows).
2. If qmd **is already installed**, skip ahead to step 6 (Configure qmd).
3. If qmd **is not installed**, check for a JS runtime. Run these checks in order and use the first one found:
   - `which bun` → use bun
   - `which npm` → use npm
   - If one is found, skip to step 5 (Install qmd).

4. If **no JS runtime is found**, install one automatically based on the OS. Detect the platform by running `uname -s` (or checking the environment on Windows):

   **macOS (`Darwin`):**
   - Check for Homebrew: `which brew`
   - If brew **does not exist**, install it first:
     - Tell the user: `Installing Homebrew (macOS package manager)...`
     - Run: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
     - Verify: `which brew`
     - If brew still not found, check if it needs to be added to PATH (Apple Silicon installs to `/opt/homebrew/bin/`):
       - Run: `eval "$(/opt/homebrew/bin/brew shellenv)"` and try `which brew` again
     - If still fails: tell the user `Could not install Homebrew.` and fall back to Grep.
   - Now install Node: run `brew install node`
   - Verify: `which npm`

   **Linux (`Linux`):**
   - Detect the package manager by checking in this order:
     - `which apt` → Debian/Ubuntu/Pop!_OS/Mint
     - `which dnf` → Fedora/RHEL/CentOS Stream
     - `which yum` → Older CentOS/RHEL
     - `which pacman` → Arch/Manjaro
     - `which zypper` → openSUSE
     - `which apk` → Alpine
   - If a package manager is found, install Node.js with the matching command:
     - apt: `sudo apt update && sudo apt install -y nodejs npm`
     - dnf: `sudo dnf install -y nodejs npm`
     - yum: `sudo yum install -y nodejs npm`
     - pacman: `sudo pacman -Sy --noconfirm nodejs npm`
     - zypper: `sudo zypper install -y nodejs npm`
     - apk: `sudo apk add --no-cache nodejs npm`
   - If **no package manager is found**, use the universal Node.js installer:
     - Tell the user: `No known package manager found. Installing Node.js via nvm...`
     - Run: `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash`
     - Source nvm: `export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"`
     - Run: `nvm install --lts`
     - If nvm fails too, fall back to Grep.
   - Verify: `which npm`

   **Windows (no `uname`, or `uname` returns `MINGW`/`MSYS`/`CYGWIN`):**
   - Check for winget: `where winget`
   - If winget **does not exist**, install it:
     - Tell the user: `Installing winget (Windows package manager)...`
     - winget is included in the App Installer package from Microsoft Store. Try:
       - Run: `powershell -Command "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"`
     - Verify: `where winget`
     - If winget still not found, check for choco: `where choco`
     - If choco **does not exist**, install it:
       - Tell the user: `Installing Chocolatey (Windows package manager)...`
       - Run: `powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"`
       - Verify: `where choco`
       - If choco still not found: tell the user `Could not install a package manager.` and fall back to Grep.
   - Now install Node.js with whichever package manager is available:
     - winget: `winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements`
     - choco: `choco install nodejs-lts -y`
   - Verify: `where npm`

   If the JS runtime installation **fails** on any platform, tell the user:
   ```
   Could not install Node.js automatically.
   Please install it from https://nodejs.org and run /wiki-setup again.
   Using built-in search for now.
   ```
   Set `backend: grep` as fallback, keep the chosen `size`, and skip to Step 3.

   If it **succeeds**, tell the user: `✓ Node.js installed.`

5. Install qmd:
   - Tell the user: `Installing qmd for smarter search...`
   - If bun is available, run: `bun install -g @tobilu/qmd`
   - Otherwise run: `npm install -g @tobilu/qmd`
   - Verify by running: `qmd --version`
   - If verification fails, tell the user: `Could not install qmd. Using built-in search for now. You can try manually: npm install -g @tobilu/qmd` Set `backend: grep` as fallback and skip to Step 3.
   - If verification succeeds, tell the user: `✓ qmd installed.`
6. Configure qmd — register the knowledge base as a collection:
   - Tell the user: `Setting up search index...`
   - Run: `qmd collection add knowledge-base/ --name wiki`
   - Run: `qmd context add qmd://wiki "Knowledge base wiki pages"`
   - Run: `qmd embed`
   - Tell the user: `✓ Search index built.`
7. Set the backend in `wiki.config.md`:
   - **If Medium (2):** Set `size: medium`, `backend: qmd-cli`. Tell the user: `✓ Configured for medium project with qmd search.`
   - **If Large (3):** Set `size: large`, `backend: qmd-mcp`. Also configure MCP by adding to the project's `.claude/settings.json`:
     ```json
     {
       "mcpServers": {
         "qmd": {
           "command": "qmd",
           "args": ["mcp"]
         }
       }
     }
     ```
     Tell the user: `✓ Configured for large project with qmd MCP server. MCP integration set up automatically.`

### Step 3: Initialize knowledge base structure

1. Check if `knowledge-base/` exists with expected subdirectories
2. If not, run `scripts/init-kb.sh`
3. If it exists, verify structure is intact

### Step 4: Check for existing sources in raw/

1. Scan `knowledge-base/raw/` for any files
2. If files are found, count them and check which ones already have a matching summary in `knowledge-base/summaries/`
3. If there are **unprocessed files** (files in `raw/` with no matching summary):

```
Found [N] document(s) in your raw/ folder that haven't been processed yet:
  - [filename1]
  - [filename2]
  - ...

Would you like to ingest them now? This will create summaries, extract key ideas, and build your wiki.

1. Yes, ingest all of them
2. Let me pick which ones
3. Skip for now (you can run /wiki-ingest on them later)
```

4. **If "Yes, ingest all":** Run the ingestion workflow (same as `/wiki-ingest`) for each file, one at a time. Show progress:
   ```
   Ingesting [1/N]: filename1.md ...
   ✓ Created summary, extracted 3 concepts

   Ingesting [2/N]: filename2.pdf ...
   ✓ Created summary, extracted 5 concepts
   ```

5. **If "Let me pick":** List the files and let the user select which ones to ingest. Process the selected files.

6. **If "Skip":** Continue to next step. Remind the user:
   ```
   No problem. You can ingest them anytime with:
     /wiki-ingest knowledge-base/raw/filename.md
   ```

7. If `raw/` is empty or all files are already processed, skip this step silently.

### Step 5: Run initial index build

1. Run `/wiki-update` to ensure indexes are current
2. If qmd backend is active and the collection was set up in Step 2, run `qmd embed` to ensure embeddings are current

### Step 6: Offer Obsidian for visual browsing

After the wiki is set up, ask the user if they want a visual way to browse their knowledge base:

```
Would you like to browse your wiki visually?

Obsidian is a free note app that can open your knowledge base as an
interactive graph — you'll see all your pages, how they connect, and
navigate everything visually.

1. Yes, set it up for me
2. No thanks, I'll just use the commands
```

**If the user chooses 1 (Yes):**

1. Check if Obsidian is already installed:
   - macOS: `ls /Applications/Obsidian.app` or `which obsidian`
   - Linux: `which obsidian` or `which flatpak && flatpak list | grep -i obsidian`
   - Windows: `where obsidian` or check `dir "%LOCALAPPDATA%\Obsidian"`

2. If Obsidian **is not installed**, install it based on OS:

   **macOS (`Darwin`):**
   - Check for Homebrew: `which brew` (should exist from earlier steps)
   - Run: `brew install --cask obsidian`
   - Verify: `ls /Applications/Obsidian.app`

   **Linux (`Linux`):**
   - Check for Flatpak first: `which flatpak`
     - If flatpak exists: `flatpak install -y flathub md.obsidian.Obsidian`
   - If no Flatpak, check for snap: `which snap`
     - If snap exists: `sudo snap install obsidian --classic`
   - If neither exists, try installing via AppImage:
     - Download the latest AppImage from Obsidian's GitHub releases:
       `curl -L -o ~/Obsidian.AppImage "https://github.com/obsidianmd/obsidian-releases/releases/latest/download/Obsidian-x86_64.AppImage"`
     - Make executable: `chmod +x ~/Obsidian.AppImage`
     - Tell the user: `Obsidian downloaded to ~/Obsidian.AppImage — run it to launch.`
   - Verify: `which obsidian` or `flatpak list | grep -i obsidian`

   **Windows:**
   - Check for winget: `where winget`
     - If winget exists: `winget install Obsidian.Obsidian --accept-source-agreements --accept-package-agreements`
   - If no winget, check for choco: `where choco`
     - If choco exists: `choco install obsidian -y`
   - If neither works: tell the user `Download Obsidian from https://obsidian.md` and continue.
   - Verify: `where obsidian`

   If installation **fails**, tell the user:
   ```
   Could not install Obsidian automatically.
   You can download it free from https://obsidian.md
   Your wiki will still work fine with just the commands.
   ```
   Continue to the next step — this is optional.

   If installation **succeeds**, tell the user: `✓ Obsidian installed.`

3. Show the user how to connect Obsidian to their wiki:

```
✓ Obsidian is ready! Here's how to open your wiki:

1. Open Obsidian
2. Click "Open folder as vault"
3. Select your knowledge-base/ folder:
   [print the absolute path to knowledge-base/]

That's it! You'll see:

  📊 Graph View (Ctrl/Cmd+G) — a visual map of all your pages
     and how they connect to each other

  🔍 Search (Ctrl/Cmd+Shift+F) — full-text search across
     all your wiki pages

  📁 File Explorer — browse concepts, topics, summaries,
     and insights in the sidebar

  🔗 Backlinks — click any page and see every other page
     that links to it

Everything stays in sync automatically. When you add sources
with /wiki-ingest, new pages appear in Obsidian right away.
When you edit in Obsidian, the wiki picks up the changes too.

Tip: Try Graph View first — it's the best way to see the
     big picture of your knowledge base.
```

**If the user chooses 2 (No thanks):**

Skip this step. Do not mention Obsidian again.

### Step 7: Log the setup

Append to `knowledge-base/log.md`:

```
## [DATE] Wiki setup
- Project size: [small/medium/large]
- Search backend: [grep/qmd-cli/qmd-mcp]
- qmd installed: [yes/no/n/a]
- Knowledge base initialized: [yes/already existed]
- Existing sources ingested: [N ingested / M skipped / none found]
- Obsidian: [installed / already installed / skipped]
```

### Step 8: Show next steps

Tailor the message based on the current state of the wiki:

**If sources were ingested in Step 4** (wiki already has content):

```
Setup complete! Your wiki already has content. Here's what to try:

→ Next step — ask a question about what you've added:
  /wiki-query <try a question about your sources>

After that, you can:
  • Add more documents:        /wiki-ingest <file, URL, or paste text>
  • Find connections:           /wiki-insights
  • Check for problems:         /wiki-health
```

**If the wiki is empty** (no sources yet):

```
Setup complete! Your wiki is ready.

→ Next step — add your first document:
  /wiki-ingest <file path, URL, or just paste text>

For example:
  /wiki-ingest ~/Documents/my-notes.md
  /wiki-ingest ~/Downloads/research-paper.pdf

Once you've added 2-3 sources, try asking a question:
  /wiki-query <your question here>
```

In both cases, keep the message short and focused on the **one thing** to do next. Do not list all commands — the user can discover them naturally or ask for help.
