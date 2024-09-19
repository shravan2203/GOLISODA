`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.09.2024 16:38:33
// Design Name: 
// Module Name: mem
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

module mem(
    input clk, rst, rd, wr,         // Clock, reset, read, and write signals
    input [7:0] Datain,             // 8-bit data input
    input [3:0] addr,               // 4-bit address input (11 registers)
    output reg [7:0] Dataout        // 8-bit data output
);

reg [7:0] memory [10:0];           // 11 registers, each 8-bit wide
integer i;                         // Declare loop variable at top level

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i <= 10; i = i + 1) begin
            memory[i] <= 8'b0;     // Reset all registers to 0
        end
        Dataout <= 8'b0;           // Reset output to 0
    end else if (wr) begin
        memory[addr] <= Datain;    // Write data to selected register
    end else if (rd) begin
        Dataout <= memory[addr];   // Read data from selected register
    end
end

endmodule
