module UART_TX_TB;
  localparam  WORD_LENGHT = 8;
   // Input Ports
  reg clk = 0;
  reg reset = 1;
  reg send = 0;
  reg [WORD_LENGHT-1:0]value;

  UART_TX
  #(.WORD_LENGHT(WORD_LENGHT))      DUT
  (
    //inputs
    .clk(clk),
    .rst(reset),
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
    #12 value = 8'h55;
        send = 1;
    #4 send = 0;
  end

  initial // Clock generator
    begin
    #60
      forever begin
      #40 value = value + 15;
          send = 1;
      #4 send = 0;
      end
    end

endmodule
