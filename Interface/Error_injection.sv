class transaction;
    randc bit [3:0] a;
    randc bit [3:0] b;
    bit [4:0] sum;
    function void display();
        $display("a: %0d \t b: %0d \t sum: %0d", a, b, sum);
    endfunction

endclass

//injection of error by extending the transaction clkass
class error extends transaction; //child class
    constraint data_c {a == 0; b == 0;}
endclass
//we need to connect the transaction in generator to error

class generator;
    transaction trans; //instance or handler
  
    mailbox #(transaction) mbx;
    event done;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run(); 
        trans = new(); //we are using single object here instead of keepint it inside the for loop
        for(int i = 0; i < 10; i ++) begin
            assert(trans.randomize()) else $display("Randomization Failed");
            $display("[GEN] : DATA sENT TO DRIVER");
            mbx.put(trans); 
            trans.display();
            #20;
        end
        -> done;
    endtask
endclass

interface add_if;
    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] sum;
    logic clk;

    modport DRV (input a,b, input sum, clk);
endinterface

class driver;
    virtual add_if aif; //access to interface
    mailbox #(transaction) mbx;
    transaction data; //data container

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
        end 
    endtask
endclass


module tb;
    add_if aif();
    driver drv; //instance
    generator gen;
    error err; //handler or instace
    event done;

    mailbox #(transaction) mbx;
    add dut (aif.a, aif.b, aif.sum, aif.clk);

    initial begin
        aif.clk <= 0;
    end

    always #10 aif.clk <= ~aif.clk;

    initial begin
        mbx = new();    //constructor
        err = new(); //constructor
        drv = new(mbx);
        gen = new(mbx);
        gen.trans = err; //now we connected the transaction in generator to error
        drv.aif = aif;
        done = gen.done;
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