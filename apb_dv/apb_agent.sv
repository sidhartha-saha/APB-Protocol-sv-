class apb_agent;
  apb_mntr mntr;
  apb_driver drvr;

  
  function new(virtual apb_interface intf, string name = "apb_driver");
   // $display("[%s] Agent is created",name);
    mntr = new(intf,"mntr");
    drvr = new(intf,"drvr");
  endfunction
  

endclass
