`define DUAL [1:0]
`define DUAL_WRITE(dual, value) if (value) begin dual[1] <= ~dual[1]; end else begin dual[0] <= ~dual[0]; end
`define POINTER [63:0]
`define BYTE [7:0]