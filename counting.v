`timescale 1ns / 1ps


module counting (
    input clk_1hz,
    input clk_2hz,
    input enable,
    input enable_pause,
    input reset,
    input sel,
    input adj,
    output reg [5:0] seconds,  // 6-bit for seconds (0-59)
    output reg [5:0] minutes   // 6-bit for minutes (0-59)
);

wire clk;

adjust adjust1(.adj(adj), .clock_1hz(clk_1hz), .clock_2hz(clk_2hz), .selected_clock(clk));

always @(posedge clk or posedge reset) begin
    $display("counting: enable_count: %b", enable);
    if (reset) 
    begin
        $display("reset is on");
        seconds <= 0;
        minutes <= 0;
    end
    else if (enable)
    begin
        $display("enable is on");
        
        if (adj)
        begin
            if (sel) // seconds selected
            begin
                if (seconds == 59) begin
                    seconds <= 0;
                end
                else begin
                    seconds <= seconds + 1;
                end
            end
            else begin // minutes selected
                if (minutes == 59) begin
                    minutes <= 0;
                end
                else begin
                    minutes <= minutes + 1;
                end
                
            end
        end
        else if (minutes == 59 && seconds == 59) begin
          seconds <= 0;
          minutes <= 0;
          $display("increment: minutes is: %d", minutes);
        end
        else if (minutes != 59 && seconds == 59) begin
          seconds <= 0;
          minutes <= minutes + 1;
          $display("increment: minutes is: %d", minutes);
        end
        else begin
          seconds <= seconds + 1;
          $display("seconds is: %d",seconds);
          $display("minutes is: %d", minutes);
        end
    end 
    else if (enable_pause) begin
        minutes = minutes;
        seconds = seconds;
    end


endmodule
