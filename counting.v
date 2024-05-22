module counting (
    input wire clk,
    input wire enable,
    input wire reset,
    output reg [5:0] seconds,  // 6-bit for seconds (0-59)
    output reg [5:0] minutes   // 4-bit for minutes (0-59)
);

always @(posedge clk or posedge reset) begin
    if (reset) 
    begin
        seconds <= 0;
        minutes <= 0;
    end
    else if (enable)
    begin
        if (minutes != 59 && seconds == 59)
        begin
          seconds <= 0
          minutes <= minutes + 1;
        end
        else begin
          seconds <= seconds + 1;
         
        end
    end


endmodule
