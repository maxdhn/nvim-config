# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on NvChad v2.5. The main NvChad repository is used as a plugin, and this repo imports its modules while providing custom configurations and plugins.

## Architecture

### Core Bootstrap Flow
1. `init.lua` - Entry point that sets up base46 cache, bootstraps lazy.nvim, and loads NvChad v2.5 as a plugin
2. Loads all plugins via `{ import = "plugins" }` which routes to `lua/plugins/init.lua`
3. `lua/plugins/init.lua` - Dynamic plugin loader that merges 17 categorized plugin files
4. Theme and UI loaded from base46 cache, then custom options and mappings applied

### Configuration Layers
- **NvChad Base**: Imported as plugin, provides core functionality via `nvchad.*` modules
- **Custom Overrides**: `lua/options.lua`, `lua/mappings.lua`, `lua/chadrc.lua` extend base configuration
- **Plugin Configs**: `lua/configs/` contains specific plugin configurations that override NvChad defaults

### Plugin Architecture
The configuration uses a sophisticated plugin loading system:
- **Dynamic Loading**: `lua/plugins/init.lua` dynamically loads and merges plugins from 17 category files
- **Error Handling**: Failed plugin loads are logged but don't break the entire configuration
- **Categorized Organization**: Plugins split into logical groups (lsp, editor, telescope, git, ai, debugger, etc.)
- **Performance Optimized**: Lazy loading enabled by default, many built-in Neovim plugins disabled

### Custom Modules
- `lua/custom/test.lua` - Toggle between source and test files functionality
- `lua/custom/telescope_browser_grep.lua` - Custom telescope extensions

### Configuration Files
- `lua/configs/` - Contains plugin-specific configurations:
  - `conform.lua` - Code formatting
  - `dap.lua` - Debug Adapter Protocol
  - `lspconfig.lua` - LSP server configurations
  - `telescope.lua` - Telescope fuzzy finder settings
  - `nvim-ufo.lua` - Code folding
  - `nvimtree.lua` - File explorer

## Custom Key Mappings

Key custom mappings include:
- `<leader>tt` - Toggle between source and test files
- `<leader>bc` - Close all buffers except current
- `<leader>bl/br` - Close buffers to left/right
- `<leader>bh/bv` - Horizontal/vertical splits
- `Alt+1-9` - Navigate to specific tabs
- `jk` - Escape from insert mode
- `;` - Enter command mode

## Development Commands

### Configuration Testing
- **Quick Test**: `nvim` - Launch Neovim to verify configuration loads
- **Syntax Check**: `nvim --headless -c "luafile init.lua" -c "quit"` - Check for Lua syntax errors
- **Silent Test**: `nvim --headless -c "quit"` - Test configuration without UI

### Plugin Management (within Neovim)
- **Sync All**: `:Lazy sync` - Install missing and update existing plugins  
- **Install**: `:Lazy install` - Install missing plugins only
- **Update**: `:Lazy update` - Update existing plugins only
- **Clean**: `:Lazy clean` - Remove unused plugins
- **Status**: `:Lazy` - View plugin manager UI
- **Health Check**: `:checkhealth` - Verify plugin and LSP health

### LSP Management (within Neovim)  
- **LSP Info**: `:LspInfo` - View active LSP servers for current buffer
- **LSP Log**: `:LspLog` - View LSP client logs for debugging

### Custom Functionality Testing
- **Toggle Test**: Use `<leader>tt` to test the source/test file toggle functionality in `lua/custom/test.lua:3`

## Important Implementation Details

### Plugin Loading System
- **NvChad as Plugin**: Configuration imports NvChad v2.5 as a plugin, not as a base configuration
- **Dynamic Merging**: `lua/plugins/init.lua:29-43` dynamically merges plugins from 17 category files
- **Load Order**: NvChad plugins load first, then custom plugins from `{ import = "plugins" }`
- **Error Resilience**: Plugin loading failures are logged but don't break the entire configuration

### Performance Optimizations  
- **Lazy Loading**: All plugins default to `lazy = true` in `lua/configs/lazy.lua:2`
- **Disabled Plugins**: 20+ built-in Neovim plugins disabled for performance in `lua/configs/lazy.lua:16-44`
- **Base46 Caching**: UI themes cached in `vim.fn.stdpath "data" .. "/base46/"`

### LSP Configuration
- **Multi-Language Support**: 20+ LSP servers configured in `lua/configs/lspconfig.lua:7-30`
- **Standardized Setup**: All LSP servers use NvChad's default `on_attach`, `on_init`, and `capabilities`

### Custom Extensions
- **Source/Test Toggle**: `lua/custom/test.lua` provides intelligent file switching with pattern matching for `.test` and `_test` suffixes
- **Enhanced Telescope**: Custom configuration in `lua/configs/telescope.lua` with `filename_first` path display