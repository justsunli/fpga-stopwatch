module counting (
    input wire clk,
    input wire enable,
    output reg [5:0] seconds,  // 6-bit for seconds (0-59)
    output reg [5:0] minutes   // 4-bit for minutes (0-59)
);

always @(posedge clk) begin
    if (enable) begin
        // Define your counting state logic here
        // Example: increment the time
        if (seconds == 59) begin
            seconds <= 0;
            if (minutes == 9) begin
                minutes <= 0;
            end else begin
                minutes <= minutes + 1;
            end
        end else begin
            seconds <= seconds + 1;
        end
    end
end

endmodule
