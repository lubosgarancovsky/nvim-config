# Neovim config

A standalone Lua configuration using lazy.nvim, Mason, native Neovim LSP,
Blink/LuaSnip, Tree-sitter, Snacks, Git tools, database queries and optional AI.
The leader key is **Space**.

## Requirements

- **Neovim 0.12+** and **tree-sitter-cli 0.26.1+** for the pinned Tree-sitter
  `main` branch. Check `nvim --version` and `tree-sitter --version`; distro
  packages can lag behind. Install a newer upstream release if necessary.
- Git, curl, tar, unzip, a C/C++ compiler and make.
- A current supported Node.js LTS release with npm for JavaScript-based Mason
  tools, plus Python 3 and Go for their respective language tools/workflows.
- `rg` (ripgrep) and `fd` for search; LazyGit for the Git terminal UI.
- A Nerd Font for icons and a working system clipboard provider.
- `gh` plus `gh auth login` for GitHub issues; `ec` for conflict resolution.
- `colorscript` for the dashboard decoration (installation below).

Mason installs configured language servers and formatters; it does not install
all system dependencies or project test runners. Keep project dependencies such
as TypeScript, ESLint, Tailwind, Vitest/Jest, pytest and CMake/CTest in the projects
that need them. There is no DAP debugger configured.

### macOS (Homebrew)

```sh
xcode-select --install  # If Command Line Tools are not installed already
brew install neovim git curl tree-sitter-cli lazygit gh ripgrep fd node go python make
```

Neovim uses the built-in macOS clipboard tools. Install `colorscript` using the
shared instructions below.

Optional database clients:

```sh
brew install libpq sqlite mysql-client mongosh
```

Homebrew's `libpq` and `mysql-client` are keg-only: add their `bin` directories to
your shell's PATH if you use them, for example:

```sh
export PATH="$(brew --prefix libpq)/bin:$(brew --prefix mysql-client)/bin:$PATH"
```

### Arch Linux

```sh
sudo pacman -Syu neovim git gcc make curl tar unzip tree-sitter-cli lazygit github-cli ripgrep fd nodejs npm go python
# Wayland clipboard; use xclip instead for X11:
sudo pacman -S wl-clipboard
```

With an AUR helper, optional dashboard/MongoDB packages are:

```sh
yay -S shell-color-scripts mongosh-bin
```

Alternatively install `colorscript` from source below. Install only the database
clients you need:

```sh
sudo pacman -S postgresql-libs sqlite mariadb-clients
```

### Fedora

```sh
sudo dnf install neovim git gcc gcc-c++ make curl tar unzip tree-sitter-cli gh ripgrep fd-find nodejs npm golang python3 python3-pip
# Wayland clipboard; use xclip instead for X11:
sudo dnf install wl-clipboard
```

LazyGit's upstream Fedora instructions use the following **third-party COPR**:

```sh
sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit
```

