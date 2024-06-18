# zig-experiment
Experimenting with zig to learning purpose. In this repo i have created from 100 to 100 Million single point particle and simulate the simple random movement and try to use the zig's `MultiArrayList(SoA)`, `std.Thread`, `SIMD (@Vector thing)` to measure speed differences and also without all this things which is naive implementation (`simple.zig`). If I didnt make any mistake, my observation is in small size particles it is slow relative to simple implementation, for big size particles it make difference but it is still small difference compare it to simple implementation which is why most of time they say dont try to be smarter than the compiler or overthink/overengineer.

You can run benchmark with `benchmark.sh`.

Here is non-scientific single run `-OReleaseFast` (yes i should run multiple times and take avrg. of it) `AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Thread` CPU benchmark ( `benchmark.sh` ):
```
=================================================== PARTICLE SIZE: 100   =======================================================================
  simple.zig:
        0.000400000 ms
  SoA_MT.zig:
        0.795600000 ms
  SoA.zig:
        0.000300000 ms
  SoA_MT_SIMD.zig:
        0.771200000 ms
  SoA_SIMD.zig:
        0.000300000 ms

=================================================== PARTICLE SIZE: 1000   =======================================================================
  simple.zig:
        0.000900000 ms
  SoA_MT.zig:
        0.751100000 ms
  SoA.zig:
        0.000400000 ms
  SoA_MT_SIMD.zig:
        0.717200000 ms
  SoA_SIMD.zig:
        0.000900000 ms

=================================================== PARTICLE SIZE: 10000   =======================================================================
  simple.zig:
        0.006600000 ms
  SoA_MT.zig:
        0.707700000 ms
  SoA.zig:
        0.002600000 ms
  SoA_MT_SIMD.zig:
        0.750800000 ms
  SoA_SIMD.zig:
        0.009200000 ms

=================================================== PARTICLE SIZE: 100000   =======================================================================
  simple.zig:
        0.065200000 ms
  SoA_MT.zig:
        0.806900000 ms
  SoA.zig:
        0.027300000 ms
  SoA_MT_SIMD.zig:
        0.700600000 ms
  SoA_SIMD.zig:
        0.089100000 ms

=================================================== PARTICLE SIZE: 1000000   =======================================================================
  simple.zig:
        0.858900000 ms
  SoA_MT.zig:
        0.830600000 ms
  SoA.zig:
        0.500500000 ms
  SoA_MT_SIMD.zig:
        0.879500000 ms
  SoA_SIMD.zig:
        0.914900000 ms

=================================================== PARTICLE SIZE: 10000000   =======================================================================
  simple.zig:
        11.207000000 ms
  SoA_MT.zig:
        10.805300000 ms
  SoA.zig:
        9.707600000 ms
  SoA_MT_SIMD.zig:
        15.484000000 ms
  SoA_SIMD.zig:
        11.683700000 ms

=================================================== PARTICLE SIZE: 100000000   =======================================================================
  simple.zig:
        115.761400000 ms
  SoA_MT.zig:
        104.852400000 ms
  SoA.zig:
        94.719200000 ms
  SoA_MT_SIMD.zig:
        148.806300000 ms
  SoA_SIMD.zig:
        101.047900000 ms

```
