class apb_mntr;
  
  virtual apb_interface intf;
  mailbox actual_mb;
  apb_packet pkt;
  
  function new(virtual apb_interface intf, string name = "apb_mntr");
   // $display("[%s] is created",name);
    this.intf = intf;
    actual_mb = new();

    fork 
   write_capture();
   read_capture();
    join_none

  endfunction
  
  task write_capture();
    forever begin
    @(negedge intf.pclk); 
    if(intf.psel && intf.pwrite && intf.penable && intf.presetn)
     begin
      //  $display( "[%0t] write is captured addr = %0h, data = %0h ",$time,intf.paddr,intf.pwdata);
       
     end
    end
  endtask
 
   task read_capture();
    forever begin
    @(negedge intf.pclk); 
    if(intf.psel && !intf.pwrite && intf.penable && intf.presetn)
     begin
        //  $display( "[%0t] read is captured addr = %0h, data = %0h ",$time,intf.paddr,intf.prdata);
          pkt =new();
          pkt.addr = intf.paddr;
          pkt.data = intf.prdata;
        //  $display("actual mntr addr :: %0h || data :: %0h ", pkt.addr, pkt.data);
          actual_mb.put(pkt);
     end
    //capture read
    end
  endtask
  
endclass

