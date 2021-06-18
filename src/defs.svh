`ifndef _DEFS_H
`define _DEFS_H

typedef struct packed {
    bit high;
    bit low;
} Dual;
`define writeDualNonBlock(dual, value) if (value) begin dual.high <= ~dual.high; end else begin dual.low <= ~dual.low; end
`define writeDualBlock(dual, value) if (value) begin dual.high = ~dual.high; end else begin dual.low = ~dual.low; end
`define size 64
`define size_t [`size-1:0]

`endif