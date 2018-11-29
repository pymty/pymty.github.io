{ pkgs ? <nixpkgs> }:
with(import pkgs {});
let
  python = python37;
  envPath = builtins.getEnv "PATH";
in mkShell rec {
  inputsFrom = [ python python.pkgs.virtualenv  ];
  PATH = "${ lib.makeBinPath inputsFrom  }:${ envPath }";
  # so we dont break the wheels.. 1980
  SOURCE_DATE_EPOCH = "315532800";
  # for _some reason_ the include of libxml is inside another sub-folder
  CFLAGS = (map (p: "-I ${ p }/include") [ zlib.dev libxslt.dev python ]) ++ [ "-I ${ libxml2.dev }/include/libxml2" ];
  LDFLAGS= (map (p: "-L${ p }/lib") [ python  libxml2.out libxslt.out zlib.out ]);
  LD_LIBRARY_PATH=lib.makeLibraryPath [ python libxslt libxml2 libzip  zlib ];
}
