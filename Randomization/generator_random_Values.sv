// Global signals => Testbench Top
// Data and control signals => generator (pseudo Random Number Generator)

//testbench file
class generator;
    rand bit [3:0] a, b; //use rand if you are fine with repetation of values and use randc(cyclic) if you dont need repetation
    bit [3:0] y;
    constraint data { a > 15;} //this will return the status as 0 and randomization will fail
endclass
//randc will also show repetation once all the possible combinations are completed
module tb;
    generator g;
    int i = 0;
    int status = 0;

    initial begin
        g = new();
        for(i=0; i<10; i++) begin
            if(!g.randomize()) begin
                 $display("Randomization failed at %0t", $time);
                 $finish();
            end
            $display("Value of a: %0d and b: %0d", g.a, g.b);
            #10;
        end
    end
endmodule