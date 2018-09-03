
test:
	sudo nixos-rebuild test

setup:
	sudo ln -fs "$(shell pwd)/configuration.nix" /etc/nixos/configuration.nix
	sudo ln -fs "~/.config/nixpkgs/config.nix" ~/.config/nixpkgs/config.nix

rebuild: setup
	sudo nixos-rebuild switch