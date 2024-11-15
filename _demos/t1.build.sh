###############################################################################

# TODO: why not works
# micromamba install freetype glfw
# micromamba install imgui

# TODO: why not works
# version mismatch
# micromamba install capstone

# apple clang does not support some c++20 features
# micromamba install clang clangxx

mkdir -p _demos

###############################################################################

args=(
  -DCPM_SOURCE_CACHE=_demos/_cpm_cache
  -DFETCHCONTENT_BASE_DIR=_demos/_deps_profiler
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_C_COMPILER=/Users/allen/micromamba/envs/pyenv/bin/clang
  -DCMAKE_CXX_COMPILER=/Users/allen/micromamba/envs/pyenv/bin/clang++
  -DCMAKE_LINKER_TYPE=LLD
  -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0
  -GNinja
  -Bprofiler/build
  -Sprofiler
)
cmake "${args[@]}"

cmake --build profiler/build

###############################################################################

args=(
  -DCPM_SOURCE_CACHE=_demos/_cpm_cache
  -DFETCHCONTENT_BASE_DIR=_demos/_deps_capture
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_C_COMPILER=/Users/allen/micromamba/envs/pyenv/bin/clang
  -DCMAKE_CXX_COMPILER=/Users/allen/micromamba/envs/pyenv/bin/clang++
  # ld64.lld: error: undefined symbol: getopt
  # -DCMAKE_LINKER_TYPE=LLD
  -DCMAKE_LINKER_TYPE=DEFAULT
  -DCMAKE_OSX_DEPLOYMENT_TARGET=15.0
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

# TODO: fix segmentation fault on macos(seems fails on conda python with pybind11)
# `segmentation fault python`
python -c "import tracy_client; print(tracy_client.__file__)"

###############################################################################
