class generator;

    randc bit [3:0] a;
    rand bit ce; //chip enable
    rand bit rst;

    constraint control_rst {
        rst dist { 0:= 80, 1 := 20}; 
    }

    constraint control_ce {
        ce dist { 1:= 80, 0:= 20};
    }

    constraint constrol_rst_ce {
        (rst == 0) -> (ce == 1); //implication operator if rst == 0 then ce is 1 and when rst == 1 then ce can be 0 or 1
    }
endclass

module tb;
    generator g;

    initial begin
        g = new();

        for (int i = 0; i< 10; i++) begin
            assert(g.randomize()) else $display ("randomizaiton Failed");
            $display("Value of rst:%0b and ce: %0b", g.rst, g.ce);
        end
    end
endmodule
