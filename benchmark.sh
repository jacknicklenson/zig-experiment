#!/usr/bin/env bash

files=('simple.zig' 'SoA_MT.zig' 'SoA.zig' 'SoA_MT_SIMD.zig' 'SoA_SIMD.zig')
iters=('100' '1000' '10000' '100000' '1000000' '10000000' '100000000')

for particle_sz in "${iters[@]}"; do
	echo "=================================================== PARTICLE SIZE: $particle_sz   ======================================================================="
	for f in "${files[@]}"; do
		echo "  $f:"
		zig run -OReleaseFast "$f" -- "$particle_sz"
	done
	echo ""
done
