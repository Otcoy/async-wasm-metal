`define DUAL [1:0]
`define DUAL_WRITE(dual, value) if (value) begin dual[1] <= ~dual[1]; end else begin dual[0] <= ~dual[0]; end
module dual_and (
    input reset,
    input `DUAL dual_x,
    input `DUAL dual_y,
    output reg `DUAL dual_result); // result / acknowledge the user that new data can be inputed

    reg `DUAL previous_x;
    reg `DUAL previous_y;

    assign input_done = dual_x != previous_x || dual_y != previous_y;
    assign input_x = dual_x[1] != previous_x[1];
    assign input_y = dual_y[1] != previous_y[1];
    assign result = input_x && input_y;

    always @(posedge reset, posedge input_done) begin
        if (reset) begin
            previous_x <= dual_x;
            previous_y <= dual_y;
        end else if (input_done) begin
            `DUAL_WRITE(dual_result, result);
            previous_x <= dual_x;
            previous_y <= dual_y;
        end
    end

endmodule