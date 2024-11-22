###############################################################################

docker pull emscripten/emsdk:3.1.72-arm64

###############################################################################

args=(
  -DCPM_SOURCE_CACHE=_demos/_cpm_cache
  -DFETCHCONTENT_BASE_DIR=_demos/_deps_profiler
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
  -DCMAKE_TOOLCHAIN_FILE=/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake
  -GNinja
  -Bprofiler/build
  -Sprofiler
)
cmake "${args[@]}"

cmake --build profiler/build

###############################################################################

mkdir -p _demos/tracy_wasm_bin
cp profiler/build/index.html _demos/tracy_wasm_bin
cp profiler/build/httpd.py _demos/tracy_wasm_bin
cp profiler/build/favicon.svg _demos/tracy_wasm_bin
cp profiler/build/tracy-profiler.data _demos/tracy_wasm_bin
cp profiler/build/tracy-profiler.js _demos/tracy_wasm_bin
cp profiler/build/tracy-profiler.wasm _demos/tracy_wasm_bin

pushd _demos
tar czf tracy_wasm_bin.tar.gz tracy_wasm_bin
popd

###############################################################################
