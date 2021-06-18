`include "defs.svh"
module bus2 #(
    parameter INPUT = `size;
    parameter OUTPUT = `size;
) (
    input reset,
    input Dual user0_input [INPUT-1:0],
    input Dual user1_input [INPUT-1:0],
    output Dual user0_output [OUTPUT-1:0],
    output Dual user1_output [OUTPUT-1:0],
    output Dual input [INPUT-1:0],
    input Dual output [OUTPUT-1:0]
);
    reg user;
    reg idle = 1;

    reg Dual previous_user0_input [INPUT-1:0];
    reg Dual previous_user1_input [INPUT-1:0];
    reg Dual previous_output [OUTPUT-1:0];

    assign output_ready

    always @(posedge reset) begin
        if (reset) begin
            idle <= 1;
            previous_user0_input <= user0_input;
            previous_user1_input <= user1_input;
            previous_output <= output;
        end
    end
endmodule