# nvim-config
My simple single file nvim config.

# Install
```sh
git@github.com:plmwd/nvim-config.git
mv $HOME/.config/nvim $HOME/.config/nvim-backup
ln -s $(realpath nvim-config) $HOME/.config/nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
