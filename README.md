# Dotfiles

Personal dotfiles for zsh/tmux/vim setup on macOS with iTerm2.

![dotfiles_ex](https://user-images.githubusercontent.com/7563104/187282092-60c55763-27e8-45a2-8e82-ed10feecf009.jpg)

## LSP
Setting up LSP is a pain and might not be worth the trouble.
Got a setup working with Mason
`:MasonInstall <some lsp server>`
Requires runtimes for any installed servers to be accessible from `~/`
- for pyright, brew install
- for `asdf`-able (ruby, nodejs, etc.), add a `.tool-versions` file in `~/` 
Lua config scripts are incredibly fragile. Imagine they'll need to be recreated basically on each version bump
