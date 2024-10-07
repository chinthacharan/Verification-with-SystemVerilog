class transaction;
    randc bit [3:0] a;
    randc bit [3:0] b;
    bit [4:0] sum;

    function void display();
        $display("a : %0d \t b : %0d \t sum : %0d", a, b, sum);
    endfunction

    // virtual function transaction copy();
    //     copy = new();
    //     copy.a = this.a;
    //     copy.b = this.b;
    //     copy.sum = this.sum;
    // endfunction
endclass

interface add_if;
    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] sum;
    logic clk;
endinterface

class monitor;
    mailbox #(transaction) mbx;
    transaction trans;
    virtual add_if aif; //no parenthesis while declaring in class and also need virtual 
    function new(mailbox #(transaction) mbx);
        this.mbx = mbx; //mailbox in class is connected to mailbox in argument
    endfunction

    task run();
        trans = new();
        forever begin
            repeat(2) @(posedge aif.clk); //wait for 2 clock ticks
                trans.a = aif.a ; //updating the variable from interface
                trans.b = aif.b; //result returned by the DUT is assigned to trans
                trans.sum = aif.sum; //while assigning value to a interface it should be non blocking
                $display("--------------------------------------"); //start of transaction
                $display("[MON] : DATA SENT TO SCOREBOARD")
                trans.display();
        end
    endtask
endclass

class scoreboard;
    mailbox #(transaction) mbx;
    transaction trans;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task compare(input transaction trans);
        if((trans.sum) == (trans.a + trans.b))
            $display("[SCO] : SUM RESULT MATCHED");
        else 
            $error("[SCO] : SUM RESULT MISMATCHED"); //$warning, $fatal - to stop simulation if error occurs
    endtask

    task run();
    //recieve data from monitor
        forever begin
            mbx.get(trans);
            $display("[SCO] : DATA RCVD FROM MONITOR")
            trans.display();
            compare(trans);
            $display("-------------------------------------");
            #40; //wait for 2 clock ticks
        end
    endtask
endclass

module tb;
    add_if aif();
    monitor mon;
    scoreboard sco;
    mailbox #(transaction) mbx;
    add dut (aif.a, aif.b, aif.sum, aif.clk);

    initial begin
        aif.clk <= 0;
    end
    always #10 aif.clk <= ~aif.clk;

    initial begin
        for(int i= 0; i < 20 ; i ++) begin
            @(posedge aif.clk);
            aif.a <= $urandom_range(0,15);
            aif.b <= $urandom_range(0,15);
        end
    end

    initial begin
        mbx = new();
        mon = new(mbx);
        sco = new(mbx);
        mon.aif = aif; //connect interface of monitor with tb
    end

    initial begin
        fork
            mon.run();
            sco.run();
        join
    end

    //waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        #450;
        $finish();
    end
endmodule



