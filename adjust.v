`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2024 02:05:39 PM
// Design Name: 
// Module Name: adjust
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


module adjust(input adj, input clock_1hz, input clock_2hz, output selected_clock);
wire adj;
wire clock_1hz;
wire clock_2hz;
reg selected_clock;

always@(*)begin
    if (adj)begin
        selected_clock <= clock_2hz;
    end
    else begin
        selected_clock <= clock_1hz;
    end


end



endmodule