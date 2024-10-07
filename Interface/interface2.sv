interface add_if;
    logic [3:0] a, b;
    logic [4:0] sum;
    logic clk;
endinterface

class driver;
    virtual add_if aif; //no need to provide () it is only needed in tb

    task run();
        forever begin
            @(posedge aif.clk);
            aif.a <= 3;
            aif.b <= 3;
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

    always #10 aif.clk <= ~aif.clk; //since there is no sensitivity so call finish in the end
    
    driver drv;
    //constructor
    initial begin
        drv = new();
        drv.aif = aif; //connect the interface in class with actual interface in the tb
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