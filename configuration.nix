# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
 
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     
     #home manager
     "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
    ];

  # BOOT
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda3";
      preLVM = true;
    }
  ];
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.hostName = "juggernaut"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # The above is replaced with
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  
  programs.zsh.enable = true;
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; }; 

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ "~/.ssh/id_rsa.pub" ];
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "fi";
    xkbOptions = "eurosign:e";
    libinput.enable = true;
    #synaptics.enable = true;

    # Enable the KDE Desktop Environment.
    #displayManager.sddm.enable = true;
    desktopManager.gnome3.enable = true;
    #desktopManager.plasma5.enable = true;
  };

  # USERS
  # Don't forget to set a password with ‘passwd’.
  users.extraUsers.valtteri = {
     name = "valtteri";
     group = "users";
     extraGroups = [
       "wheel" "disk" "audio" "video"
       "networkmanager" "systemd-journal"
     ];
     createHome = true;
     uid = 1000;
     home = "/home/valtteri";
     shell = "/run/current-system/sw/bin/zsh";
   };

  home-manager.users.valtteri = import ./home-configuration.nix {
    inherit pkgs; prefix = config.users.users.valtteri.home;
  };

  # Install some packages
  environment.systemPackages = 
    with pkgs; 
    [
      git
      gnumake
      curl
      unzip
      wget
      tmux
      chromium
      vscode
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
