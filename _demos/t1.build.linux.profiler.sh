###############################################################################

# just for code reading

micromamba create -n tracy python=3.12

micromamba install fd-find ripgrep -y
micromamba install bash-completion -y
micromamba install git openssh -y
micromamba install clang-tools -y
micromamba install cmake ninja -y

micromamba install pkg-config -y
micromamba install libxkbcommon libegl-devel wayland dbus -y

###############################################################################

args=(
  -DCPM_SOURCE_CACHE=_demos/_cpm_cache
  -DFETCHCONTENT_BASE_DIR=_demos/_deps_profiler
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_C_COMPILER=$(which gcc)
  -DCMAKE_CXX_COMPILER=$(which g++)
  -DCMAKE_LINKER_TYPE=DEFAULT
  -GNinja
  -Bprofiler/build
  -Sprofiler
)
cmake "${args[@]}"

ln -s $PWD/profiler/build/compile_commands.json $PWD/compile_commands.json
# cmake --build profiler/build

###############################################################################
