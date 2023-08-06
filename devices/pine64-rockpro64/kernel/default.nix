{
  mobile-nixos
, fetchpatch
, fetchFromGitLab
, ...
}:

mobile-nixos.kernel-builder {
  version = "6.4.3";
  configfile = ./config.aarch64;

  src = fetchFromGitLab {
    owner = "pine64-org";
    repo = "linux";
    rev = "ppp-6.4-20230716-1722";
    sha256 = "sha256-O4lhp0Zae4AWE1Kiv1V1Z7gen5/RaL68DrxIPysH0xw";
  };

  patches = [
    ./0001-arm64-dts-rockchip-set-type-c-dr_mode-as-otg.patch
    ./0001-dts-pinephone-pro-Setup-default-on-and-panic-LEDs.patch
    ./0001-usb-dwc3-Enable-userspace-role-switch-control.patch
  ];

  postInstall = ''
    echo ":: Installing FDTs"
    mkdir -p $out/dtbs/rockchip
    cp -v "$buildRoot/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtb" "$out/dtbs/rockchip/"
  '';

  isModular = false;
  isCompressed = false;
}
