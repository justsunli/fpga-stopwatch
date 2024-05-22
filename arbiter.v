module arbiter (
    input wire clk,
    input wire reset,
    input wire start,
    output reg enable_pause,
    output reg enable_count,
    output reg [1:0] state
);
    // Arbiter logic here

    // State encoding
    parameter DEFAULT = 2'b00, COUNTING = 2'b01, PAUSED = 2'b10;  

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= DEFAULT;
        end else begin
            case (state)
                DEFAULT: begin
                    if (start) state <= COUNTING;
                end
                COUNTING: begin
                    if (!start) state <= PAUSED;
                end
                PAUSED: begin
                    if (start) state <= COUNTING;
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            DEFAULT: begin
                enable_pause = 0;
                enable_count = 0;
            end
            COUNTING: begin
                enable_pause = 0;
                enable_count = 1;
            end
            PAUSED: begin
                enable_pause = 1;
                enable_count = 0;
            end
        endcase
    end

endmodule