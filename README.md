# FPGA Stopwatch Implementation

A lab project for CSM152A. Stopwatch is implemented using the Basys 3 board based on the Artix-7 FPGA.

## Features

- [x] **Basic Timekeeping:** Tracks minutes and seconds, displaying them in a simple HH:MM format on the seven-segment display.
- [x] **Pause and Reset:**
  - [x] **Pause:** Allows the user to pause and resume the stopwatch by pressing a button.
  - [x] **Reset:** Resets the stopwatch display to 00:00 with the press of a button.
- [x] **Adjustment and Selection Mode:**
  - [x] **Selection Mode (SEL):** Enables toggling between minutes and seconds for adjustment using a slider switch.
  - [x] **Adjustment Mode (ADJ):** When activated, allows the user to manually increment the selected time segment at a rate of 2 ticks per second, while the other segment remains static.

## Hardware Requirements

- **Basys 3 FPGA Board**
- **Seven-segment display**
- **Push-buttons and slider switches**

## Getting Started

1. **Setup:** Refer to the Basys 3 Reference Manual to understand the setup and connections.
2. **Clone the Repository:** 
   ```bash
   git clone <repository-url>
