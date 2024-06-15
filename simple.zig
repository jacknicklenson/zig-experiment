const std = @import("std");

const Particle = struct {
    x: f32,
    y: f32,
    z: f32,
};

pub fn simulate(p: []Particle, dir: [3]f32, mag: f32) void {
    for (p) |*p_| {
        p_.x += dir[0] * mag;
        p_.y += dir[1] * mag;
        p_.z += dir[2] * mag;
    }
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    var particles = std.ArrayList(Particle).init(allocator);
    defer particles.deinit();
    const particle_sz = try std.fmt.parseInt(u32, args[1], 10);
    try particles.resize(particle_sz);
    for (0..particle_sz) |n| {
        particles.items[n] = .{
            .x = 0.0,
            .y = 0.0,
            .z = 0.0,
        };
    }
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    const t1 = try std.time.Instant.now();
    simulate(particles.items, .{ rand.float(f32), rand.float(f32), rand.float(f32) }, rand.float(f32) * 10);
    const t2 = try std.time.Instant.now();
    std.debug.print("\t{d:.9} ms\n", .{@as(f64, @floatFromInt(t2.since(t1))) / 1_000_000.0});
}
