class transaction;
    rand bit [3:0] din1;
    rand bit [3:0] din2;
    bit [4:0] dout;

endclass

class generator;
    transaction t;
    mailbox mbx;

    //custom constructor
    function new(mailbox mbx)
        this.mbx = mbx;
    endfunction

    task main();
        for(int i = 0; i < 10; i++) begin
            t = new();
            assert(t.randomize) else $display("Randomization Failed");
            $display("[GEN] : Data Sent : din1 : %0d and din2 : %0d", t.din1, t.din2);
            mbx.put(1);
            #10;
        end
    endtask
endclass

class driver;
    transaction dc; //data container
    mailbox mbx
    //custom constructor
    function new(mailbox mbx)
        this.mbx = mbx;
    endfunction

    task main();
        forever begin
            mbx.get(dc);
            $display("[DRV] : DATA RCVD : din1 : %0d and din2 : %0d", dc.din1, dc.din2);
            #10; //delay is mandatory for forever block
        end
    endtask
endclass

module tb;
    //handlers
    generator g;
    driver d;
    mailbox mbx;
    //add constructors

    initial begin
        mbx = new();
        g = new(mbx);
        d = new(mbx);

        fork
            g.main();
            d.main();
        join
    end
endmodule
    