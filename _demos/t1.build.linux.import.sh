###############################################################################

# non conda env

apt install pkg-config
apt install libdbus-1-dev

mkdir -p _demos

###############################################################################

args=(
  -DCPM_SOURCE_CACHE=_demos/_cpm_cache
  -DFETCHCONTENT_BASE_DIR=_demos/_deps_capture
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_C_COMPILER=$(which gcc)
  -DCMAKE_CXX_COMPILER=$(which g++)
  -DCMAKE_LINKER_TYPE=DEFAULT
  -DGTK_FILESELECTOR=false
  -GNinja
  -Bimport/build
  -Simport
)
cmake "${args[@]}"

cmake --build import/build

###############################################################################
