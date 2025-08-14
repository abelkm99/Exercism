const std = @import("std");
pub fn encode(buffer: []u8, string: []const u8) []u8 {
    var i: u16 = 0;
    var idx: usize = 0;
    while (i < string.len) {
        var j: u16 = i;
        // while they are the same
        while (j < string.len and string[i] == string[j]) : (j += 1) {}

        if (j - i == 1) {
            buffer[idx] = string[i];
            idx += 1;
            i = j;
            continue;
        }

        const res = std.fmt.bufPrint(
            buffer[idx..],
            "{d}{c}",
            .{ j - i, string[i] },
        ) catch unreachable;
        idx += res.len; // buffer is now at position of idx;
        i = j; // start from j next time
    }
    return buffer[0..idx];
}

pub fn decode(buffer: []u8, string: []const u8) []u8 {
    var i: u16 = 0;
    var idx: usize = 0;
    while (i < string.len) {
        var j: u16 = i;
        while (j < string.len and string[j] >= '0' and string[j] <= '9') : (j += 1) {}
        if (j == i) {
            // mean's its the same charachter
            buffer[idx] = string[i];
            i += 1;
            idx += 1;
            continue;
        }
        const n = std.fmt.parseInt(u16, string[i..j], 10) catch unreachable;
        for (0..n, idx..) |_, k| {
            buffer[k] = string[j];
        }
        // temp this a
        idx += n;
        i = j + 1;
    }

    return buffer[0..idx];
}
