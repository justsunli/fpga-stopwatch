module display_controller (
    input wire clk,
    input wire reset,
    input wire [3:0] minutes_tens,
    input wire [3:0] minutes_units,
    input wire [3:0] seconds_tens,
    input wire [3:0] seconds_units,
    output reg [3:0] anode,
    output reg [6:0] segments
);

    reg [1:0] digit_select;
    reg [3:0] digit;

    // Multiplexing between the four digits
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digit_select <= 0;
            anode <= 4'b1110; // Initially enable the rightmost digit
        end else begin
            digit_select <= digit_select + 1;
            case (digit_select)
                2'b00: begin
                    digit <= seconds_units;
                    anode <= 4'b1110;
                end
                2'b01: begin
                    digit <= seconds_tens;
                    anode <= 4'b1101;
                end
                2'b10: begin
                    digit <= minutes_units;
                    anode <= 4'b1011;
                end
                2'b11: begin
                    digit <= minutes_tens;
                    anode <= 4'b0111;
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
