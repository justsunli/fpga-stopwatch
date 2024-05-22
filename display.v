module display(
  input [3:0] digit, 
  output [6:0] cathode
)
  reg [6:0] store_cathode;
  // takes in a digit and display it using cathode representation

  always @(*) begin
    case(digit)
    4'b0000: store_cathod = 7'b0000001; // "0"  
    4'b0001: store_cathod = 7'b1001111; // "1" 
    4'b0010: store_cathod = 7'b0010010; // "2" 
    4'b0011: store_cathod = 7'b0000110; // "3" 
    4'b0100: store_cathod = 7'b1001100; // "4" 
    4'b0101: store_cathod = 7'b0100100; // "5" 
    4'b0110: store_cathod = 7'b0100000; // "6" 
    4'b0111: store_cathod = 7'b0001111; // "7" 
    4'b1000: store_cathod = 7'b0000000; // "8"  
    4'b1001: store_cathod = 7'b0000100; // "9" 
    default: store_cathod = 7'b0000001; // "0"
    endcase
  endcase

  assign cathode = store_cathode;

endmodule