import Definitions ::*;
module UART_TX
#(parameter WORD_LENGHT = 8)
(
  //inputs
  input clk,
  input rst,
  input [WORD_LENGHT-1:0] Tx_in,
  input send,
  //outputs
  output Tx_out,
  output Tx_ready
  );
  localparam  REGISTER_SIZE = WORD_LENGHT+3, COUNTER_BITS = CeilLog2(REGISTER_SIZE+1);
  //---------------------------wires--------------------------------------------
  bit counter_enable_wire;
  bit counter_rst_flag;
  bit [COUNTER_BITS-1:0]Tx_count_wire;


  bit parity_bit_wire;
  bit Tx_shift_register_load_wire;
  bit Tx_shift_register_shift_wire;
  bit [REGISTER_SIZE-1:0]Tx_shift_register_out_wire;



  //-----------------Tx counter---------------------------
  assign counter_enable_wire = Tx_shift_register_shift_wire | (send & Tx_ready);
  CounterParameter
  #(.Maximum_Value(REGISTER_SIZE+1))      TX_COUNTER
  (
  	// Input Ports
  	.clk(clk),
  	.reset(rst),
  	.enable(counter_enable_wire),
  	.SyncReset(counter_rst_flag),
  	// Output Ports
  	.Flag(counter_rst_flag),
  	.Counting(Tx_count_wire)
  );

  //----------------Tx register--------------------
  assign parity_bit_wire = ^Tx_in;
  assign Tx_shift_register_load_wire = ~Tx_shift_register_shift_wire;    //Only loads when counter=0
  assign Tx_shift_register_shift_wire = |Tx_count_wire;      //Only shifts when counter!=0
  Shift_Register_right
   #(.Word_Length(REGISTER_SIZE))     TX_REGISTER
   (
     // Input Ports
     .clk(clk),
     .reset(rst),
     .Data_Input( {1'b1, parity_bit_wire, Tx_in,1'b0} ),
     .load(Tx_shift_register_load_wire),
     .shift(Tx_shift_register_shift_wire),
     .sync_rst(1'b0),
     // Output Ports
     .Data_Output(Tx_shift_register_out_wire)
   );


  //-------------------------output assignments-------------------------------
  assign Tx_ready = ~|Tx_shift_register_shift_wire;
  assign Tx_out = Tx_ready | Tx_shift_register_out_wire[0];

endmodule
