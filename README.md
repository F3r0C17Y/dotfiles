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