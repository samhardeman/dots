# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "based"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable networking
  networking.networkmanager.enable = true;
  # networking.nameservers = [ "192.168.1.38" "1.1.1.1" ];
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [
	pkgs.gutenprint
	pkgs.brgenml1lpr
	pkgs.brgenml1cupswrapper
  ];
  services.avahi = {
	enable = true;
	nssmdns = true;
	openFirewall = true;
  };
  
  hardware.rtl-sdr.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "sam";
    extraGroups = [ "plugdev" "networkmanager" "wheel" "vboxusers" ];
    packages = with pkgs; [
    ];
  };

  ############
  # Programs #
  ############
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  # programs.kdeconnect.enable = true;
  programs.hyprlock.enable = true;
  programs.git.enable = true;
  programs.steam.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ###################
  # System Packages #
  ###################
  environment.systemPackages = with pkgs; [
  	kitty
	brave
	discord
	element-desktop
	element
	spotify
	obsidian
	vlc
	signal-desktop
	swww
	hyprshot
	gh
	libreoffice
	prismlauncher
	htop
	stow
	gnome.gnome-tweaks
	waybar
	rofi-wayland
	dunst
	libnotify
	zoxide
	tree
	nnn
	networkmanagerapplet
	brightnessctl
	playerctl
	tofi
        tmux
	neofetch
	gnomeExtensions.gsconnect
	pavucontrol
	thonny
	vscode
	hugo
	gqrx
	sdrpp
	python3
  ];

  #########
  # Fonts #
  #########
  fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];  

  ###########
  # Portals #
  ###########
  xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.flatpak.enable = true;
  services.hypridle.enable = true;
  services.tailscale.enable = true;
  services.blueman.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  ##################
  # Virtualization #
  ##################
  virtualisation.virtualbox.host = {
	enable = true;
	#enableKvm = true;
  };	

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}