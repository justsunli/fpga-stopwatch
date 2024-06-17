`timescale 1ns / 1ps

module stopwatch (
    input wire clk,
    input wire reset,   // Noisy reset button input
    input wire pause, 
    input wire [1:0] sw,  // Noisy pause button input
//    input wire sw[1],     // Noisy select switch input
//    input wire raw_adj,     // Noisy adjust switch input
    output wire [3:0] anode,
    output wire [6:0] segments
);

wire raw_sel = sw[0];
wire raw_adj = sw[1];

// Debounced signals
//wire reset;
//wire pause;
//wire sel;
//wire adj;
wire db_pause;

debouncer dbpause(
    .clk(clk),
    .noisy(pause),
    .db_signal(db_pause)
);


//wire 2hz_clock;
//wire 1hz_clock;
wire clock_2hz;
wire clock_1hz;
wire fast_clock;
wire blink_clock;

// Internal signals
wire enable_pause;
wire enable_count;
wire [5:0] seconds;
wire [5:0] minutes;

// clock divider
clock clock_div(
    .clk(clk),
    .reset(reset),
    .clk2(clock_2hz), 
    .clk1(clock_1hz), 
    .fast_clk(fast_clock), 
    .blink_clk(blink_clock)
);


// Instantiate the arbiter
arbiter arbiter_inst (
    .clk(clk),
    .reset(reset),
    .pause_button(db_pause), // Using pause button as start/stop toggle
    .enable_pause(enable_pause),
    .enable_count(enable_count),
    .state()
);

// Instantiate paused state module
//paused paused_inst (
//    .clk(clk),
//    .enable(enable_pause),
//    .paused_output(paused_output)
//);

// Instantiate counting state module without adjustment
// with adjustment, passing in also the sel and adj switches, and also clocks
//counting counting_inst (
//    .clk(clock_1hz), // pass in 1Hz clock
//    .enable(enable_count),
//    .reset(reset),
//    .seconds(seconds),
//    .minutes(minutes)
//);

counting counting_inst (
    .clk_1hz(clock_1hz), // pass in 1Hz clock
    .clk_2hz(clock_2hz),
    .enable(enable_count),
    .enable_pause(enable_pause),
    .reset(reset),
    .sel(raw_sel),
    .adj(raw_adj),
    .seconds(seconds),
    .minutes(minutes)
    
    
);


wire [3:0] minutes_tens;
wire [3:0] minutes_units;
wire [3:0] seconds_tens;
wire [3:0] seconds_units;

wire [3:0] paused_output;


// Split minutes and seconds into tens and units
assign minutes_tens = minutes / 10;
assign minutes_units = minutes % 10;
assign seconds_tens = seconds / 10;
assign seconds_units = seconds % 10;


// Instantiate display controller
display_controller display_controller_inst (
    .clk(fast_clock),
    .blink_clk(blink_clock),
    .reset(reset),
    .sel(raw_sel),
    .adjust(raw_adj),
    .minutes_tens(minutes_tens),
    .minutes_units(minutes_units),
    .seconds_tens(seconds_tens),
    .seconds_units(seconds_units),
    .anode(anode),
    .segments(segments)
);

endmodule
