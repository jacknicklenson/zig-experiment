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
    const n = particle_sz / 4;
    const t1 = try std.time.Instant.now();
    {
        const th1 = try std.Thread.spawn(.{}, simulate, .{ slices.items(.x)[0 * n .. 0 * n + n], slices.items(.y)[0 * n .. 0 * n + n], slices.items(.z)[0 * n .. 0 * n + n], .{ randx, randy, randz }, randmag });
        defer th1.join();
        const th2 = try std.Thread.spawn(.{}, simulate, .{ slices.items(.x)[1 * n .. 1 * n + n], slices.items(.y)[1 * n .. 1 * n + n], slices.items(.z)[1 * n .. 1 * n + n], .{ randx, randy, randz }, randmag });
        defer th2.join();
        const th3 = try std.Thread.spawn(.{}, simulate, .{ slices.items(.x)[2 * n .. 2 * n + n], slices.items(.y)[2 * n .. 2 * n + n], slices.items(.z)[2 * n .. 2 * n + n], .{ randx, randy, randz }, randmag });
        defer th3.join();
        const th4 = try std.Thread.spawn(.{}, simulate, .{ slices.items(.x)[3 * n .. 3 * n + n], slices.items(.y)[3 * n .. 3 * n + n], slices.items(.z)[3 * n .. 3 * n + n], .{ randx, randy, randz }, randmag });
        defer th4.join();
    }
    const t2 = try std.time.Instant.now();
    std.debug.print("\t{d:.9} ms\n", .{@as(f64, @floatFromInt(t2.since(t1))) / 1_000_000.0});
}
