{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.sddm-astronaut.nixosModules.default
  ];

  # Włączenie i konfiguracja SilentSDDM
  programs.silentSDDM = {
    enable = true;
    theme = "sddm-astronaut-theme";
    wayland.enable = true;
    extraPackages = [
      inputs.sddm-astronaut.packages.${pkgs.system}.default
    ];
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver.enable = false;

  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  console.keyMap = "pl2";
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.flatpak.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."sebastian" = {
    isNormalUser = true;
    description = "sebastian";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "audio"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  zramSwap.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" ];
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.comic-shanns-mono
  ];

  nixpkgs.config.allowUnfree = true;

  # Ujednolicony blok pakietów (bez zbędnych przedrostków pkgs. i duplikatów javy)
  environment.systemPackages = with pkgs; [
    vim
    wget
    pkgs.librewolf
    pkgs.keepassxc
    pkgs.prismlauncher
    pkgs.spotify
    pkgs.obsidian
    pkgs.obs-studio
    pkgs.discord
    pkgs.osu-lazer
    pkgs.pfetch
    pkgs.gcc
    pkgs.htop
    pkgs.gimp
    pkgs.alacritty
  ];

  system.stateVersion = "26.05";
}
