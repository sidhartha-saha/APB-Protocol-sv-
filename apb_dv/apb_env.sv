
class apb_env;
 
  apb_scb scb;
  apb_agent agent;  
 
  function new(virtual apb_interface intf, string name = "apb_env");
   // $display("[%s] is created",name);
    scb = new("scb");
    agent = new(intf,"agent");
    scb.expected_mb = agent.drvr.expected_mb;
    scb.actual_mb = agent.mntr.actual_mb;
   // scb.compare();
  endfunction
  

  
endclass
