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
    reg running = `false;

    Dual previous_user0_input [INPUT-1:0];
    logic done_user0_input;
    done #(INPUT) d0 (previous_user0_input, user0_input, done_user0_input);
    Dual previous_user1_input [INPUT-1:0];
    logic done_user1_input;
    done #(INPUT) d1 (previous_user1_input, user1_input, done_user1_input);
    Dual previous_out [OUTPUT-1:0];
    logic done_out;
    done #(INPUT) d2 (previous_out, out, done_out);

    always @(posedge reset, posedge done_out, negedge done_out, posedge done_user0_input, posedge done_user1_input) begin
        if (reset) begin
            running <= `false;
            previous_user0_input <= user0_input;
            previous_user1_input <= user1_input;
            previous_out <= out;
        end else if (done_out && running) begin
            running <= `false;
            previous_out <= out;
            if (user == 1) begin
                `copyDualArrayNonBlock(user1_output, previous_out, out)
            end else begin
                `copyDualArrayNonBlock(user0_output, previous_out, out)
            end
        end else if (!running && done_out) begin // unexpected state
            // auto fixing ...
            previous_out <= out;
        end else if (!running && done_user0_input) begin
            user <= 0;
            running <= `true;
            `copyDualArrayNonBlock(in, previous_user0_input, user0_input)
        end else if (!running && done_user1_input) begin
            user <= 1;
            running <= `true;
            `copyDualArrayNonBlock(in, previous_user1_input, user1_input)
        end
    end
endmodule