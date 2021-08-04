`include "defs.svh"
module done #(
    parameter BITS = `size
) (
    input Dual val0 [BITS-1:0],
    input Dual val1 [BITS-1:0],
    output yes
);

    always_comb begin
        reg i = 1;
        foreach (val0[iter]) begin
            i = i && val0[iter] != val1[iter];
        end
        yes = i;
    end

endmodule