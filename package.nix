{
  lib,
  stdenv,
  cmake,
}:
stdenv.mkDerivation {
  pname = "fluidlite";
  version = "0.0.0";
  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.intersection (lib.fileset.fromSource (lib.sources.cleanSource ./.)) (
      lib.fileset.unions [
        ./android
        ./cmake
        ./include
        ./libogg-1.3.2
        ./libvorbis-1.3.5
        ./src
        ./stb
        ./CMakeLists.txt
        ./fluidlite-config.cmake.in
        ./fluidlite.pc.in
      ]
    );
  };

  cmakeBuildType = "Production";

  nativeBuildInputs = [
    cmake
  ];

  meta = with lib; {
    description = "Very light version of FluidSynth designed to be hardware, platform and external dependency independant.";
    license = licenses.lgpl21Plus;
  };
}
