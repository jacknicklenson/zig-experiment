# zig-experiment
Experimenting with zig to learning purpose. In this repo i have created from 100 to 100 Million single point particle and simulate the simple random movement and try to use the zig's `MultiArrayList(SoA)`, `std.Thread`, `SIMD (@Vector thing)` to measure speed differences and also without all this things which is naive implementation (`simple.zig`). If I didnt make any mistake, my observation is in small size particles it is slow relative to simple implementation, for big size particles it make difference but it is still small difference compare it to simple implementation which is why most of time they say dont try to be smarter than the compiler or overthink/overengineer.

You can run benchmark with `benchmark.sh`.
```
 - CPU: AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Threads
 - RAM: 16 GB 2400 MHz DDR 4
 - Zig version: 0.12
 - OS: Windows 11
```
Here is non-scientific single run `-OReleaseFast` (yes i should run multiple times and take avrg. of it) `AMD Ryzen 5 5600 3.5 GHz 6 Core / 12 Thread` CPU benchmark ( `benchmark.sh` ):
```
=================================================== PARTICLE SIZE: 100   =======================================================================
  simple.zig:
        0.000400000 ms
  SoA_MT.zig:
        0.672000000 ms
  SoA.zig:
        0.000300000 ms
  SoA_MT_SIMD.zig:
        0.767700000 ms
  SoA_SIMD.zig:
        0.000500000 ms

=================================================== PARTICLE SIZE: 1000   =======================================================================
  simple.zig:
        0.000900000 ms
  SoA_MT.zig:
        0.744200000 ms
  SoA.zig:
        0.000700000 ms
  SoA_MT_SIMD.zig:
        0.786500000 ms
  SoA_SIMD.zig:
        0.001200000 ms

=================================================== PARTICLE SIZE: 10000   =======================================================================
  simple.zig:
        0.006600000 ms
  SoA_MT.zig:
        0.788000000 ms
  SoA.zig:
        0.002700000 ms
  SoA_MT_SIMD.zig:
        0.788300000 ms
  SoA_SIMD.zig:
        0.007900000 ms

=================================================== PARTICLE SIZE: 100000   =======================================================================
  simple.zig:
        0.063500000 ms
  SoA_MT.zig:
        0.792800000 ms
  SoA.zig:
        0.017100000 ms
  SoA_MT_SIMD.zig:
        0.767100000 ms
  SoA_SIMD.zig:
        0.087900000 ms

=================================================== PARTICLE SIZE: 1000000   =======================================================================
  simple.zig:
        0.686400000 ms
  SoA_MT.zig:
        0.943300000 ms
  SoA.zig:
        0.269900000 ms
  SoA_MT_SIMD.zig:
        0.845300000 ms
  SoA_SIMD.zig:
        0.916500000 ms

=================================================== PARTICLE SIZE: 10000000   =======================================================================
  simple.zig:
        11.123300000 ms
  SoA_MT.zig:
        10.666500000 ms
  SoA.zig:
        9.218800000 ms
  SoA_MT_SIMD.zig:
        15.003700000 ms
  SoA_SIMD.zig:
        9.337800000 ms

=================================================== PARTICLE SIZE: 100000000   =======================================================================
  simple.zig:
        121.108200000 ms
  SoA_MT.zig:
        101.910800000 ms
  SoA.zig:
        90.893600000 ms
  SoA_MT_SIMD.zig:
        142.898300000 ms
  SoA_SIMD.zig:
        100.173400000 ms

```
