
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed"; # CHANGEME 
    ref = "release-18.09";
  };
in
{
    imports = [
      (import "${home-manager}/nixos")
    ];

    home-manager.users.my_username = { ... }
}
