`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/22/2024 02:33:09 PM
// Design Name: 
// Module Name: clock
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


module clock (
    input clk, // master clock: 100,000,000 cycles/sec
    input reset, // need reset as an input?
    output clk2, // 2 Hz clock
    output clk1, // 1 Hz clock, 1 cycle/sec
    output fast_clk, // fast clock
    output blink_clk // blink clock
);
wire clk;
wire reset;
reg [31:0] count2 = 0;
reg [31:0] count1 = 0; 
reg [31:0] fast_count = 0;
reg [31:0] blink_count = 0;
reg clk1 = 0;
reg clk2 = 0;
reg fast_clk = 0;
reg blink_clk = 0;



// 2 Hz clock
always @(posedge clk or posedge reset) begin
    if (reset == 1) 
    begin
        count2 <= 0;
        clk2 <= 0; // or 1?
    end
    else if (count2 == 25000000) begin
        clk2 <= ~clk2;
        count2 <= 0;
    end else begin
        count2 <= count2+1;
    end
end

// 1 Hz clock - 1 cycle per seconds
always @(posedge clk) begin
    $display("clock 1 Hz");
    if (reset == 1) 
    begin
        count1 <= 0;
        clk1 <= 0; 
    end
    else if (count1 == 50000000) begin
        $display("1 Hz clock toggled");
        clk1 <= ~clk1;
        $display("1 Hz clock toggled: %d", clk1);
        count1 <= 0;
    end else begin
        $display("1 Hz clock incremented");
        $display("1 Hz clock count: %d", count1);
        count1 <= count1 +1;
    end
end

// fast clock - 400Hz
always @(posedge clk) begin
    if (reset == 1) 
    begin
        fast_count <= 0;
        fast_clk <= 0; 
    end
    else if (fast_count == 125000) begin
        fast_clk <= ~fast_clk;
        fast_count <= 0;
    end else begin
        fast_count <= fast_count+1;
    end
end

// blink clock
always @(posedge clk) begin
    if (reset == 1) 
    begin
        blink_count <= 0;
        blink_clk <= 0; 
    end else if 
    (blink_count == 1250000) begin
        blink_clk <= ~blink_clk;
        blink_count <= 0;
    end else begin
        blink_count <= blink_count+1;
    end
end

endmodule