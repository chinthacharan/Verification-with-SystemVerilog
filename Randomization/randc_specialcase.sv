//pre-randomize

class generator;
    randc bit [3:0] a, b; 
    bit [3:0] y;
    int min;
    int max;

    function void pre_randomize(input int min, input int max);
        this.min = min;
        this.max = max;
    endfunction

    constraint data {
        a inside {[min:max]};
        b inside {[min:max]};
    }

    function void post_randomize();
        $display("Value of a: %0d and b : %0d", a, b);
    endfunction
endclass


module tb;
    generator g;
    int i = 0;

    initial begin
        g = new();
        $display("SPACE 1");
        g.pre_randomize(3,8);
        for(i=0; i<6; i++) begin
            assert(g.randomize()) else $display("randomization Failed");
            #10;
        end
        $display("Space 2");
        g.pre_randomize(3,8);
        for(i=0; i<6; i++) begin
            assert(g.randomize()) else $display("randomization Failed");
            #10;
        end
    end
endmodule