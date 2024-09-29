class generator;

    randc bit [3:0] raddr, waddr;
    rand bit wr; //write to mem
    rand bit oe; //output enable

    constraint wr_c {
        wr dist { 0:= 50, 1 := 50}; 
    }

    constraint oe_c {
        oe dist { 1:= 50, 0:= 50};
    }

    constraint wr_oe_ce {
        (wr == 1) -> (oe == 0); //equivalence operator if wr == 1 then oe is 0 and vice versa
    }

    constraint write_read {
        if(wr == 1) //observe that we are not using begin end here instead we use {}
        {
            waddr inside {[11:15]};
            raddr == 0; //we dont want to send raddr during write
        } else{
            waddr == 0;
            raddr inside {[11:15]};
        }
    }
endclass

module tb;
    generator g;

    initial begin
        g = new();
        //turning on or off the constraint
        g.wr_oe_ce.constraint_mode(0); //1 -> constraint is on // 0 -> constraint is off
        for (int i = 0; i< 15; i++) begin
            assert(g.randomize()) else $display ("randomizaiton Failed");
            $display("Value of wr:%0b and oe: %0b and value of waddr: %0d and value of raadr : %0d", g.wr, g.oe, g.waddr, g.waddr);
        end
    end
endmodule
