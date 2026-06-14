const std = @import("std");
const Writer = std.Io.File.Writer;

pub fn main(init: std.process.Init) !void {
    // self explanatory, for stdout
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = Writer.init(std.Io.File.stdout(), init.io, &stdout_buffer);
    
    // my test var i wanted to test discarding
    const testvar: i32 = 1;
    const stdout = &stdout_writer.interface;
    
    // for (iterator) |closure unit you want to capture| works similar to range.into_iter().map(|v|), where you can discard closure unit with _ = v
    for (0..5) |val| { 
        // discard val
        _ = val;
        try stdout.print(testvar);
    }

    // cannot discard testvar later like so (i tested this)
    // _ = testvar
    
    try stdout.print("Hello, {s}!\n", .{"world"});
    try stdout.flush();
}
