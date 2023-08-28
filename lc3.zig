const std = @import("std");

const memory_size = 1 << 16;
const program_start = 0x3000;

const Reg = enum(u16) { R0 = 0, R1, R2, R3, R4, R5, R6, R7, PC, COND, COUNT };

const Op = enum(u16) { BR = 0, ADD, LD, ST, JSR, AND, LDR, STR, RTI, NOT, LDI, STI, JMP, RES, LEA, TRAP };

const Flags = enum(u16) {
    POS = 1 << 0,
    ZRO = 1 << 1,
    NEG = 1 << 2,
};

const VM = struct {
    memory: [memory_size]u16 = undefined,
    reg: [@intFromEnum(Reg.COUNT)]u16 = undefined,
    run: bool = false,

    pub fn init() VM {
        var vm = VM{};

        vm.memory = [_]u16{0} ** memory_size;
        vm.reg = [_]u16{0} ** @intFromEnum(Reg.COUNT);

        vm.reg[@intFromEnum(Reg.PC)] = program_start;
        vm.reg[@intFromEnum(Reg.COND)] = @intFromEnum(Flags.ZRO);

        return vm;
    }

    pub fn start(self: *VM) void {
        self.run = true;

        //        while (self.run) {
        const program_counter = self.reg[@intFromEnum(Reg.PC)];
        const instruction = self.memory[program_counter];

        const op: Op = @enumFromInt(instruction >> 12);
        switch (op) {
            .ADD => self.op_add(instruction),
            else => {},
        }

        self.reg[@intFromEnum(Reg.PC)] = self.reg[@intFromEnum(Reg.PC)] + 1;
        //       }
    }

    pub fn op_add(self: *VM, program_counter: u16) void {
        _ = self;
        _ = program_counter;
        std.log.info("ADD", .{});
    }
};

pub fn main() void {
    var vm = VM.init();

    vm.memory[program_start] = 0x1240;
    vm.memory[program_start + 1] = 0;

    std.log.info("PC: {}", .{vm.reg[@intFromEnum(Reg.PC)]});
    vm.start();

    std.log.info("PC: {}", .{vm.reg[@intFromEnum(Reg.PC)]});
    vm.start();
}
