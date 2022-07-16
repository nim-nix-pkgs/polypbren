{
  description = ''Renormalization of colloidal charges of polydipserse dispersions using the Poisson-Boltzmann equation'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-polypbren-master.flake = false;
  inputs.src-polypbren-master.ref   = "refs/heads/master";
  inputs.src-polypbren-master.owner = "guibar64";
  inputs.src-polypbren-master.repo  = "polypbren";
  inputs.src-polypbren-master.type  = "github";
  
  inputs."github.com/yglukhov/threadpools".owner = "nim-nix-pkgs";
  inputs."github.com/yglukhov/threadpools".ref   = "master";
  inputs."github.com/yglukhov/threadpools".repo  = "github.com/yglukhov/threadpools";
  inputs."github.com/yglukhov/threadpools".dir   = "";
  inputs."github.com/yglukhov/threadpools".type  = "github";
  inputs."github.com/yglukhov/threadpools".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/yglukhov/threadpools".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-polypbren-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-polypbren-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}