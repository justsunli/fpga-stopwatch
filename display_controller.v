`timescale 1ns / 1ps

module display_controller (
    input wire clk,
    input wire blink_clk,
    input wire reset,
    input wire sel,
    input wire adjust,
    input wire [3:0] minutes_tens,
    input wire [3:0] minutes_units,
    input wire [3:0] seconds_tens,
    input wire [3:0] seconds_units,
    output reg [3:0] anode,
    output reg [6:0] segments
);

    reg [1:0] digit_select;
    reg [3:0] digit;
    reg blink;
    
    initial begin
       $display("display controller initializing");
       digit_select <= 2'b00;
       anode <= 4'b1110; // Initially enable the rightmost digit 
    end
    
//    always@(posedge blink_clk, posedge reset) begin
//        if (reset) begin
//            blink <= 0;
//        end
//        else begin
//            blink <= ~blink;
//        end
//    end
    
    // Multiplexing between the four digits
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            digit_select <= 0;
            anode <= 4'b1110; // Initially enable the rightmost digit
        end 
        else
        begin
            digit_select <= digit_select + 1;
            case (digit_select)
                2'b00: begin
                    if (sel && adjust && blink_clk)begin
                        digit <= 4'b1111;
                    end
                    else begin
                        digit <= seconds_units;
                    end
                    anode <= 4'b1110;
                    $display("anode 0: %d", seconds_units);
                end
                2'b01: begin
                    if (sel && adjust && blink_clk)begin
                        digit <= 4'b1111;
                    end
                    else begin
                        digit <= seconds_tens;
                    end
                    anode <= 4'b1101;
                    $display("anode 1: %d", seconds_tens);

                end
                2'b10: begin
                    if (!sel && adjust && blink_clk)
                    begin
                        digit <= 4'b1111;
         
                    end
                    else begin
                       digit <= minutes_units;
                    end
                    anode <= 4'b1011;
                    $display("anode 2: %d", minutes_units);

                end
                2'b11: begin
                    if (!sel && adjust && blink_clk)
                    begin
                        digit <= 4'b1111;
                
                    end
                    else begin
                        digit <= minutes_tens;
                    end
                    anode <= 4'b0111;
                    $display("anode 3: %d", minutes_tens);

                end
            endcase
        end
    end

    // Segment encoding
    always @(*) begin
        case (digit)
            4'd0: segments = 7'b1000000; // 0
            4'd1: segments = 7'b1111001; // 1
            4'd2: segments = 7'b0100100; // 2
            4'd3: segments = 7'b0110000; // 3
            4'd4: segments = 7'b0011001; // 4
            4'd5: segments = 7'b0010010; // 5
            4'd6: segments = 7'b0000010; // 6
            4'd7: segments = 7'b1111000; // 7
            4'd8: segments = 7'b0000000; // 8
            4'd9: segments = 7'b0010000; // 9
            default: segments = 7'b1111111; // Blank
        endcase
    end

endmodule
