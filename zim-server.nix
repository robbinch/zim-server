{ mkDerivation, array, base, binary, binary-conduit, bytestring
, conduit, conduit-extra, http-types, lzma-conduit, resourcet
, scotty, stdenv, text, transformers, zim-parser
}:
mkDerivation {
  pname = "zim-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    array base binary binary-conduit bytestring conduit conduit-extra
    http-types lzma-conduit resourcet scotty text transformers
    zim-parser
  ];
  homepage = "https://github.com/robbinch/zim-server#readme";
  description = "Webserver that serves ZIM files locally";
  license = stdenv.lib.licenses.gpl3;
}
