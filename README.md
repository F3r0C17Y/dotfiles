# dotfiles

## Preparations

Install ansible to rollout dotfiles
```shell
sudo pacman -S ansible ansible-lint
```

Configure the environment file
```shell
cp .env.example .env
```

## ZSH
To make zsh default shell
```shell
chsh -s /bin/zsh YOURUSER
```

## Tmux

Install plugins with hotkey `CTRL+A + I`

## VIM

Open a nvim session

```shell
:CocInstall coc-json coc-clangd coc-rust-analyzer coc-yaml coc-html coc-eslint coc-sh coc-docker
```

### ALE Vim Plugin

```bash
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
ninja -t compdb > compile_commands.json
```

## GPG 

```shell
gpg --card-status
```


## Rust Modules

```shell
cargo install cargo-audit cargo-update
cargo install exa bandwhich
```

Keep installed binaries up-to-date
```shell
cargo install-update -a
```