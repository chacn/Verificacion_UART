module UART_RX_TB;
  localparam  WORD_LENGHT = 8;
   // Input Ports
  reg clk = 0;
  reg reset = 1;
  reg send = 0;
  reg value=1;

  bit [7:0]numero = 8'b1101_1011;

UART_RX
#(.WORD_LENGHT(WORD_LENGHT)) DUT
(
  //inputs
  .clk(clk),
  .rst(reset),
  .RX_in(value),
  //outputs
  .RX_out(),
  .received(),
  .Rx_error()
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

  initial // Clock generator
    begin
    #60
      forever begin
      #4 value = 0;
      #4  value = numero[0];
      #4  value = numero[1];
      #4  value = numero[2];
      #4  value = numero[3];
      #4  value = numero[4];
      #4  value = numero[5];
      #4  value = numero[6];
      #4  value = numero[7];
      #4 value = ~^numero;
      #4 value = 1;

      end
    end

endmodule
