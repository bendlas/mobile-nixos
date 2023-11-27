{ config, lib, pkgs, ... }:

{
  imports = [
    ./kernel-config.nix
  ];

  mobile.device.name = "pine64-pinetab2";
  mobile.device.identity = {
    name = "Pinetab2";
    manufacturer = "Pine64";
  };
  mobile.device.supportLevel = "supported";

  mobile.hardware = {
    soc = "rockchip-rk3566";
    ram = 1024 * 8;
    screen = {
      width = 800; height = 1280;
    };
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel { };
  };

  boot.kernelParams = [
    # "console=ttyS2,1500000n8" "rootwait" "root=LABEL=NIXOS_SD" "rw"
    # "earlycon=uart8250,mmio32,0xff1a0000"
  ];

  mobile.boot.serialConsole = "ttyS2,1500000n8";

  mobile.system.type = "u-boot";

  mobile.usb.mode = "gadgetfs";


  ## It seems Pine64 does not have an idVendor...
  mobile.usb.idVendor = "1209";  ## http://pid.codes/1209/
  mobile.usb.idProduct = "0069"; ## "common tasks, such as testing, generic USB-CDC devices, etc."

  ## Mainline gadgetfs functions
  mobile.usb.gadgetfs.functions = {
    rndis = "rndis.usb0";
    mass_storage = "mass_storage.0";
    adb = "ffs.adb";
  };

  mobile.boot.stage-1.bootConfig = {
    ## Used by target-disk-mode to share the internal drive
    # storage.internal = "/dev/disk/by-path/platform-fe330000.mmc";
  };

  # mobile.boot.stage-1.tasks = [ ./usb_role_switch_task.rb ];

  mobile.documentation.hydraOutputs = [
    ["installer.@device@" "Installer image"]
  ];
}
