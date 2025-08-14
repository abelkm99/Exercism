const std = @import("std");
pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    var sieve = std.bit_set.IntegerBitSet(limit + 1).initEmpty();
    sieve.set(0); // 0 is not prime
    sieve.set(1); // 1 is not prime
    var cnt: usize = 0;
    for (0..limit + 1) |i| {
        if (sieve.isSet(i)) continue;
        buffer[cnt] = @intCast(i);
        cnt += 1;
        var j = i;
        while (j <= limit) : (j += i) sieve.set(j);
    }
    return buffer[0..cnt];
}
