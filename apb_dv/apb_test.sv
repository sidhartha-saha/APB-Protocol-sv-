class apb_test;
   
  apb_env env;
   
  function new(virtual apb_interface intf, string name = "apb_test");
   // $display("[%s] is created",name);
    env = new(intf, "env");
  endfunction
  
  task run_test();
    env.agent.drvr.reset();
  	for(int i=0; i<(2**8); i++)
    begin
     env.agent.drvr.write(i,$random);
     env.agent.drvr.read(i);
   end
  endtask
  
endclass