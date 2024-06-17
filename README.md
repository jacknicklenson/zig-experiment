# zig-experiment
Experimenting with zig to learning purpose. In this repo i have created from 100 to 100 Million single point particle and simulate the simple random movement and try to use the zig's `MultiArrayList(SoA)`, `std.Thread`, `SIMD (@Vector thing)` to measure speed differences and also without all this things which is naive implementation (`simple.zig`). If I didnt make any mistake, my observation is in small size particles it is slow relative to simple implementation, for big size particles it make difference but it is still small difference compare it to simple implementation which is why most of time they say dont try to be smarter than the compiler or overthink/overengineer.

You can run benchmark with `benchmark.sh`.

Here is non-scientific single run `-OReleaseFast` (yes i should run multiple times and take avrg. of it) `AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Thread` CPU benchmark ( `benchmark.sh` ):
```
=================================================== PARTICLE SIZE: 100   =======================================================================
  simple.zig:
        0.000500000 ms
  SoA_MT.zig:
        0.370900000 ms
  SoA.zig:
        0.000600000 ms
  SoA_MT_SIMD.zig:
        0.477300000 ms
  SoA_SIMD.zig:
        0.000400000 ms

=================================================== PARTICLE SIZE: 1000   =======================================================================
  simple.zig:
        0.001000000 ms
  SoA_MT.zig:
        0.387200000 ms
  SoA.zig:
        0.000600000 ms
  SoA_MT_SIMD.zig:
        0.419900000 ms
  SoA_SIMD.zig:
        0.001200000 ms

=================================================== PARTICLE SIZE: 10000   =======================================================================
  simple.zig:
        0.005300000 ms
  SoA_MT.zig:
        0.384300000 ms
  SoA.zig:
        0.002500000 ms
  SoA_MT_SIMD.zig:
        0.458100000 ms
  SoA_SIMD.zig:
        0.009000000 ms

=================================================== PARTICLE SIZE: 100000   =======================================================================
  simple.zig:
        0.062200000 ms
  SoA_MT.zig:
        0.435400000 ms
  SoA.zig:
        0.020000000 ms
  SoA_MT_SIMD.zig:
        0.516300000 ms
  SoA_SIMD.zig:
        0.070500000 ms

=================================================== PARTICLE SIZE: 1000000   =======================================================================
  simple.zig:
        0.666400000 ms
  SoA_MT.zig:
        0.521700000 ms
  SoA.zig:
        0.325400000 ms
  SoA_MT_SIMD.zig:
        0.649900000 ms
  SoA_SIMD.zig:
        0.746400000 ms

=================================================== PARTICLE SIZE: 10000000   =======================================================================
  simple.zig:
        12.739300000 ms
  SoA_MT.zig:
        11.426100000 ms
  SoA.zig:
        8.899900000 ms
  SoA_MT_SIMD.zig:
        13.678400000 ms
  SoA_SIMD.zig:
        10.156400000 ms

=================================================== PARTICLE SIZE: 100000000   =======================================================================
  simple.zig:
        145.017700000 ms
  SoA_MT.zig:
        112.270900000 ms
  SoA.zig:
        98.126700000 ms
  SoA_MT_SIMD.zig:
        147.917100000 ms
  SoA_SIMD.zig:
        102.642200000 ms

```
