module tb;
    int data1, data2;
    event done;
    int i=0;
    //generator (assume)
    initial begin
        for(i = 0; i<10; i++) begin
            data1 = $urandom();
            $display("Data Sent: %0d", data1);
            #10; //the new data is generated after every 10ns 
        end
        //after generating all the stimuli is completed
        //trigger the event done
        -> done;
    end

    //Driver(to recieve data)
    initial begin
        //this should continously recieve the data from generator
        forever begin
            #10;
            data2 = data1;
            $display("Data Recieved: %0d", data2);
            //when to stop the stimuli?
        end
    end

    //to control the simulation of blocks
    initial begin
        wait(done.triggered);
        //wait till you recieve the done trigger
        $finish();
    end
//All the initial blocks run in parallel
endmodule