# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "ohci_pci" "firewire_ohci" "usbhid" "usb_storage" "uas" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  fileSystems."/" =
    { device = "main";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "main/nix";
      fsType = "zfs";
    };

  fileSystems."/var/lib" =
    { device = "main/data/var";
      fsType = "zfs";
    };

  fileSystems."/home/infinisil" =
    { device = "main/data/users/infinisil";
      fsType = "zfs";
    };

  fileSystems."/root" =
    { device = "main/data/users/root";
      fsType = "zfs";
    };

  fileSystems."/root/imp" =
    { device = "main/data/important/users/root";
      fsType = "zfs";
    };

  fileSystems."/home/infinisil/imp" =
    { device = "main/data/important/users/infinisil";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/5937b768-05cf-4f36-bb5e-966e7edc6715"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "powersave";
}
