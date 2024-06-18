const std = @import("std");

const Particle = struct {
    x: f32,
    y: f32,
    z: f32,
};

pub fn simulate(p_x: []f32, p_y: []f32, p_z: []f32, dir: [3]f32, mag: f32) void {
    const dirs: @Vector(3, f32) = dir;
    const mags: @Vector(3, f32) = @splat(mag);
    for (p_x, p_y, p_z) |*px, *py, *pz| {
        var ps = @Vector(3, f32){ px.*, py.*, pz.* };
        ps += dirs * mags;
        px.* = ps[0];
        py.* = ps[1];
        pz.* = ps[2];
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
    const n = particle_sz / 4; // each thread's workload
    var threadpool: std.Thread.Pool = undefined;
    try threadpool.init(.{ .allocator = allocator });
    const t1 = try std.time.Instant.now();
    // divide SoA's each field into 4 thread to calculate
    {
        for (0..4) |thrd_n| {
            try threadpool.spawn(simulate, .{ slices.items(.x)[thrd_n * n .. thrd_n * n + n], slices.items(.y)[thrd_n * n .. thrd_n * n + n], slices.items(.z)[thrd_n * n .. thrd_n * n + n], .{ randx, randy, randz }, randmag });
        }
        defer threadpool.deinit();
    }
    const t2 = try std.time.Instant.now();
    std.debug.print("\t{d:.9} ms\n", .{@as(f64, @floatFromInt(t2.since(t1))) / 1_000_000.0});
}
