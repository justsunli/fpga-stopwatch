module display_controller (
    input wire clk,
    input wire reset,
    input wire [3:0] minutes_tens,
    input wire [3:0] minutes_units,
    input wire [3:0] seconds_tens,
    input wire [3:0] seconds_units,
    output reg [3:0] anode,
    output wire [6:0] segments
);

    reg [1:0] digit_select;
    reg [3:0] digit;
    wire [6:0] cathode;

    // Instantiate the display module
    display display_inst (
        .digit(digit),
        .cathode(cathode)
    );

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

    // Drive the segments using the cathode output from the display module
    assign segments = cathode;

endmodule
