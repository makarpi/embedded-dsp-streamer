// ---------------------------------------------
// Generic ROM for NCO LUT
// ---------------------------------------------
module nco_rom #(
    parameter ADDR_WIDTH = 10,        // 1024 samples
    parameter DATA_WIDTH = 12
)(
    input  wire                     clk,
    input  wire [ADDR_WIDTH-1:0]    addr,
    output reg  [DATA_WIDTH-1:0]    dout
);

    reg [DATA_WIDTH-1:0] rom [0:(1<<ADDR_WIDTH)-1];

    initial begin
        $readmemh("sine1024.hex", rom);
    end

    always @(posedge clk) begin
        dout <= rom[addr];
    end

endmodule
