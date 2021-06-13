`include "include.vh"
module simple_mem (
    input reset,
    input `DUAL dual_address `POINTER, // needs stronger macro? but it could be hard to design a hdl
    input `DUAL dual_byte `BYTE);

    reg `DUAL previous_address `POINTER;
    reg done_address;
    input_done #(BITS = `POINTER_BITS) id0 (.dual(dual_address), .previous(previous_address), .done(done_address));
endmodule