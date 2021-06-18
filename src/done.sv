`include "defs.svh"
module done #(
    parameter BITS = `size
) (
    input Dual previous [BITS-1:0],
    input Dual current [BITS-1:0],
    output done
);

    always_comb begin
        reg i = 1;
        foreach (previous[iter]) begin
            i = i && previous[iter] != current[iter];
        end
        done = i;
    end

endmodule