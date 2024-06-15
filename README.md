# zig-experiment
Experimenting with zig to learning purpose. In this repo i have created from 100 to 1 Million single point particle and simulate the simple random movement and try to use the zig's `MultiArrayList(SoA)`, `std.Thread`, `SIMD (@Vector thing)` to measure speed differences and also without all this things which is naive implementation (`simple.zig`). If I didnt make mistake, my observation is in small size particles it is slow relative to simple implementation, for big size particles it make difference but it is still small difference compare it to simple implementation which is why most of time they say dont try to be smarter than the compiler or overthink/overengineer.

Here is `AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Thread` CPU benchmark ( `benchmark.sh` ):
```
=================================================== PARTICLE SIZE: 100   =======================================================================
  simple.zig:
        0.001400000 ms
  SoA_MT.zig:
        0.443800000 ms
  SoA.zig:
        0.007800000 ms
  SoA_MT_SIMD.zig:
        0.491100000 ms
  SoA_SIMD.zig:
        0.008300000 ms

=================================================== PARTICLE SIZE: 1000   =======================================================================
  simple.zig:
        0.003100000 ms
  SoA_MT.zig:
        0.439300000 ms
  SoA.zig:
        0.011200000 ms
  SoA_MT_SIMD.zig:
        0.437200000 ms
  SoA_SIMD.zig:
        0.022200000 ms

=================================================== PARTICLE SIZE: 10000   =======================================================================
  simple.zig:
        0.028100000 ms
  SoA_MT.zig:
        0.459500000 ms
  SoA.zig:
        0.043000000 ms
  SoA_MT_SIMD.zig:
        0.495300000 ms
  SoA_SIMD.zig:
        0.093000000 ms

=================================================== PARTICLE SIZE: 100000   =======================================================================
  simple.zig:
        0.323400000 ms
  SoA_MT.zig:
        0.576400000 ms
  SoA.zig:
        0.417100000 ms
  SoA_MT_SIMD.zig:
        0.691000000 ms
  SoA_SIMD.zig:
        0.868200000 ms

=================================================== PARTICLE SIZE: 1000000   =======================================================================
  simple.zig:
        2.211600000 ms
  SoA_MT.zig:
        1.765200000 ms
  SoA.zig:
        4.203100000 ms
  SoA_MT_SIMD.zig:
        3.190200000 ms
  SoA_SIMD.zig:
        8.626300000 ms

```
