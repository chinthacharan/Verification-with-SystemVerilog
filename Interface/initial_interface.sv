//assume there is an design file with add as module name
interface add_if;
    logic [3:0] a;
    logic [3:0] b;
    logic [4:0] sum;
    
endinterface

//relationship between the design file and this interface in tb
module tb;
    add_if aif(); //it is mandatory to use ()
    //add dut (aif.a, aif.b, aif.sum); // based on position
    add dut (.b(aif.b), .a(aif.a), .sum(aif.sum)); //dot named convention

    initial begin
        aif.a = 4;
        aif.b = 4;
        #10;
        aif.a = 3;
        #10;
        aif.b = 7;
    end

    //waveform code
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule