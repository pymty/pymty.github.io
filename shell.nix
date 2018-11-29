with (import <nixpkgs> {});
let
  inherit(builtins) typeOf mapAttrs;

  vanillaPython = python36; # latest support version for Nikola

  # ghp_import2 is required to deploy directly from Nikola
  # and is not pre-packaged in nixpkgs
  ghp_import2 = with vanillaPython.pkgs;
    buildPythonPackage rec {
      pname = "ghp-import2";
      version = "1.0.1";
      doCheck = false;
      src = fetchPypi {
         inherit pname version;
         sha256 = "0zvdr67f1gr21ygnahmagfxbn1r1yb2gyiii9fb44nvcn935iygx";
      };
    };

  python = vanillaPython.override {
      packageOverrides = (self: super:
         (mapAttrs (name: value: (
         if (typeOf value) == "set" && value ? "overridePythonAttrs"
         then
           if name == "Nikola" then
             (value.overridePythonAttrs (p: {
                       # ghp-import2 is required to use the nikola command 'github_deploy'
                       # aiohttp/watchdog are required to use the nikola command 'auto'
                       propagatedBuildInputs = with super;
                          p.propagatedBuildInputs ++ [ aiohttp watchdog ghp_import2 ];
                       doInstallCheck = false;
                       doCheck = false; }))
           else # don't run the test suite on every python dependency
             (value.overridePythonAttrs (p: {
                     doInstallCheck = false;
                     doCheck = false;
                     }))
         else value))
           super)
      );
  };
in mkShell {
    buildInputs = [ python.pkgs.Nikola  ];
}
