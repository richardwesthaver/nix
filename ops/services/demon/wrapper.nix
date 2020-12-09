{stdenv, demon}:
{port, name}:

stdenv.mkDerivation {
  name = "${name}-wrapper";
  buildCommand = ''
    mkdir -p $out/bin
    cat > $out/bin/run-demon <<EOF
    #! ${stdenv.shell} -e
    # Configure the port number
    export PORT=${toString port}
    # Run the web application process
    ${demon}/bin/demon
    EOF
    chmod +x $out/bin/run-demon
  '';
}
