import Definitions ::*;
module UART_RX
#(parameter WORD_LENGHT = 8)
(
  //inputs
  input clk,
  input rst,
  input RX_in,
  input clear_interrupt,
  //outputs
  output [WORD_LENGHT-1:0]RX_out,
  output received,
  output Rx_error
  );

//------------------frequency div wires----------------------
  bit baudrate_clk;
//---------------------Sincronizer wires-------------------
  bit synch_RX;
  //-----------------RX counter wires------------------------
  bit RX_counter_enable_wire;
  bit RX_flag_wire;
  bit [CeilLog2(WORD_LENGHT+2)-1:0] RX_count_wire;
  //-----------------RX shift register wires----------------
  bit RX_shift_register_enable_wire;
  bit [WORD_LENGHT+1:0]RX_shift_register_out_wire;
  //-------------------Parity wire-------------------------
  bit parity_wire;
  //---------------------Interruption wires----------------
  bit received_out_wire;
  bit received_wire;

//---------------------Sincronizer-------------------
  syncronizer     SYNCH
  (
    .asynch(RX_in),
    .clk(clk),
    .rst(rst),
    .synch(synch_RX)
    );

//-----------------RX counter---------------------------
assign RX_counter_enable_wire = RX_shift_register_enable_wire | ~synch_RX;
CounterParameter
#(.Maximum_Value(WORD_LENGHT+2))      RX_COUNTER
(
	// Input Ports
	.clk(clk),
	.reset(rst),
	.enable(RX_counter_enable_wire),
	.SyncReset(RX_flag_wire),
	// Output Ports
	.Flag(RX_flag_wire),
	.Counting(RX_count_wire)
);

//----------------RX register--------------------
assign RX_shift_register_enable_wire = |RX_count_wire;    //Only counts when counter!=0
Register
 #(.Word_Length(WORD_LENGHT+1))     RX_REGISTER
 (
   // Input Ports
   .clk(clk),
   .reset(rst),
   .Data_Input( {synch_RX, RX_shift_register_out_wire[WORD_LENGHT:1]} ),
   .enable(RX_shift_register_enable_wire),
   .sync_reset(1'b0),
   // Output Ports
   .Data_Output(RX_shift_register_out_wire)
 );

 //----------------Interruption register--------------------
 assign received_wire = RX_flag_wire & ~parity_wire;
 Register
  #(.Word_Length(1))     INTERRUPT_REGISTER
  (
    // Input Ports
    .clk(clk),
    .reset(rst),
    .Data_Input(received_wire),
    .enable(RX_flag_wire),
    .sync_reset(clear_interrupt),
    // Output Ports
    .Data_Output(received_out_wire)
  );


assign parity_wire = ^{synch_RX, RX_shift_register_out_wire[WORD_LENGHT:1]};

//----------------------------Output signals--------------------------------
assign received = received_out_wire;
assign RX_out = RX_shift_register_out_wire[WORD_LENGHT-1:0];
assign Rx_error = parity_wire & RX_flag_wire;


 endmodule
