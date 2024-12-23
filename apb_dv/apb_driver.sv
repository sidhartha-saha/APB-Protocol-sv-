class apb_driver;
  
  virtual apb_interface intf; 
   mailbox expected_mb;
   apb_packet pkt;
  
  function new(virtual apb_interface intf, string name = "apb_driver");
  //  $display("[%s] is created",name);
    this.intf = intf;
    expected_mb = new();
  endfunction

  task reset();
    repeat(2)@(negedge intf.pclk);
	intf.presetn <= 1'b0; 
  	intf.pwrite <= 1'b0;
  	intf.psel <= 1'b0; 
  	intf.paddr <= 8'd0;
  	intf.pwdata <= 32'd0;
    intf.penable <= 1'b0;
  	@(negedge intf.pclk);
  	intf.presetn <= 1'b1;
  	@(negedge intf.pclk);

  endtask

  task write( logic [7:0] addr, logic [31:0] data);
    //setup
  //  $display("[%0t][driver] [write task called]",$time);
    @(negedge intf.pclk);
    intf.pwrite <= 1'b1;
    intf.psel <= 1'b1; 
    intf.paddr <= addr;
    intf.pwdata <= data;

    //enable
    @(negedge intf.pclk);
    intf.penable <= 1'b1;
    
    //idle
    @(negedge intf.pclk);
    intf.penable <= 1'b0;
    intf.pwrite <= 1'b0;
    intf.psel <= 1'b0; 
    
    //send transaction to scb
    pkt =new();
    pkt.addr = addr;
    pkt.data = data;
   // $display("expected drvr addr :: %0h || data :: %0h ", pkt.addr, pkt.data);
    expected_mb.put(pkt);
    endtask

    task read( logic [7:0] addr);
   //  $display("[%0t][driver] [read task called]",$time);
    //setup
    @(negedge intf.pclk);
    intf.pwrite <= 1'b0;
    intf.psel <= 1'b1; 
    intf.paddr <= addr;
   

    //enable
    @(negedge intf.pclk);
    intf.penable <= 1'b1;

    //idle
    @(negedge intf.pclk);
    intf.psel <= 1'b0; 
    intf.penable <= 1'b0;
    @(negedge intf.pclk);
  endtask
  

  
endclass

