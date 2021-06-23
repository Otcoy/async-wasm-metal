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

// Opcodes
`define op_unreachable   8'h00
`define op_nop           8'h01
`define op_block         8'h02
`define op_loop          8'h03
`define op_if            8'h04
`define op_else          8'h05
`define op_end           8'h0b
`define op_br            8'h0c
`define op_br_if         8'h0d
`define op_br_table      8'h0e
`define op_return        8'h0f
`define op_call          8'h10
`define op_call_indirect 8'h11
`define op_drop          8'h1a
`define op_select        8'h1b
`define op_local_get     8'h20
`define op_local_set     8'h21
`define op_local_tee     8'h22
`define op_global_get    8'h23
`define op_global_set    8'h24
`define op_i32_load      8'h28
`define op_i64_load      8'h29
`define op_f32_load      8'h2a
`define op_f64_load      8'h2b
`define op_i32_load8_s   8'h2c
`define op_i32_load8_u   8'h2d
`define op_i32_load16_s  8'h2e
`define op_i32_load16_u  8'h2f
`define op_i64_load8_s   8'h30
`define op_i64_load8_u   8'h31
`define op_i16_load16_s  8'h32
`define op_i16_load16_u  8'h33
`define op_i16_load32_s  8'h34
`define op_i16_load32_u  8'h35
`define op_i32_store     8'h36
`define op_i64_store     8'h37
`define op_f32_store     8'h38
`define op_f64_store     8'h39
`define op_i32_store8    8'h3a
`define op_i32_store16   8'h3b
`define op_i64_store8    8'h3c
`define op_i64_store16   8'h3d
`define op_i16_store32   8'h3e
`define memory_size      8'h3f
`define memory_grow      8'h40
`define op_i32_const     8'h41
`define op_i64_const     8'h42
`define op_f32_const     8'h43
`define op_f64_const     8'h44
`define op_i32_eqz       8'h45
`define op_i32_eq        8'h46
`define op_i32_ne        8'h47
`define op_i32_lt_s      8'h48
`define op_i32_lt_u      8'h49
`define op_i32_gt_s      8'h4a
`define op_i32_gt_u      8'h4b
`define op_i32_le_s      8'h4c
`define op_i32_le_u      8'h4d
`define op_i32_ge_s      8'h4e
`define op_i32_ge_u      8'h4f
`define op_i64_eqz       8'h50
`define op_i64_eq        8'h51
`define op_i64_ne        8'h52
`define op_i64_lt_s      8'h53
`define op_i64_lt_u      8'h54
`define op_i64_gt_s      8'h55
`define op_i64_gt_u      8'h56
`define op_i64_le_s      8'h57
`define op_i64_le_u      8'h58
`define op_i64_ge_s      8'h59
`define op_i64_ge_u      8'h5a
`define op_f32_eq        8'h5b
`define op_f32_ne        8'h5c
`define op_f32_lt        8'h5d
`define op_f32_gt        8'h5e
`define op_f32_le        8'h5f
`define op_f32_ge        8'h60
`define op_f64_eq        8'h61
`define op_f64_ne        8'h62
`define op_f64_lt        8'h63
`define op_f64_gt        8'h64
`define op_f64_le        8'h65
`define op_f64_ge        8'h66
`define op_i32_clz       8'h67
`define op_i32_ctz       8'h68
`define op_i32_popcnt    8'h69
`define op_i32_add       8'h6a
`define op_i32_sub       8'h6b
`define op_i32_mul       8'h6c
`define op_i32_div_s     8'h6d
`define op_i32_div_u     8'h6e
`define op_i32_rem_s     8'h6f
`define op_i32_rem_u     8'h70
`define op_i32_and       8'h71
`define op_i32_or        8'h72
`define op_i32_xor       8'h73
`define op_i32_shl       8'h74
`define op_i32_shr_s     8'h75
`define op_i32_shr_u     8'h76
`define op_i32_rotl      8'h77
`define op_i32_rotr      8'h78
`define op_i64_clz       8'h79
`define op_i64_ctz       8'h7a
`define op_i64_popcnt    8'h7b
`define op_i64_add       8'h7c
`define op_i64_sub       8'h7d
`define op_i64_mul       8'h7e
`define op_i64_div_s     8'h7f
`define op_i64_div_u     8'h80
`define op_i64_rem_s     8'h81
`define op_i64_rem_u     8'h82
`define op_i64_and       8'h83
`define op_i64_or        8'h84
`define op_i64_xor       8'h85
`define op_i64_shl       8'h86
`define op_i64_shr_s     8'h87
`define op_i64_shr_u     8'h88
`define op_i64_rotl      8'h89
`define op_i64_rotr      8'h8a
`define op_f32_abs       8'h8b
`define op_f32_neg       8'h8c
`define op_f32_ceil      8'h8d
`define op_f32_floor     8'h8e
`define op_f32_trunc     8'h8f
`define op_f32_nearest   8'h90
`define op_f32_sqrt      8'h91
// ...

`endif
/* verilator lint_off WIDTH */