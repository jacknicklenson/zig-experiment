const std = @import("std");

const Particle = struct {
    x: f32,
    y: f32,
    z: f32,
};

pub fn simulate(p: []f32, dir: f32, mag: f32) void {
    for (p) |*p_| {
        p_.* += dir * mag;
    }
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);
    var particles = std.MultiArrayList(Particle){};
    defer particles.deinit(allocator);
    const particle_sz = try std.fmt.parseInt(u32, args[1], 10);
    try particles.ensureTotalCapacity(allocator, particle_sz);
    for (0..particle_sz) |_| {
        particles.appendAssumeCapacity(.{
            .x = 0.0,
            .y = 0.0,
            .z = 0.0,
        });
    }
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    const randx = rand.float(f32);
    const randy = rand.float(f32);
    const randz = rand.float(f32);
    const randmag = rand.float(f32) * 10;
    const slices = particles.slice();
    var threadpool: std.Thread.Pool = undefined;
    try threadpool.init(.{ .allocator = allocator });
    const t1 = try std.time.Instant.now();
    {
        try threadpool.spawn(simulate, .{ slices.items(.x), randx, randmag });
        try threadpool.spawn(simulate, .{ slices.items(.y), randy, randmag });
        try threadpool.spawn(simulate, .{ slices.items(.z), randz, randmag });
        defer threadpool.deinit();
    }
    const t2 = try std.time.Instant.now();
    std.debug.print("\t{d:.9} ms\n", .{@as(f64, @floatFromInt(t2.since(t1))) / 1_000_000.0});
}
