# Dotfiles [![CI](https://github.com/Ooscaar/dotfiles/actions/workflows/main.yml/badge.svg)](https://github.com/Ooscaar/dotfiles/actions/workflows/main.yml)

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot)

## Getting Started

To set up these dotfiles on a new system:

1. Clone this repository:

   ```
   git clone https://github.com/Ooscaar/dotfiles ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the installation script:
   ```
   ./install
   ```

## Configurations

This dotfiles repository includes configurations for various tools and applications. Here's an overview of the symlinks created:

- [Vim](https://www.vim.org/): `~/.vim` and `~/.vimrc`
- [Zsh](https://www.zsh.org/) and [Oh My Zsh](https://ohmyz.sh/): `~/.zshrc`, `~/.zsh`, and `~/.oh-my-zsh`
- [Tmux](https://github.com/tmux/tmux): `~/.tmux.conf`
- [Bash](https://www.gnu.org/software/bash/): `~/.bashrc`
- [i3 window manager](https://i3wm.org/): `~/.config/i3`
- [Polybar](https://github.com/polybar/polybar): `~/.config/polybar`
- [Visual Studio Code](https://code.visualstudio.com/):
  - `~/.config/Code/User/settings.json`
  - `~/.config/Code/User/keybindings.json`
- [Dunst](https://dunst-project.org/): `~/.config/dunst/dunstrc`
- [Alacritty](https://alacritty.org/): `~/.config/alacritty`

Additional scripts:

- [Backup script](backup/script.sh): A script for backing up your configurations
- [i3 Alternating Layout](i3/alternating_layouts.py): A Python script for automatic layout in i3

## Customization

You can customize these configurations by modifying the respective files in this repository. After making changes, run the `./install` script again to update the symlinks.

## Contributing

If you have suggestions for improving these dotfiles, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
