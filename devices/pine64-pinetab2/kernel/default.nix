{
  mobile-nixos
, fetchFromGitHub
, ...
}:

mobile-nixos.kernel-builder rec {

  version = "6.6.4-danctnix2";
  src = fetchFromGitHub {
    owner = "dreemurrs-embedded";
    repo = "linux-pinetab2";
    rev = "v${version}";
    sha256 = "sha256-1CJP+cxj4YkI+6D1kpP3MHLNK6bTVBd3jVhS305+fwI=";
  };

  configfile = ./config.aarch64;

  isModular = false;
  isCompressed = false;
}