See [LazyGit installation](https://github.com/jesseduffield/lazygit#installation)
if your Fedora release needs a different installation method. Install
`colorscript` from source below.

Optional database clients:

```sh
sudo dnf install postgresql sqlite mariadb
```

For MongoDB, install `mongosh` using the
[official MongoDB Shell instructions](https://www.mongodb.com/docs/mongodb-shell/install/).
A local database server is not required when connecting to an existing server.

### Dashboard colorscript (macOS/Fedora, or Arch without AUR)

```sh
git clone https://gitlab.com/dwt1/shell-color-scripts.git
(
  cd shell-color-scripts
  sudo make install
  sudo chmod +x /usr/local/bin/colorscript
)
colorscript -e square
```

### Easy-conflict and GitHub authentication (all platforms)

If `ec` already works, keep your existing installation. Otherwise:

```sh
go install github.com/chojs23/ec/cmd/ec@latest
export PATH="$(go env GOPATH)/bin:$PATH"
```

Persist that PATH entry in your shell profile. If you set a custom `GOBIN`, use
that directory instead. Neovim must inherit the same PATH; check from inside it:

```vim
:echo executable('ec')
:echo executable('gh')
```

Both should return `1`. The optional Git mergetool integration is:

```sh
git config --global merge.tool ec
git config --global mergetool.ec.cmd 'ec "$BASE" "$LOCAL" "$REMOTE" "$MERGED"'
git config --global mergetool.ec.trustExitCode true
gh auth login
```

## First launch and updates

Open `nvim` and allow lazy.nvim, Mason and Tree-sitter installations to complete.
Use `:Lazy`, `:Mason` and `:messages` to inspect progress/errors. Parser installation
is asynchronous; reopen a file after the first installation finishes if its
Tree-sitter highlighting has not started yet.

- `:Lazy restore` restores plugin commits from `lazy-lock.json`.
- `:Lazy update` updates plugins and the lockfile; review and commit the lockfile.
- `:TSUpdate` updates installed parsers after a Tree-sitter upgrade.
- `:checkhealth vim.lsp mason mason-lspconfig nvim-treesitter snacks blink.cmp`
  checks the main integrations. Disabled optional features can produce warnings.
- `:ConformInfo` shows formatter availability. Blink deliberately uses Lua fuzzy
  matching; its missing native fuzzy-library warning is not an error here.

## Local configuration

Create `~/.config/nvim/lua/config/local.lua`, returning a table. It is ignored by
Git and overrides defaults in `lua/config/settings.lua`. AI is disabled by default;
database connections are empty by default.

```lua
return {
  ui = {
    transparent = false,
  },
  ai = {
    enabled = false,
    chat_model = "your-server-chat-model-id",
    completion_model = "your-server-fim-model-id",
  },
  db = {
    connections = {
      {
        name = "postgres",
        url = "postgresql://USERNAME:PASSWORD@HOST:5432/DBNAME",
      },
    },
  },
}
```

Do not commit database credentials or paste credential-bearing connection strings
into reports. Use a read-only account for exploration where possible.

### AI: llama.cpp, not Ollama

`lua/plugins/ai.lua` currently points both integrations at
`http://192.168.1.3:9931`. Change the chat base URL and completion endpoint there
if your server runs elsewhere. The endpoints are `/v1/chat/completions` and
`/v1/completions`; model IDs come from your local configuration. The completion
model must support the configured `<|fim_prefix|>` / `<|fim_suffix|>` /
`<|fim_middle|>` template. `TERM` is used as a placeholder bearer token; configure
proper credentials if your server requires authentication.

With AI enabled, Minuet can send surrounding buffer content to this HTTP service
for any filetype. Avoid secrets and untrusted networks. CodeCompanion enables the
`agent` tool group by default, which can read/edit files and run commands; inspect
tool requests and use a disposable project when testing.

## Feature checks and less-obvious behavior

Use disposable files/repositories and a read-only or disposable database for these
checks. `<leader>` below means Space; uppercase letters require Shift.

### LSP, completion and formatting

| Feature | Test |
| --- | --- |
| Attached servers | In a project file, run `:checkhealth vim.lsp`. The statusline shows only one client, not necessarily all attached clients. |
| Effective settings | `:lua vim.print(vim.lsp.config.ts_ls.settings)` must contain your inlay-hint preferences; inspect `gopls.settings`, `tailwindcss.settings` and `clangd.cmd` similarly. |
| Definitions/references | Use `gd`, `gD`, `gi`, `gr`, and `K`. Test local symbols, dependency definitions and lines containing non-ASCII characters. `gd` uses native LSP handling without dependency-path filtering. |
| Rename/actions | `<leader>cr` renames a symbol; `<leader>ca` opens actions. Rename an imported file with the explorer and verify imports update. |
| TypeScript imports | Test `<leader>co` (organize), `<leader>cM` (add missing), `<leader>cu` (remove unused), and `<leader>cF` (fix all supported diagnostics) against deliberate issues. |
| Inlay hints | `<leader>uh` toggles hints; verify actual parameter/type hints, not merely the toggle state. |
| ESLint/Tailwind | Use projects with their packages/configuration present. Check a known ESLint violation and Tailwind completion in `className`, `cva()` and `cx()`. ESLint fixing on save is not configured. |
| Python/Go/C++ | Introduce an undefined name/type error. Check project virtualenv resolution, Go module resolution, and C++ `compile_commands.json` as applicable. |
| Diagnostics | `<leader>cd`, `[d` / `]d`, `<leader>xx` (all), `<leader>xX` (buffer), and `<leader>fd` should show/navigate deliberate errors. Harper also checks prose/comments. |
| Formatting | `<leader>cf` formats manually; saving formats automatically. Test both and inspect `:ConformInfo`. Go uses LSP fallback; no dedicated HTML/shell LSP is configured. |
| Snippets | Expand a friendly snippet; in `.tsx`, expand `rfc` and check the filename-derived component name. Tab should move through snippet fields. |
| Tree-sitter | In TSX, JSX, shell, Python, C++, SQL, YAML and Markdown, run `:InspectTree` and check structural highlighting/folding. |

### Git

| Feature | Test |
| --- | --- |
| LazyGit | `<leader>gg`: inspect status/diff/history, quit with `q`, reopen. |
| Hunks | Make two separated edits; navigate with `[h` / `]h`, preview with `<leader>gp`, stage with `<leader>gs`, verify with `git diff --cached`. `<leader>gS` stages the buffer. |
| Discard changes | **Destructive:** `<leader>gr` resets a hunk; `<leader>gR` resets the buffer. Test only on throwaway edits. |
| Blame/browser | `<leader>gb` shows blame; `<leader>gB` opens the file remotely; `<leader>go` opens the repository. Verify the remote URL. |
| Diff/history | `<leader>gd` opens Diffview; `<leader>gD` closes it; `<leader>gh` shows file history and `<leader>gH` repository history. |
| GitHub issues | After `gh auth login`, `<leader>gi` lists open issues; `<leader>gI` includes closed issues. |
| Conflicts | Make a merge conflict in a disposable repo; `<leader>gc` opens your existing `ec` integration. Resolve it and confirm Git sees the resolution. |

### Databases

1. Configure a connection or use `:DBUIAddConnection`; `<leader>db` opens DBUI.
2. Open a query buffer and enter `SELECT 1 AS n;`.
3. **Saving does not execute it.** Execute explicitly with `<leader>S` and expect
   one row with `n = 1`. Visual selection plus `<leader>S` executes only that selection.
4. Change it to `SELECT 2 AS n;` and save; the result must not change until you
   execute again. Opening a table helper also requires explicit execution.
5. Complete a table name after `FROM` and a column after a table alias. SQL,
   MySQL and PL/SQL use the Dadbod Blink provider; buffer-word completion alone
   is not proof of a working database connection.
6. `<leader>dq` shows last-query information; `<leader>df` finds the query buffer;
   `<leader>dr` renames it. `<leader>W` saves a query for reuse under DBUI's saved
   queries. Reopen it to verify persistence.

Queries are stored under Neovim's data directory in `db_ui`. Install the command-line
client for each database you connect to (`psql`, `mysql`, `sqlite3`, `mongosh`, etc.).

### Tests, tasks and AI

| Feature | Test |
| --- | --- |
| Neotest | In a known test file, `<leader>ts` must list tests. Run nearest/file/all with `<leader>tt/tf/ta`. Include a deliberate failure and inspect `<leader>to`; stop a slow test with `<leader>tS`. Repeat per framework: Vitest, Jest, Python, Go, CTest. |
| Tasks | `<leader>rr` discovers project tasks; run one, inspect `<leader>rt`, and use `<leader>ra` for actions. Test successful and failing tasks. Overseer uses its built-in terminal job strategy, not ToggleTerm. |
| AI chat/actions | `<leader>ac` toggles chat, `<leader>aa` opens actions, and visual `<leader>ae` adds a selection. Verify a harmless prompt and an actual tool invocation in a disposable project. |
| AI completion | Type harmless code and test Alt+Shift+A (accept), Alt+a (line), Alt+z (N lines), Alt+] / Alt+[ (next/previous), Alt+e (dismiss). Your terminal must transmit these keys. |

### Other editor features

| Feature | Test |
| --- | --- |
| Explorer/search | `<leader>e` opens the explorer. Create/rename/delete throwaway files. `<leader>ff/fg` find files/text; `<leader>sw/ss` search the current word/buffer. File search includes hidden/ignored files except configured exclusions, potentially including `.env`. |
| Other pickers | `<leader>fb/fr/fp/fh/fk/fc` select buffers/recent files/projects/help/keymaps/commands; `<leader>fs` finds symbols and `<leader>ft` finds TODO comments. |
| Search/replace | `<leader>sr`: replace a unique token in two disposable files and inspect the diff. |
| Outline/folds | `<leader>cs` opens Aerial. Test `zM/zR/zm/zr` on nested code. |
| Editing helpers | Test `gcc` / visual `gc`, paired brackets/quotes, JSX closing-tag insertion/renaming, Alt+h/j/k/l movement, Flash `s/S`, and Ctrl+Space structural selection. |
| UI | `<leader>uc` toggles hex-color previews; `<leader>ut` previews/selects themes. Check Markdown rendering, bracket colors and sticky scope headers. |
| Terminal | Ctrl+/ opens/toggles a terminal. Run a command, use Escape to leave terminal mode, and reopen it. |
| Sessions | Open files/splits, quit and restart in the same project; `:lua require('persistence').load()` restores the saved session. No restore keymap is configured. |
| Desktop integration | Yank/paste between Neovim and another application in both directions. Modify a file externally and check reload behavior; test cursor and undo restoration after restarting. |
| Dashboard/notifications | Start without a file inside and outside a Git repo; inspect dashboard sections. Run `:lua vim.notify('test')`. |

`exrc` is enabled: only trust project-local `.nvim.lua` files whose code you have
reviewed. Swapfiles and backups are disabled; persistent undo does **not** recover
all unsaved edits after a crash.

## Automated smoke test

After installing plugins/tools, run from this configuration directory:

```sh
nvim --headless -u NONE -n -i NONE -l tests/smoke.lua
```

This uses the installed plugins but replaces personal local settings for the test.
It checks effective LSP settings, TypeScript attachment/diagnostics and mappings,
Tree-sitter highlighting, friendly snippets, the SQL completion provider and SQL
execution safeguards, AI tool configuration, formatting and a harmless task.
First-run parser downloads may take up to two minutes. It does not connect to a
database, send AI prompts or modify an existing project. Run the interactive
checks above for authenticated services, terminal behavior and project test suites.
