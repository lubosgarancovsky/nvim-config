# Nvim config

## Prerequisites
- **colorscript**

Mac OS
```bash
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts

sudo mkdir -p /opt/shell-color-scripts/colorscripts
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/local/bin/colorscript
sudo chmod +x /usr/local/bin/colorscript
```

Arch
```
yay -S shell-color-scripts
```

- **gcc**
- **curl**
- **tree-sitter-cli**
- **lazygit**

Mac OS
```bash
brew install gcc curl tree-sitter-cli lazygit
```

Arch
```bash
sudo pacman -S gcc curl tree-sitter-cli lazygit
```

(Optional)
- **postgresql**
- **mongosh** (yay)
- **ollama**

Mac OS
```bash
brew install postgresql mongosh ollama
```

Arch
```bash
sudo pacman -S postgresql

yay -S mongosh

curl -fsSL https://ollama.com/install.sh | sh
```

## Configuration
In `~/.config/nvim/lua/config/` create file `local.lua` that returns Lua table.

**Available configuration options**
```lua
local M = {
	ui = {
		transparent = false,
	},
	ai = {
		enabled = true,
		chat_model = "ornith:9b",
		completion_model = "qwen2.5-coder:7b",
	},
	db = {
		connections = {
			{
				name = "postgres",
				url = "postgresql://<USERNAME>:<PASSWORD>@<HOST>:<PORT>/<DBNAME>",
			},
		},
	},
}

return M
```
Configuration in `local.luq` will override default values.
