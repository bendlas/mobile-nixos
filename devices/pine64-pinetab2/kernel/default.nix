{
  mobile-nixos
, fetchFromGitHub
, ...
}:

mobile-nixos.kernel-builder rec {

  version = "6.6.2-danctnix1";
  src = fetchFromGitHub {
    owner = "dreemurrs-embedded";
    repo = "linux-pinetab2";
    rev = "v${version}";
    sha256 = "sha256-DYCidNQxrVe7SLzJnvieFyzigaF9+O+JdQzv+f8dlHU=";
  };

  configfile = ./config.aarch64;

  isModular = false;
  isCompressed = false;
}
