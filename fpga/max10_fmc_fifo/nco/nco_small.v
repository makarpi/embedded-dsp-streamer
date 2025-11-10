// ---------------------------------------------
// Simple NCO with external LUT (1024 entries)
// phase accumulator: 32-bit
// LUT address: top 10 bits of phase
// LUT output: 12-bit signed
// LUT file: sine1024.hex
// ---------------------------------------------

module nco_small (
    input  wire         clk,
    input  wire         reset,
    input  wire [31:0]  phase_inc,
    output wire [11:0]  nco_out
);

    // 32-bit phase accumulator
    reg [31:0] phase_acc;

    always @(posedge clk or posedge reset) begin
        if (reset)
            phase_acc <= 32'd0;
        else
            phase_acc <= phase_acc + phase_inc;
    end

    // We use top 10 bits (31 downto 22) for 1024-entry LUT
    wire [9:0] addr = phase_acc[31:22];

    // Instantiate ROM with 1024 sine values
    nco_rom #(
        .ADDR_WIDTH(10),
        .DATA_WIDTH(12)
    ) lut_inst (
        .clk(clk),
        .addr(addr),
        .dout(nco_out)
    );

endmodule
