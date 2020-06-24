{
  mobile-nixos
, runCommand
, fetchFromGitHub
, kernelPatches ? [] # FIXME
, buildPackages
}:

#
# Some notes:
#
#  * https://github.com/MiCode/Xiaomi_Kernel_OpenSource/wiki/How-to-compile-kernel-standalone
#
# Things to note:
#
# This currently builds **only** with cross-compilation. That is going to stay
# true until dtc_overlay's source is made available by OEMs.
#
# Either gcc49 or clang is needed for this kernel to build.
#

let
  # The "main" CFW kernel repository
  src = fetchFromGitHub {
    owner = "AgentFabulous";
    repo = "begonia";
    rev = "186e9186f6fca7ca5aec11a0d967f5c525d56539";
    sha256 = "1p08392pcavfjy5i0zc61dxibr0jq9kb3na1hdx85q0z3d9sfwp6";
  };

  inherit (buildPackages) dtc;

  # This may seem weird, but doing this inside the kernel build breaks the binary.
  # Note that `buildPackages.stdenv` is necessary since this is a tool for the host.
  dtc_overlay = buildPackages.stdenv.mkDerivation {
    name = "dtc_overlay-xiaomi-begonia";

    nativeBuildInputs = with buildPackages; [
      autoPatchelfHook
      binutils
    ];

    inherit src;

    buildPhase = ''
      cp scripts/dtc/dtc_overlay ./
      autoPatchelf dtc_overlay
      ./dtc_overlay --version
    '';

    installPhase = ''
      mv dtc_overlay $out
    '';
  };

in
(mobile-nixos.kernel-builder-clang_9 {
  version = "4.14.184";
  configfile = ./config.aarch64;

  file = "Image.gz-dtb";
  hasDTB = true;

  inherit src;

  patches = [
    ./0001-fix-teei-mediatek.patch
    ./0003-arch-arm64-Add-config-option-to-fix-bootloader-cmdli.patch
  ];

  makeFlags = [
    "DTC_EXT=${dtc}/bin/dtc"
  ];

  isModular = false;

}).overrideAttrs({ postInstall ? "", postPatch ? [], ... }: {
  installTargets = [
    # uh, things seem screwey with that vendor kernel tree, and dependencies
    # are not resolved as expected, so let's ask for the compressed kernel
    # explictly first :/.
    "Image.gz"
    "zinstall"
    "Image.gz-dtb"
    "install"
  ];

  postInstall = postInstall + ''
    cp -v "$buildRoot/arch/arm64/boot/Image.gz-dtb" "$out/"
  '';

  postPatch = postPatch + ''
    echo ":: Replacing dtc_overaly"
    (PS4=" $ "; set -x
    rm scripts/dtc/dtc_overlay
    cp ${dtc_overlay} scripts/dtc/dtc_overlay
    )
  '';
})
