###############################################################################

# g++ fibers.cpp ../public/TracyClient.cpp -I../public/tracy -DTRACY_ENABLE -DTRACY_FIBERS -lpthread -ldl

args=(
  examples/fibers.cpp
  -o fibers
  #
  -I./public/tracy
  public/TracyClient.cpp
  #
  -DTRACY_ENABLE
  -DTRACY_FIBERS
  -lpthread -ldl
)
clang++ "${args[@]}"

###############################################################################

tracy-capture -a 127.0.0.1 -f -o _demos/trace.tracy

#####

./fibers
# test/tracy_test

#####

tracy-profiler _demos/trace.tracy

###############################################################################
