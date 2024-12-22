interface apb_interface(input wire pclk);

  logic presetn;
  logic [7:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  
endinterface
