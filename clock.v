module counting (
    input wire clk, // master clock: 100,000,000 cycles/sec
    input reset, // need reset as an input?
    output wire 2_clk, // 2 Hz clock
    output wire 1_clk, // 1 Hz clock, 1 cycle/sec
    output wire fast_clk, // fast clock
    output wire blink_clk // blink clock
);

reg [31:0] 2_count = 0;
reg [31:0] 1_count = 0; 
reg [31:0] fast_count = 0;
reg [31:0] blink_count = 0;

// 2 Hz clock
always @(posedge clk or posedge reset) begin
    if (reset == 1) 
    begin
        2_count <= 0;
        2_clk <= 0; // or 1?
    end
    else if (2_count == 25000000) begin
        2_clk <= ~2_clk;
        2_count <= 0;
    end else begin
        2_count <= 2_count+1;
    end
end

// 1 Hz clock - 1 cycle per seconds
always @(posedge clk) begin
    if (reset == 1) 
    begin
        1_count <= 0;
        1_clk <= 0; 
    end
    else if (1_count == 50000000) begin
        1_clk <= ~1_clk;
        1_count <= 0;
    end else begin
        1_count <= 1_count+1;
    end
end

// fast clock
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
    end
    (blink_count == 1250000) begin
        blink_clk <= ~blink_clk;
        blink_count <= 0;
    end else begin
        blink_count <= blink_count+1;
    end
end

endmodule