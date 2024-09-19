`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 16:38:59
// Design Name: 
// Module Name: mem_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_tb;

// Testbench Signals
reg clk;                            // Clock signal
reg rst;                            // Reset signal
reg rd;                             // Read signal
reg wr;                             // Write signal
reg [7:0] Datain;                   // 8-bit data input
reg [3:0] addr;                     // 4-bit address input
wire [7:0] Dataout;                 // 8-bit data output

// Instantiate the design under test (DUT)
mem dut (
    .clk(clk),
    .rst(rst),
    .rd(rd),
    .wr(wr),
    .Datain(Datain),
    .addr(addr),
    .Dataout(Dataout)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;          // Generate a clock with a period of 10 ns
end

// Test sequence
initial begin
    // Initialize signals
    rst = 1; wr = 0; rd = 0; Datain = 8'b0; addr = 4'b0;
    
    #10 rst = 0;                    // Release reset after 10 ns
    
    // Test case 1: Write data to register 0
    #10 Datain = 8'b10101010;      // Set input data to 0xAA
        addr = 4'b0000;             // Select register 0
        wr = 1; rd = 0;             // Write enable
    #10 wr = 0;                     // Disable write after 10 ns
    
    // Test case 2: Read data from register 0
    #10 rd = 1;                     // Read enable
    #10 rd = 0;                     // Disable read after 10 ns
    
    // Test case 3: Write data to register 10
    #10 Datain = 8'b11110000;      // Set input data to 0xF0
        addr = 4'b1010;             // Select register 10
        wr = 1; rd = 0;             // Write enable
    #10 wr = 0;                     // Disable write after 10 ns
    
    // Test case 4: Read data from register 10
    #10 rd = 1;                     // Read enable
    #10 rd = 0;                     // Disable read after 10 ns
    
    // Test case 5: Reset the system
    #10 rst = 1;                    // Assert reset
    #10 rst = 0;                    // Deassert reset
    
    #10 $stop;                      // End of simulation
end

endmodule
