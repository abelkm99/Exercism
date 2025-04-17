const std = @import("std");
const mem = std.mem;

pub fn toRna(allocator: mem.Allocator, dna: []const u8) mem.Allocator.Error![]const u8 {
    var result = std.ArrayList(u8).init(allocator);
    
    for (dna) |s| {
        const v: u8 = switch (s) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => 'a',
        };
        try result.append(v);
    }
    return result.toOwnedSlice();
}
