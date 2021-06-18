`include "defs.svh"
/* verilator lint_off UNOPT */
/* verilator lint_off UNOPTFLAT */
module bus #(
    parameter N = 2,
    parameter INPUT = `size,
    parameter OUTPUT = `size
) (
    input reset,
    input Dual user_input [N-1:0][INPUT-1:0],
    output Dual user_output [N-1:0][INPUT-1:0],
    output Dual in [INPUT-1:0],
    input Dual out [OUTPUT-1:0]
);
    reg [$clog2(N)-1:0] user;
    reg running = `false;

    Dual previous_out [OUTPUT-1:0];
    logic done_out;
    done #(OUTPUT) d0 (previous_out, out, done_out);
    Dual previous_user_input [N-1:0][INPUT-1:0];
    logic [N-1:0] done_user_input;
    done_n #(N, INPUT) d1 (user_input, previous_user_input, done_user_input);

    /* verilator lint_off WIDTH */
    always @(reset, done_out, done_user_input) begin
        if (reset) begin
            running = `false;
            previous_user_input = user_input;
            previous_out = out;
        end else if (done_out && running) begin
            running = `false;
            previous_out = out;
            `copyDualArrayBlock(user_output[user], previous_out, out)
        end else if (!running && done_out) begin // unexpected state
            // auto fixing ...
            previous_out = out;
        end else if (!running) begin
            reg [$clog2(N)-1:0] new_user;
            for (int i=0;i<N;i++) begin
                if (done_user_input[i]) begin
                    new_user = i;
                end
            end
            user = new_user;
            running = `true;
            `copyDualArrayBlock1(in, previous_user_input[user], user_input[user])
        end
    end
endmodule