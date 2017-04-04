module UART_RX_TB;
  localparam  WORD_LENGHT = 8;
   // Input Ports
  reg clk = 0;
  reg reset = 1;
  reg send = 0;
  reg value;

UART_RX
#(.WORD_LENGHT(WORD_LENGHT), .FREQUENCY(10), .BAUDRATE (1) ) DUT
(
  //inputs
  .clk(clk),
  .rst(reset),
  .RX_in(value),
  //outputs
  .RX_out(),
  .received()
  );

  /*********************************************************/
  initial // Clock generator
    begin
      forever #2 clk = !clk;
    end
  /*********************************************************/
  initial begin // reset generator
  	#0 reset = 1;
    #4 reset = 0;
  	#4 reset = 1;
  end


  initial begin
    #12 value = "d";
        send = 1;
  end

  initial // Clock generator
    begin
    #60
      forever begin
      #50 value = value + 15;
      end
    end

endmodule

