class generator;
    randc bit [3:0] a, b; 
    bit [3:0] y;
    /*
    constraint data { 
                    a inside {[0:8], [10:11], 15} ;
                    b inside {[3:11]} ;
                    }
    */
    //how to skip certain values like a = 3:7 and b = 5:9
    constraint data {
        !(a inside {[3:7]});
        !(b inside {[5:9]});
    }
endclass

module tb;
    generator g;
    int i = 0;

    initial begin
        g = new();
        for(i=0; i<10; i++) begin
            g = new(); 
            g.randomize()
            $display("Value of a: %0d and b: %0d", g.a, g.b);
            #10;
        end
    end
endmodule