const std = @import("std");

const MyTuple = std.meta.Tuple(&.{ []const u8, u32 });

const arr = [_]MyTuple{
    MyTuple{ "aeioulnrst", 1 },
    MyTuple{ "dg", 2 },
    MyTuple{ "bcmp", 3 },
    MyTuple{ "fhvwy", 4 },
    MyTuple{ "k", 5 },
    MyTuple{ "jx", 8 },
    MyTuple{ "qz", 10 },
};
pub fn score(s: []const u8) u32 {
    var map: [26]u32 = undefined;
    @memset(&map, 0);

    for (arr) |t| {
        for (t[0]) |c| {
            const lower = std.ascii.toLower(c);
            map[lower - 'a'] = t[1];
        }
    }

    var ans: u32 = 0;
    for (s) |c| {
        const lower = std.ascii.toLower(c);
        ans += map[lower - 'a'];
    }

    return ans;
}
