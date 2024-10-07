interface add_if;
    logic [3:0] a, b;
    logic [4:0] sum;
    logic clk;

//this modport adds the direction
modport DRV (output a,b, input sum,clk); //for driver the a and b are output

endinterface

class driver;
    virtual add_if.DRV aif; //modport restriction

    task run();
        forever begin
            @(posedge aif.clk);
            aif.a <= 3;
            aif.b <= 3;
            $display("[DRV]: Interface is Triggered")
        end
    endtask

endclass

module tb;
    //access to interface
    add_if aif(); //use parenthesis here
    add dut (.a(aif.a), .b(aif.b), .sum(aif.sum), .clk(aif.clk));

    initial begin
        aif.clk <= 0;
    end

    always #10 aif.clk <= ~aif.clk; 
    driver drv;
    //constructor
    initial begin
        drv = new();
        drv.aif = aif; /
        drv.run();
    end
    
    //waveform
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        #100;
        $finish();
    end
endmodule

//design file

module add(
    input [3:0] a, b,
    output reg [4:0] sum,
    input clk
);
    always @(posedge clk) begin
        sum <= a + b;
    end
endmodule