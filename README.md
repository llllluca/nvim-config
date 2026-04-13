# nvim config

Single init.lua file config for nvim 0.11.* with good default options, LSP, treesitter and netrw configuration and custom gruber colorscheme

## How to install

```bash
cd ~/.config/
git clone git@github.com:llllluca/nvim-config.git -- nvim
```

## How to test without changing your current config

```bash
git clone git@github.com:llllluca/nvim-config.git
nvim -u ./nvim-config/init.lua
```

## How to install treesitter for a new language

```bash
# Install the parser
git clone --depth=1 https://github.com/tree-sitter/tree-sitter-<LANG>.git
cd tree-sitter-lang/
make
chmod -x libtree-sitter-<LANG>.so
mkdir -p ~/.config/nvim/parser/<LANG>.so
mv libtree-sitter-<LANG>.so ~/.config/nvim/parser/<LANG>.so
cd ..

# Install the queries
git clone --depth=1 https://github.com/neovim-treesitter/nvim-treesitter.git
cd nvim-treesitter/
mkdir -p ~/.config/nvim/queries/
cp -r nvim-treesitter/runtime/queries/<LANG>/
cd ..
```
