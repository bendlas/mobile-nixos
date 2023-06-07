{ config, lib, pkgs, ... }:
{
  imports = [
    ../pine64-pinephonepro/default.nix
    {
      mobile.device.name = lib.mkForce "pine64-rockpro64";
      mobile.device.identity.name = lib.mkForce "RockPro64";
      mobile.boot.stage-1.kernel.package = lib.mkForce (pkgs.callPackage ./kernel { });
      boot.kernelParams = [
        # Serial console on ttyS2, using the dedicated cable.
        "console=ttyS2,115200"
        "earlycon=uart8250,mmio32,0xff1a0000"
        "earlyprintk"

        "quiet"
        "vt.global_cursor_default=0"

        # Needed for kexec
        "irqchip.gicv3_nolpi=1"
      ];
      mobile.kernel.structuredConfig = [
        (helpers: with helpers; {
          ## rockpro64 specific hardware
          # ethernet
          NET_VENDOR_STMICRO = yes;
          STMMAC_PLATFORM = yes;
          STMMAC_ETH = yes;
          DWMAC_ROCKCHIP = yes;

          # HDMI audio
          DRM_DW_HDMI_I2S_AUDIO = yes;
          DRM_DW_HDMI_CEC = yes;
          SND_SOC_ROCKCHIP_I2S = yes;
          SND_SOC_ROCKCHIP_I2S_TDM = yes;
          SND_SOC_ROCKCHIP_SPDIF = yes;
        })
      ];
      mobile.boot.stage-1.shell.console = "ttyS2";
      mobile.boot.stage-1.shell.shellOnFail = true;
    }
  ];

}
