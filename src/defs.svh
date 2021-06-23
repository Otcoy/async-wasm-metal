`ifndef _DEFS_H
`define _DEFS_H

typedef struct packed {
    bit high;
    bit low;
} Dual;
`define writeDualNonBlock(dual, value) if (value) begin dual.high <= ~dual.high; end else begin dual.low <= ~dual.low; end
`define writeDualBlock(dual, value) if (value) begin dual.high = ~dual.high; end else begin dual.low = ~dual.low; end
`define writeArrayDualNonBlock(dual, value) foreach (value[_macro_internal_iter_]) begin `writeDualNonBlock(dual[_macro_internal_iter_], value[_macro_internal_iter_]) end
`define writeArrayDualBlock(dual, value) foreach (value[_macro_internal_iter_]) begin `writeDualBlock(dual[_macro_internal_iter_], value[_macro_internal_iter_]) end
`define readDual(dual, previous) (dual.high != previous.high)
`define readDualToArrayNonBlock(arr, val0, val1) foreach (val1[_macro_internal_iter_]) begin arr[_macro_internal_iter_] <= `readDual(val0[_macro_internal_iter_], val1[_macro_internal_iter_]); end
`define readDualToArrayBlock(arr, val0, val1) foreach (val1[_macro_internal_iter_]) begin arr[_macro_internal_iter_] = `readDual(val0[_macro_internal_iter_], val1[_macro_internal_iter_]); end
`define copyDualArrayNonBlock(mut, val0, val1) foreach (val1[_macro_internal_iter_]) begin `writeDualNonBlock(mut[_macro_internal_iter_], `readDual(val0[_macro_internal_iter_], val1[_macro_internal_iter_])) end
// foreach val1
`define copyDualArrayBlock(mut, val0, val1) foreach (val1[_macro_internal_iter_]) begin `writeDualBlock(mut[_macro_internal_iter_], `readDual(val0[_macro_internal_iter_], val1[_macro_internal_iter_])) end
// foreach mut
`define copyDualArrayBlock1(mut, val0, val1) foreach (mut[_macro_internal_iter_]) begin `writeDualBlock(mut[_macro_internal_iter_], `readDual(val0[_macro_internal_iter_], val1[_macro_internal_iter_])) end
`define true 1
`define false 0
`define array(n) [n-1:0]
`define size 64
`define size_t `array(`size)
`define byte 8
`define byte_t `array(`byte)
// n+1 - consider v=n  v++ -> v=n+1
`define fromZeroToConst(n, v) for (reg `array($clog2(n+1)) v=0;v<n;v++)

// WASM
typedef byte unsigned u8_t;
typedef byte signed i8_t;
typedef shortint unsigned u16_t;
typedef shortint signed i16_t;
typedef int unsigned u32_t;
typedef int signed i32_t;
typedef longint unsigned u64_t;
typedef longint signed i64_t;

`endif
/* verilator lint_off WIDTH */