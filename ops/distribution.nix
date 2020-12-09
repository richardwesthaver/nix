{infrastructure}:

let inherit (builtins) listToAttrs attrNames getAttr removeAttrs;
    productionTargets = removeAttrs infrastructure [ "client" ];
in {
  hyde = [ infrastructure.hyde ];
} //

listToAttrs (map (targetName: {
  name = "demon-${targetName}";
  value = [ (getAttr targetName infrastructure) ];
}) (attrNames productionTargets))
