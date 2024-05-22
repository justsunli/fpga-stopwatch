module stopwatch (
    input wire clk,
    input wire raw_reset,   // Noisy reset button input
    input wire raw_pause,   // Noisy pause button input
    input wire raw_sel,     // Noisy select switch input
    input wire raw_adj,     // Noisy adjust switch input
    output wire [3:0] anode,
    output wire [6:0] segments
);

// Debounced signals
wire reset;
wire pause;
wire sel;
wire adj;

// Instantiate debouncers for each input
debouncer db_reset (
    .clk(clk),
    .reset(raw_reset),
    .noisy(raw_reset),
    .debounced(reset)
);

debouncer db_pause (
    .clk(clk),
    .reset(raw_reset),
    .noisy(raw_pause),
    .debounced(pause)
);

debouncer db_sel (
    .clk(clk),
    .reset(raw_reset),
    .noisy(raw_sel),
    .debounced(sel)
);

debouncer db_adj (
    .clk(clk),
    .reset(raw_reset),
    .noisy(raw_adj),
    .debounced(adj)
);

// Internal signals
wire enable_pause;
wire enable_count;
wire [5:0] seconds;
wire [3:0] minutes;
wire [3:0] paused_output;
wire [3:0] minutes_tens;
wire [3:0] minutes_units;
wire [3:0] seconds_tens;
wire [3:0] seconds_units;

// Split minutes and seconds into tens and units
assign minutes_tens = minutes / 10;
assign minutes_units = minutes % 10;
assign seconds_tens = seconds / 10;
assign seconds_units = seconds % 10;

// Instantiate the arbiter
arbiter arbiter_inst (
    .clk(clk),
    .reset(reset),
    .start(!pause), // Using pause button as start/stop toggle
    .enable_pause(enable_pause),
    .enable_count(enable_count),
    .state()
);

// Instantiate paused state module
paused paused_inst (
    .clk(clk),
    .enable(enable_pause),
    .paused_output(paused_output)
);

// Instantiate counting state module without adjustment
counting counting_inst (
    .clk(clk),
    .enable(enable_count),
    .seconds(seconds),
    .minutes(minutes)
);

// Instantiate counting state module with adjustment
counting counting_inst (
    .clk(clk),
    .enable(enable_count),
    .sel(sel),
    .adj(adj),
    .seconds(seconds),
    .minutes(minutes)
);

// Instantiate display controller
display_controller display_controller_inst (
    .clk(clk),
    .reset(reset),
    .minutes_tens(minutes_tens),
    .minutes_units(minutes_units),
    .seconds_tens(seconds_tens),
    .seconds_units(seconds_units),
    .anode(anode),
    .segments(segments)
);

endmodule
