`include "defs.svh"
module done_n #(
    parameter N = 2,
    parameter BITS = `size
) (
    input Dual val0 [N-1:0][BITS-1:0],
    input Dual val1 [N-1:0][BITS-1:0],
    output [N-1:0] done
);

    /* optimized version
    always_comb begin
        reg [$clog2(N)-1:0] n = ~0;
        do begin
            n = n+1;
            begin
                reg i = `true;
                reg [$clog2(BITS)-1:0] iter = ~0;
                do begin
                    iter = iter+1;
                    i = i && val0[n][iter] != val1[n][iter];
                end while (iter != BITS-1);
                done[n] = i;
            end
        end while (n != N-1);
    end
    */

    always_comb begin
        for (int n=0;n<N;n++) begin
            reg result = `true;
            for (int iter=0;iter<BITS;iter++) begin
                result = result && val0[n][iter] != val1[n][iter];
            end
            done[n] = result;
        end
    end

endmodule