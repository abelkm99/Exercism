const std = @import("std");

pub fn check(arr: []const u8) ?[10]u8 {
    if (arr.len != 10) {
        return null;
    }
    if (arr[0] == '0' or arr[3] == '0' or arr[3] == '1' or arr[0] == '1') {
        return null;
    }
    var ans: [10]u8 = undefined;
    @memcpy(&ans, arr[0..10]);
    return ans;
}
pub fn clean(phrase: []const u8) ?[10]u8 {
    // _ = phrase;
    var nums: [100]u8 = undefined;
    @memset(&nums, 0);

    var i: usize = 0;
    for (phrase) |d| {
        if (d <= '9' and d >= '0') {
            nums[i] = d;
            i += 1;
        }
    }
    if (i >= 12) return null;
    const data = nums[0..i];
    if (nums[0] == '1') {
        return check(data[1..i]);
    }
    return check(data[0..i]);
}
