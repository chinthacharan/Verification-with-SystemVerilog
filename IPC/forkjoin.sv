module tb;
  
      task first();
        $display("Task 1 Started at %0t",$time);
      #20;      
        $display("Task 1 Completed at %0t",$time);     
    endtask
 
    task second();
      $display("Task 2 Started at %0t",$time);
      #30;      
     $display("Task 2 Completed at %0t",$time);     
    endtask
 
    task third();
      $display("Reached next to Join at %0t",$time);     
    endtask
  
  initial begin
    fork    
      first();
      second(); 
    join //only after first and second is completed then third is allowed to execute
    //join_any //this will allow the third to execute once one of the first and second process is completed
    //join_none //it wont wait for any of the process to complete this will allow the third to complete parallely with other two processes.
      third();
  end

endmodule