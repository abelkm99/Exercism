const std = @import("std");
pub fn primes(buffer: []u32, limit: u32) []u32 {
    var flag: [1005]bool = undefined;
    var idx: usize = 0;
    _ = &idx;
    @memset(&flag, false);
    for (1..limit + 1) |d| {
        if (d == 1) continue;

        if (flag[d] == true) continue;

        buffer[idx] = @intCast(d);
        idx += 1;
        var i = d;
        while (i < limit + 1) : (i += d) {
            flag[i] = true;
        }
    }
    return buffer[0..idx];
}

