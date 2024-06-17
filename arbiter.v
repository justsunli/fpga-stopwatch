`timescale 1ns / 1ps


module arbiter (
    input wire clk,
    input wire reset,
    input wire pause_button, //wire pause_button **
    output reg enable_pause,
    output reg enable_count,
    output reg [1:0] state
);
    // Arbiter logic here

//reg pause =0; ***
    reg pause = 0;

    // State encoding
    parameter DEFAULT = 2'b00, COUNTING = 2'b01, PAUSED = 2'b10;  
    
    initial begin
        state <= DEFAULT;
//        state <= COUNTING;
//        enable_count <= 1;
    end

    // State transition logic
    always @(posedge clk) begin
         $display("%d", reset);
         $display("state: %b", state);
         $display("enable_pause: %b", enable_pause);
         $display("enable_count: %b", enable_count);
        if (reset) begin
            $display("reset");
            state <= DEFAULT;
        end else begin
            case (state)
                DEFAULT: begin
                    $display("default");
                    //if (pause_button)
                        //pause <=~pause;
                    if (pause_button)
                    begin
                        pause = ~pause;
                    end
                    
                    if (!pause) 
                    begin
                        state <= COUNTING;
                    end
                    else begin
                        state <= PAUSED;
                    end
                    
                end
                COUNTING: begin
                    $display("counting");
                    if (pause_button)
                    begin
                        pause = ~pause;
                    end
                    
                    if (pause) 
                    begin
                        state <= PAUSED;
                    end
                end
                PAUSED: begin
                    $display("paused");
                    if (pause_button)
                    begin
                        pause = ~pause;
                    end
                    if (!pause) 
                    begin
                        state <= COUNTING;
                    end
                end
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            DEFAULT: begin
                $display("default enable");
                enable_pause = 0;
                enable_count = 0; 


            end
            COUNTING: begin
                $display("counting enable");
                enable_pause = 0;
                enable_count = 1;
            end
            PAUSED: begin
                $display("paused enable");
                enable_pause = 1;
                enable_count = 0;
            end
        endcase
    end

endmodule