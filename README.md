# nvim-config
My simple single file nvim config.

# Install
```sh
git clone git@github.com:plmwd/nvim-config.git
mv $HOME/.config/nvim $HOME/.config/nvim-backup
ln -s $(realpath nvim-config) $HOME/.config/nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
JK. That's a lie. Bootstrapping this shit is annoying as fuck. Try running `PackerSync` and restarting vim after running the above.
