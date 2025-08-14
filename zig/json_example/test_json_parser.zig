const std = @import("std");
const test_allocator = std.testing.allocator;

test "parse json" {
    var out = std.ArrayList(u8).init(test_allocator);
    defer out.deinit();

    const stdout = std.io.getStdOut();

    try std.json.stringify(.{
        .name = "abel",
    }, .{}, stdout.writer());

    // std.debug.print("{s}\n", .{out.items});
}
