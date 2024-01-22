{
  description = "Very minimal NixOS Test flake (run `nix flake check -L`)";
  inputs.nixpkgs.url = github:nixos/nixpkgs;
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      checks.${system}.dummy-test =
        pkgs.testers.runNixOSTest {
          imports = [{
            name = "dummy-test";
            nodes.machine = { pkgs, ... }: {
              imports = [{
                documentation.enable = false;
              }];
            };
            testScript = ''
              start_all()
            '';
          }];
        };
    };
}
