`include "include.vh"
module input_done #(parameter BITS = 64) (
    input `DUAL previous [BITS-1:0],
    input `DUAL dual [BITS-1:0],
    output reg done);

    integer i;
    always @* begin
        done = dual[0] != previous[0];
        for (i=1; i<BITS; i++) begin
            done = done && (dual[i] != previous[i]);
        end
    end
endmodule