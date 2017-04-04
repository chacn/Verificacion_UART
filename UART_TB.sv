module UART_TB;
  localparam  WORD_LENGHT = 8;
   // Input Ports
  reg clk = 0;
  reg reset = 1;
  reg send = 0;
  reg [WORD_LENGHT-1:0]value;

  UART
  #(.WORD_LENGHT(WORD_LENGHT), .FREQUENCY(10), .BAUDRATE(1))      DUT
  (
    //inputs
    .clk(clk),
    .rst(reset),
    .Rx_in(1'b0),
    .Tx_in(value),
    .send(send),
    //outputs
    .Tx_out(),
    .Tx_ready()
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
