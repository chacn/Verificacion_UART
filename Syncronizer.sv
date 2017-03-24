module syncronizer
(
  input asynch,
  input clk,
  input rst,
  output synch
  );
//------------------------wires---------------------------
  bit meta_wire;

  Register
#(.Word_Length(1))     REGISTER_1
 (
   // Input Ports
   .clk(clk),
   .reset(rst),
   .Data_Input(asynch),
   .enable(1'b1),
   .sync_reset(1'b0),
   // Output Ports
   .Data_Output(meta_wire)
 );

 Register
  #(.Word_Length(1))     REGISTER_2
  (
    // Input Ports
    .clk(clk),
    .reset(rst),
    .Data_Input(meta_wire),
    .enable(1'b1),
    .sync_reset(1'b0),
    // Output Ports
    .Data_Output(synch)
  );
endmodule
