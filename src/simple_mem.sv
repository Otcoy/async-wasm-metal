`include "defs.svh"
module simple_mem #(
    // 65k
    parameter BYTES = 65536,
    parameter ADDR = $clog2(BYTES)
) (
    input reset,
    input Dual isWrite,
    input Dual addr `array(ADDR),
    input Dual in `byte_t,
    output Dual out `byte_t
);

    logic `byte_t mem `array(BYTES);

    Dual previous_addr `array(ADDR);
    logic done_addr;
    done #(ADDR) d0 (addr, previous_addr, done_addr);
    Dual previous_in `byte_t;
    logic done_in;
    done #(`byte) d1 (in, previous_in, done_in);
    Dual previous_isWrite;
    logic done_isWrite = previous_isWrite != isWrite;
    logic in_isWrite = `readDual(previous_isWrite, isWrite);
    logic done_all = done_isWrite && (in_isWrite ? (done_addr && done_in): done_addr);

    logic `array(ADDR) in_addr;
    always_comb begin
        `readDualToArrayBlock(in_addr, addr, previous_addr)
    end

    // quite unsafe
    logic `byte_t in_in;
    always_comb begin
        `readDualToArrayBlock(in_in, in, previous_in)
    end

    logic `byte_t value = mem[in_addr];

    always @(posedge reset, posedge done_all) begin
        if (!reset && done_all) begin
            if (in_isWrite) begin
                mem[in_addr] <= in_in;
                `writeArrayDualNonBlock(out, in_in)
            end else begin
                `writeArrayDualNonBlock(out, value);
            end
        end
        if (reset || done_all) begin
            previous_addr <= addr;
            previous_in <= in;
            previous_isWrite <= isWrite;
        end
    end

endmodule
