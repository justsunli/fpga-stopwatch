module debouncer (
    input wire clk,       // Clock signal
    input wire noisy,     // Noisy input signal (e.g., raw button press)
    output reg debounced  // Debounced output signal
);

    reg [19:0] counter;   // 20-bit counter for debounce timing
    reg state;            // State register to hold the debounced state
    reg sync_to_clk0;     // First stage of the synchronizer
    reg sync_to_clk1;     // Second stage of the synchronizer

    // Synchronize the input to the clock domain to avoid metastability
    always @(posedge clk) begin
        sync_to_clk0 <= noisy;
    end

    always @(posedge clk) begin
        sync_to_clk1 <= sync_to_clk0;
    end

    // Debounce logic
    always @(posedge clk) begin
        if (state == sync_to_clk1) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 20'hFFFFF) begin  // Adjust the counter value as needed for debounce time
                state <= sync_to_clk1;
                counter <= 0;
            end
        end
    end

    // Output the debounced state
    assign debounced = state;

endmodule
