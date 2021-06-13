typedef struct packed {
    bit high;
    bit low;
} Dual;
`define writeDualNonBlock(dual, value) if (value) begin dual.high <= ~dual.high; end else begin dual.low <= ~dual.low; end
module dual_and (
    input reset,
    input Dual dual_x,
    input Dual dual_y,
    output Dual dual_result);

    reg Dual previous_x;
    reg Dual previous_y;

    assign input_done = dual_x != previous_x && dual_y != previous_y;
    assign input_x = dual_x.high != previous_x.high;
    assign input_y = dual_y.high != previous_y.high;

    always @(posedge reset, posedge input_done) begin
        if (reset) begin
            previous_x <= dual_x;
            previous_y <= dual_y;
        end else if (input_done) begin
            `writeDualNonBlock(dual_result, input_x && input_y);
            previous_x <= dual_x;
            previous_y <= dual_y;
        end
    end

endmodule