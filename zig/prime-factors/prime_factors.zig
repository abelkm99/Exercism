const std = @import("std");
const mem = std.mem;

pub fn factors(allocator: mem.Allocator, value: u64) mem.Allocator.Error![]u64 {
    var result = std.ArrayList(u64).init(allocator);
    defer result.deinit();
    const sqrt: u64 = std.math.sqrt(value);

    var val: u64 = value;
    for (1..sqrt + 1) |divisor| {
        if (divisor == 1) continue;
        if (divisor >= val) {
            break;
        }

        while (@mod(val, divisor) == 0) {
            try result.append(@as(u64, divisor));
            val /= divisor;
        }
    }
    if (val != 1) {
        try result.append(val);
    }
    return try result.toOwnedSlice();
}
