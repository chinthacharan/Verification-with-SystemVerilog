class generator;
    int data = 12;
    mailbox mbx; //gen2drv
    //mbx = new();
    //in order to make sure both the mbx is same we use custom constructo
    function new(mailbox mbx);
        this.mbx = mbx;
    endfunction

    task run();
        mbx.put(data);
        $display("[GEN] : SENT DATA : %0d", data);
    endtask

endclass

class driver;
    //this should recieve the data from the generator
    int datac = 0;
    mailbox mbx

    function new(mailbox mbx);
        this.mbx = mbx;
    endfunction

    task run();
        mbx.get(datac);
        $display("[DRV] : RCVD Data : %0d", datac);
    endtask
endclass

module tb;
    //handlers for generator and driver
    generator gen;
    driver drv;
    mailbox mvx;
    //add constructors
    initial begin
        mbx = new();
        gen = new(mbx);
        drv = new(mbx);
        
        //declare mbx is same for both gen and driver
        //gen.mbx = mbx; //no longer as we have custom constructor
        //drv.mbx = mbx;

        gen.run();
        drv.run();
    end
endmodule