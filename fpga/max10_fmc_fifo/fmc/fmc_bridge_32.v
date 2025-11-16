module fmc_bridge_32 (
    input  wire        clk,
    input  wire        reset,

    // FMC interface (32-bit async)
    input  wire [15:0] fmc_addr,
    inout  wire [31:0] fmc_data,
    input  wire  [3:0] fmc_nbl,    // byte lanes
    input  wire        fmc_ne,     // active LOW
    input  wire        fmc_noe,    // read strobe (active LOW)
    input  wire        fmc_nwe,    // write strobe (active LOW)
    output wire        fmc_nwait,  // always ready

    // FPGA registers
    output reg [31:0]  reg0,
    output reg [31:0]  reg1,
    input  wire [31:0] status0,
    input  wire [31:0] status1
);

// internal read multiplexer 
reg [31:0] read_data;

// Write logic (STM32 -> FPGA)
always @(posedge fmc_nwe or posedge reset) begin
    if (reset) begin
        reg0 <= 32'd0;
        reg1 <= 32'd0;
    end else if (!fmc_ne) begin
        case (fmc_addr[3:0])
            4'h0: reg0 <= fmc_data;
            4'h1: reg1 <= fmc_data;
        endcase
    end
end

// Read logic (FPGA -> STM32)
always @(posedge fmc_noe or posedge reset) begin
    if (reset)
        read_data <= 32'd0;
    else if (!fmc_ne)
        case (fmc_addr[3:0])
            4'h0: read_data <= reg0;
            4'h1: read_data <= reg1;
            4'h2: read_data <= status0;
            4'h3: read_data <= status1;
            default: read_data <= 32'hDEAD_BEEF;
        endcase
end

assign fmc_data = (!fmc_ne && !fmc_noe) ? read_data : 32'bz;
assign fmc_nwait = 1'b1;

endmodule
