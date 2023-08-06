let
  pkgs = import <nixpkgs> {};
  src = pkgs.fetchFromGitHub {
    owner = "Tow-Boot";
    repo = "Tow-Boot";
    rev = "release-2022.07-006";
    hash = "sha256-gmclSBLPwLQJrACvAC9MK8AEi/aK0i+KjEkO1GocDIQ=";
  };
in pkgs.writeShellScript "flash-tow-boot" ''
  exec ${pkgs.mtdutils}/bin/flashcp \
    ${(pkgs.callPackage src {
      inherit pkgs;
    }).pine64-rockpro64}/binaries/Tow-Boot.spi.bin \
    /dev/mtd0
''
