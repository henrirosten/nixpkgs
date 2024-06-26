{ lib, stdenv
, fetchurl
, autoreconfHook
, gettext
, gnutls
, nettle
, pkg-config
, libiconv
, libxcrypt
, ApplicationServices
}:

stdenv.mkDerivation rec {
  pname = "libfilezilla";
  version = "0.46.0";

  src = fetchurl {
    url = "https://download.filezilla-project.org/${pname}/${pname}-${version}.tar.xz";
    hash = "sha256-OHr1xNSENIKl+/GD0B3ZYZtLha+g1olcXuyzpgEvrCE=";
  };

  nativeBuildInputs = [ autoreconfHook pkg-config ];

  buildInputs = [ gettext gnutls nettle libxcrypt ]
    ++ lib.optionals stdenv.isDarwin [ libiconv ApplicationServices ];

  preBuild = lib.optionalString (stdenv.isDarwin) ''
    export MACOSX_DEPLOYMENT_TARGET=11.0
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://lib.filezilla-project.org/";
    description = "A modern C++ library, offering some basic functionality to build high-performing, platform-independent programs";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ pSub ];
    platforms = lib.platforms.unix;
  };
}
