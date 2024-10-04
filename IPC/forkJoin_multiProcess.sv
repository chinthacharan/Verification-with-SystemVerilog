module tb;
    int [7:0] data1, data2;
    event done;
    event next;
    int i=0;
   
   task generator();
    for(i = 0; i<10; i++) begin
        data1 = $urandom();
        $display("Data sent: %0d", data1);
        #10;
        wait(next.triggered); //this comes from driver
    end
    -> done //end of stimuli
   endtask

   task reciever();
    forever begin
        #10;
        data2 = data1;
        $display("Data recieved: %0d", data2);
        -> next; //to inform the generator that the data is read and waiting for next data to be read
    end
    endtask

    task wait_event();
     wait(done.triggered); //comes from generator
     $display("Completed sending all stimulus");
     $finish();
    endtask

    //to execute all the process in parallel and fork join will avoid the race around condition
    //systemverilog handles the parallel execution of multiple initial begin blocks and avoid racearound
    initial begin
        fork
            generator();
            reciever();
            wait_event();
        join
    end
endmodule