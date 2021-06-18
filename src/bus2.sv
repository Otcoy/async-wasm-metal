`include "defs.svh"
module bus2 #(
    parameter INPUT = `size,
    parameter OUTPUT = `size
) (
    input reset,
    input Dual user0_input [INPUT-1:0],
    input Dual user1_input [INPUT-1:0],
    output Dual user0_output [OUTPUT-1:0],
    output Dual user1_output [OUTPUT-1:0],
    output Dual in [INPUT-1:0],
    input Dual out [OUTPUT-1:0]
);
    reg user;
    reg idle = 1;

    Dual previous_user0_input [INPUT-1:0];
    reg done_user0_input;
    done #(INPUT) d0 (previous_user0_input, user0_input, done_user0_input);
    Dual previous_user1_input [INPUT-1:0];
    reg done_user1_input;
    Dual previous_out [OUTPUT-1:0];
    reg done_out;


    always @(posedge reset) begin
        if (reset) begin
            idle <= 1;
            previous_user0_input <= user0_input;
            previous_user1_input <= user1_input;
            previous_out <= out;
        end
    end
endmodule