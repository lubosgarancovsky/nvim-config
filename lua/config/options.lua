-- ============================================================================
-- UI
-- ============================================================================

-- Show absolute line numbers
vim.opt.number = true

-- Show relative distance from the current line
vim.opt.relativenumber = true

-- Always reserve space for signs (diagnostics, Git, etc.)
vim.opt.signcolumn = "yes"

-- Highlight the line where the cursor is
vim.opt.cursorline = true

-- Enable 24-bit RGB colors
vim.opt.termguicolors = true

-- Don't wrap long lines
vim.opt.wrap = false

-- Keep 8 lines visible above/below the cursor when possible
vim.opt.scrolloff = 8

-- Use one global statusline at the bottom instead of one per window
vim.opt.laststatus = 3

-- Don't show "-- INSERT --", "-- VISUAL --", etc.
vim.opt.showmode = false

-- Don't show "~" on lines past the end of the file
vim.opt.fillchars = {
	eob = " ",
}

-- ============================================================================
-- Editing
-- ============================================================================

-- Convert tabs into spaces when inserting
vim.opt.expandtab = true

-- Number of spaces that a <Tab> represents
vim.opt.tabstop = 2

-- Number of spaces used for indentation with >>, <<, etc.
vim.opt.shiftwidth = 2

-- Number of spaces inserted/removed when pressing <Tab>/<BS>
vim.opt.softtabstop = 2

-- Preserve indentation when creating a new line
vim.opt.autoindent = true

-- Automatically add indentation for common programming constructs
vim.opt.smartindent = true

-- Preserve indentation when a line wraps visually
vim.opt.breakindent = true

-- ============================================================================
-- Search
-- ============================================================================

-- Ignore case when searching
vim.opt.ignorecase = true

-- Override ignorecase when the search contains uppercase characters
-- Example: "foo" matches Foo, but "Foo" only matches Foo
vim.opt.smartcase = true

-- Highlight all search matches
vim.opt.hlsearch = true

-- Show search matches incrementally while typing the search
vim.opt.incsearch = true

-- ============================================================================
-- Splits
-- ============================================================================

-- Open new vertical splits to the right
vim.opt.splitright = true

-- Open new horizontal splits below
vim.opt.splitbelow = true

-- Keep the screen stable when opening/closing splits
vim.opt.splitkeep = "screen"

-- ============================================================================
-- Files
-- ============================================================================

-- Store undo history between Neovim sessions
vim.opt.undofile = true

-- Don't create .swp files
vim.opt.swapfile = false

-- Don't create backup files
vim.opt.backup = false

-- Don't create an additional backup before writing a file
vim.opt.writebackup = false

-- Ask what to do when trying to quit/change buffers with unsaved changes
vim.opt.confirm = true

-- ============================================================================
-- Clipboard
-- ============================================================================

-- Use the system clipboard for normal yank/paste operations
-- Requires a clipboard provider such as wl-clipboard on Wayland
vim.opt.clipboard = "unnamedplus"

-- ============================================================================
-- Completion
-- ============================================================================

-- Configure how the built-in completion popup behaves
-- menu     = show a completion menu
-- menuone  = show it even when there is only one result
-- noselect = don't automatically select the first item
vim.opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

-- Limit the height of the built-in completion popup
vim.opt.pumheight = 10

-- ============================================================================
-- Timing
-- ============================================================================

-- Time in milliseconds before CursorHold events are triggered
-- Also affects some LSP/plugin behavior
vim.opt.updatetime = 250

-- How long Neovim waits for the rest of a mapped key sequence
-- Lower = more responsive, but can make complex mappings harder to use
vim.opt.timeoutlen = 400

-- ============================================================================
-- Mouse
-- ============================================================================

-- Allow mouse interaction in all Neovim modes
vim.opt.mouse = "a"

-- Add support for folder and file specific configuration
vim.opt.exrc = true
