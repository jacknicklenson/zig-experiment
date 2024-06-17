# zig-experiment
Experimenting with zig to learning purpose. In this repo i have created from 100 to 100 Million single point particle and simulate the simple random movement and try to use the zig's `MultiArrayList(SoA)`, `std.Thread`, `SIMD (@Vector thing)` to measure speed differences and also without all this things which is naive implementation (`simple.zig`). If I didnt make mistake, my observation is in small size particles it is slow relative to simple implementation, for big size particles it make difference but it is still small difference compare it to simple implementation which is why most of time they say dont try to be smarter than the compiler or overthink/overengineer.

You can run benchmark with `benchmark.sh`.

Here is non-scientific single run (yes i should run multiple times and take avrg. of it) `AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Thread` CPU benchmark ( `benchmark.sh` ):
```
=================================================== PARTICLE SIZE: 100   =======================================================================
  simple.zig:
        0.001600000 ms
  SoA_MT.zig:
        0.353800000 ms
  SoA.zig:
        0.009400000 ms
  SoA_MT_SIMD.zig:
        0.455700000 ms
  SoA_SIMD.zig:
        0.008300000 ms

=================================================== PARTICLE SIZE: 1000   =======================================================================
  simple.zig:
        0.003700000 ms
  SoA_MT.zig:
        0.353700000 ms
  SoA.zig:
        0.013500000 ms
  SoA_MT_SIMD.zig:
        0.473600000 ms
  SoA_SIMD.zig:
        0.016000000 ms

=================================================== PARTICLE SIZE: 10000   =======================================================================
  simple.zig:
        0.028800000 ms
  SoA_MT.zig:
        0.466500000 ms
  SoA.zig:
        0.043100000 ms
  SoA_MT_SIMD.zig:
        0.512200000 ms
  SoA_SIMD.zig:
        0.115900000 ms

=================================================== PARTICLE SIZE: 100000   =======================================================================
  simple.zig:
        0.218800000 ms
  SoA_MT.zig:
        0.577900000 ms
  SoA.zig:
        0.708900000 ms
  SoA_MT_SIMD.zig:
        0.697700000 ms
  SoA_SIMD.zig:
        0.869500000 ms

=================================================== PARTICLE SIZE: 1000000   =======================================================================
  simple.zig:
        2.232300000 ms
  SoA_MT.zig:
        1.817800000 ms
  SoA.zig:
        3.512000000 ms
  SoA_MT_SIMD.zig:
        3.187000000 ms
  SoA_SIMD.zig:
        9.330000000 ms

=================================================== PARTICLE SIZE: 10000000   =======================================================================
  simple.zig:
        23.150300000 ms
  SoA_MT.zig:
        12.769700000 ms
  SoA.zig:
        38.458000000 ms
  SoA_MT_SIMD.zig:
        23.813500000 ms
  SoA_SIMD.zig:
        86.860700000 ms

=================================================== PARTICLE SIZE: 100000000   =======================================================================
  simple.zig:
        233.236200000 ms
  SoA_MT.zig:
        168.223300000 ms
  SoA.zig:
        428.342800000 ms
  SoA_MT_SIMD.zig:
        238.868600000 ms
  SoA_SIMD.zig:
        877.192100000 ms

```
