###############################################################################

# TODO: why not works
# micromamba install freetype glfw
# micromamba install imgui

# TODO: why not works
# version mismatch
# micromamba install capstone

# apple clang does not support some c++20 features
# micromamba install clang clangxx

micromamba install pkg-config

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
  -Bcapture/build
  -Scapture
)
cmake "${args[@]}"

cmake --build capture/build

###############################################################################

pip install pybind11 pybind11-global

# cmake --preset osx -DPython3_EXECUTABLE=$(which python3)
cmake --preset osx_allen -DPython3_EXECUTABLE=$(which python3)

cmake --build $PWD/build --target all
cmake --build $PWD/build --target install

pushd python
pip install -e . -vvv
popd

python -c "import tracy_client; print(tracy_client.__file__)"

###############################################################################

# just for code reading

micromamba install libxkbcommon libegl-devel wayland

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
