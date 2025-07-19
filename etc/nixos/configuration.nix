{ config, pkgs, ... }:

let
  myHelm = pkgs.kubernetes-helm;
in {

  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & Networking
  networking.hostName = "nixlab";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 22 80 443 6443 ]; # SSH + Web + K3s
  };

  # Time & Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Keyboard layout (for X11)
  services.xserver.xkb.layout = "us";

  # mDNS (for .local access like neozorba@nixlab.local)
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      workstation = true;
    };
  };

  # K3s as a systemd service
  systemd.services.k3s = {
    description = "K3s Kubernetes Server";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/opt/k3s/bin/k3s server";
      Restart = "always";
    };
  };

  # Users
  users.users.neozorba = {
    isNormalUser = true;
    description = "neozorba";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git curl wget neovim tmux htop
    zsh starship openssh docker
    kubectl myHelm tree neofetch
  ];

  # Shell
  programs.zsh.enable = true;
  programs.starship.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # OpenSSH
  services.openssh.enable = true;

  # NixOS version
  system.stateVersion = "25.05";
}
