const std = @import("std");
const mem = std.mem;

/// Returns the set of strings in `candidates` that are anagrams of `word`.
/// Caller owns the returned memory.
fn toSmallLetter(
    alloc: mem.Allocator,
    org: []const u8,
) ![]u8 {
    var result = std.ArrayList(u8).init(alloc);
    defer result.deinit();
    for (0..org.len) |i| {
        try result.append(std.ascii.toLower(org[i]));
    }
    return try result.toOwnedSlice();
}

fn check_duplicate(arr1: []const u8, arr2: []const u8) bool {
    var org: [26]i8 = undefined;
    @memset(&org, 0);
    if (arr1.len != arr2.len) {
        return false;
    }
    for (arr1) |v| {
        org[v - 'a'] += 1;
    }

    for (arr2) |v| {
        org[v - 'a'] -= 1;
    }

    for (org) |a| {
        if (a != 0) {
            return false;
        }
    }

    return true;
}

pub fn detectAnagrams(
    allocator: mem.Allocator,
    word: []const u8,
    candidates: []const []const u8,
) !std.BufSet {
    var res = std.BufSet.init(allocator);
    const org_small = try toSmallLetter(allocator, word);

    defer {
        allocator.free(org_small);
    }

    for (candidates) |candidate| {
        const sm = try toSmallLetter(allocator, candidate);
        defer {
            allocator.free(sm);
        }
        if (std.mem.eql(u8, org_small, sm)) {
            continue;
        }
        if (check_duplicate(org_small, sm)) {
            try res.insert(candidate);
        }
        // check if two strings are the same
        // const val = try hash_map.getOrPut(sm);
    }

    return res;
}
