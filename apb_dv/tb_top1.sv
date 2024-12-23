`timescale 1ns/1ns 
`include "apb_pkg.sv"

module tb_top1;
  bit pclk = 1'b0;
  apb_test test;
  apb_interface intf(pclk);
  
  //clk generation
    initial forever begin
    #5 pclk = ~pclk; 
    end
  
     apb_slave DUT(
    .pclk(intf.pclk),
    .rst_n(intf.presetn),
    .paddr(intf.paddr),
    .pwrite(intf.pwrite),
    .psel(intf.psel),
    .penable(intf.penable),
    .pwdata(intf.pwdata),
    .prdata(intf.prdata)
    ); 
    
    
   initial begin
    test = new(intf,"test");
    test.run_test();
    @(negedge pclk);    $stop();
   end


endmodule
