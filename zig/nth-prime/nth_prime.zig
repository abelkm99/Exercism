const std = @import("std");
const mem = std.mem;

const N = 1000_000;
const NotFound = error{
    run_out_space,
};
pub fn prime(allocator: mem.Allocator, number: usize) !usize {
    _ = allocator;
    var seive: [N]bool = undefined;
    @memset(&seive, false);

    var prime_count: u32 = 0;
    for (2..seive.len) |d| {
        if (seive[d]) continue;
        prime_count += 1;
        if (prime_count == number) return d;
        var i = d;
        while (i < seive.len) : (i += d) {
            seive[i] = true;
        }
    }
    return NotFound.run_out_space;
}
