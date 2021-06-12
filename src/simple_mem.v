`include "include.vh"
module simple_mem (
    input reset,
    input `DUAL dual_address `POINTER, // needs stronger macro?
    input `DUAL dual_byte `BYTE,
)
endmodule