const std = @import("std");
fn get_value(num: u32, small: bool) []const u8 {
    switch (num) {
        10 => return if (!small) "Ten" else "ten",
        9 => return if (!small) "Nine" else "nine",
        8 => return if (!small) "Eight" else "eight",
        7 => return if (!small) "Seven" else "seven",
        6 => return if (!small) "Six" else "six",
        5 => return if (!small) "Five" else "five",
        4 => return if (!small) "Four" else "four",
        3 => return if (!small) "Three" else "three",
        2 => return if (!small) "Two" else "two",
        1 => return if (!small) "One" else "one",
        else => return if (!small) "No" else "no",
    }
}

pub fn recite(buffer: []u8, start_bottles: u32, take_down: u32) []const u8 {
    const lyrics: []const u8 =
        \\{s} green bottle{s} hanging on the wall,
        \\{0s} green bottle{1s} hanging on the wall,
        \\And if one green bottle should accidentally fall,
        \\There'll be {s} green bottle{s} hanging on the wall.
    ;

    var i: u32 = 0;
    var count: usize = 0;
    _ = &count;
    while (i < take_down) {
        const rem = start_bottles - i;
        const res = std.fmt.bufPrint(
            buffer[count..],
            lyrics,
            .{
                get_value(rem, false),
                (if (rem > 1) "s" else ""),
                get_value(rem - 1, true),
                (if ((rem - 1) != 1) "s" else ""),
            },
        );

        if (res) |c| {
            count += c.len;
        } else |_| unreachable;

        if (i + 1 < take_down) {
            if (std.fmt.bufPrint(buffer[count..], "\n\n", .{})) |c| {
                count += c.len;
            } else |_| unreachable;
        }
        i += 1;
    }

    return buffer[0..count];
}
