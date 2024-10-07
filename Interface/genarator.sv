//1.add transaction constructor in generator custom constructor
//2.send deep copy of transaction between generator and driver

class transaction;
    randc bit [3:0] a;
    randc bit [3:0] b;
    bit [4:0] sum;

    //method to access the current values
    function void display();
        $display("a: %0d \t b: %0d \t sum: %0d", a, b, sum);
    endfunction
    //this is to avoid the repetation of value as we moved the constructor inside the for loop
    function transaction copy();
        copy = new();
        copy.a = this.a;
        copy.b = this.b;
        copy.sum = this.sum;
    endfunction

endclass

class generator;
    transaction trans;
    //we need a mailbox to send the data from generator to driver
    mailbox #(transaction) mbx;
    event done;
    //we need an event to mark the completion of simulation
    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
        trans = new(); //single object we can now remove the constructor from the for loop
    endfunction

    task run(); 
        //trans = new();
        for(int i = 0; i < 10; i ++) begin
            //trans = new(); //reason is to ensure that there is not enough time for the time taken for the data to go from generator to checkboard so create new object for each iteration
            assert(trans.randomize()) else $display("Randomization Failed");
            $display("[GEN] : DATA sENT TO DRIVER");
            trans.display();
            //deep copy
            mbx.put(trans.copy); //this will also us to have independent object instead of single object for the entire flow
            #10;
        end
        -> done;
    endtask
endclass

interface add_if;
    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] sum;
    logic clk;
endinterface

class driver;
    virtual add_if aif;
    mailbox #(transaction) mbx;
    transaction data; //data container
    event next;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        forever begin
            mbx.get(data);
            @(posedge aif.clk);
            aif.a <= data.a;
            aif.b <= daat.b;
            $display("[DRV] : Interface Trigger");
            data.display();
            ->next;
        end 
    endtask
endclass


module tb;
    add_if aif();
    driver drv;
    generator gen;
        event done;
    mailbox #(transaction) mbx;
    add dut (aif.a, aif.b, aif.sum, aif.clk);

    initial begin
        aif.clk <= 0;
    end

    always #10 aif.clk <= ~aif.clk;

    initial begin
        mbx = new();
        drv = new(mbx);
        gen = new(mbx);
        drv.aif = aif;
        done = gen.done
    end

    initial begin
        //now we have to run both the run functions parallely use fork join
        fork
            gen.run();
            drv.run();
        join_none
          wait(done.triggered);
          $finish();
    end

    initial begin
        $dumpfile("dump.vsd");
        $dumpvars;
    end
endmodule

module add(
    input [3:0] a, b,
    output reg [4:0] sum,
    input clk
);
    always @(posedge clk) begin
        sum <= a + b;
    end
endmodule