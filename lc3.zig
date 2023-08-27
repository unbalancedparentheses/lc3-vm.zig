const std = @import("std");

// TODO
// 1. initialize all the memory space to 0
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
        vm.run = true;

        return vm;
    }
};

pub fn main() !void {
    var vm = VM.init();
    vm;
}
