{ config, lib, pkgs, ... }:

{
  # Minimum driver hardware requirements
  mobile.kernel.structuredConfig = [
    (helpers: with helpers; {

      ARCH_ROCKCHIP = yes;
      CHARGER_RK817 = yes;
      COMMON_CLK_RK808 = yes;
      COMMON_CLK_ROCKCHIP = yes;
      GPIO_ROCKCHIP = yes;
      MFD_RK808 = yes;
      MMC_DW = yes;
      MMC_DW_ROCKCHIP = yes;
      MMC_SDHCI_OF_DWCMSHC = yes;
      MOTORCOMM_PHY = yes;
      PCIE_ROCKCHIP_DW_HOST = yes;
      PHY_ROCKCHIP_INNO_CSIDPHY = yes;
      PHY_ROCKCHIP_INNO_DSIDPHY = yes;
      PHY_ROCKCHIP_INNO_USB2 = yes;
      PHY_ROCKCHIP_NANENG_COMBO_PHY = yes;
      PINCTRL_ROCKCHIP = yes;
      PWM_ROCKCHIP = yes;
      REGULATOR_RK808 = yes;
      ROCKCHIP_DW_HDMI = yes;
      ROCKCHIP_IODOMAIN = yes;
      ROCKCHIP_IOMMU = yes;
      ROCKCHIP_MBOX = yes;
      ROCKCHIP_PHY = yes;
      ROCKCHIP_PM_DOMAINS = yes;
      ROCKCHIP_SARADC = yes;
      ROCKCHIP_THERMAL = yes;
      ROCKCHIP_VOP2 = yes;
      RTC_DRV_RK808 = yes;
      SND_SOC_RK817 = yes;
      SND_SOC_ROCKCHIP = yes;
      SND_SOC_ROCKCHIP_I2S_TDM = yes;
      SPI_ROCKCHIP = yes;
      ## for some reason gets unset
      # STMMAC_ETH = yes;
      VIDEO_HANTRO_ROCKCHIP = yes;

      CRYPTO_DEV_ROCKCHIP = yes;
      DEVFREQ_EVENT_ROCKCHIP_DFI = yes;
      DRM_ROCKCHIP = yes;
      # DWMAC_ROCKCHIP = yes;
      # EMAC_ROCKCHIP = yes;
      MTD_NAND_ROCKCHIP = yes;
      NVMEM_ROCKCHIP_OTP = yes;

    })
    (helpers: with helpers; {

      MFD_RK808 = lib.mkForce no;
      PSTORE_COMPRESS_DEFAULT = no;
      PSTORE_ZSTD_COMPRESS = no;

    })

  ];
}
