class apb_scb;
  
  mailbox expected_mb;
  mailbox actual_mb;
  apb_packet exp_pkt;
  apb_packet act_pkt;

  apb_packet exp_pkt_c;
  apb_packet act_pkt_c;
  //taking instance of an array
  apb_packet exp_queue [$]; 

  function new(string name = "apb_scb");
    //$display("[%s] is created",name);
    expected_mb = new();
    actual_mb = new();
    act_pkt_c = new();
    exp_pkt_c = new();
 
    fork
    get_exp_pkt();
    get_act_pkt(); 
    join_none  
endfunction

   // get expected pkt
    task get_exp_pkt();
     begin
        forever begin 
           expected_mb.get(exp_pkt);
         //  $display("expected scb addr :: %0h || data :: %0h ", exp_pkt.addr, exp_pkt.data);
         //  $display("expected queue size :: %0d", exp_queue.size());
           exp_queue.push_front(exp_pkt);
         //  $display("expected queue size :: %0d", exp_queue.size());
        end 
     end
    
    endtask

   //get actual pkt
    task get_act_pkt();
      begin
           forever begin 
           actual_mb.get(act_pkt);
         //  $display("Actual scb addr :: %0h || data :: %0h ", act_pkt.addr, act_pkt.data);
           compare(act_pkt);
           end 
      end
    endtask
    
    task compare(apb_packet act_pkt_c);
        begin
            if(exp_queue.size())
              begin
               exp_pkt_c = exp_queue.pop_back();
               if((act_pkt_c.addr == exp_pkt_c.addr)&&(act_pkt_c.data == exp_pkt_c.data))
                 begin
                 $display("'PASS' EXP_ADDR : %0h , ACT_ADDR : %0h , EXP_DATA : %0h, ACT_DATA : %0h ",exp_pkt_c.addr,act_pkt_c.addr,exp_pkt_c.data, act_pkt_c.data  );
                 end
               else
                 begin
                 $display("'FAIL' EXP_ADDR : %0h , ACT_ADDR : %0h , EXP_DATA : %0h, ACT_DATA : %0h ",exp_pkt_c.addr,act_pkt_c.addr,exp_pkt_c.data, act_pkt_c.data  );
                 end
              end
           else begin
            $display("'failed to get expected packet!'");
            end

        end
    endtask  


endclass
