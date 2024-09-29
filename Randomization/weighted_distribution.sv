class first;
    rand bit wr; // :=
    rand bit rd; // :/
    //now let us deal with ranges
    rand bit [1:0] var1;
    rand bit [1:0] var2;

    constraint cntrl{
        wr dist {0 := 30 , 1 := 70};
        rd dist {0 :/ 30 , 1 :/ 70};
    }

    constraint data {
        var1 dist {0 := 30, [1:3] := 90}; // P(0) = 30/300, P(1,2,3) = 90/300
        var2 dist {0 :/ 30, [1:3] :/ 90}; // P(0) = 30/120, P(1,2,3) = 30/120
    }
endclass

module tb;
    first f;

    initial begin
        f = new();
        for (int i=0; i<10; i++) begin
            f.randomize();
            //$display("Value of wr : %0d and rd : %0d", f.wr, f.rd);
            $display("Value of var1(:=) : %0d and var2(:/) : %0d", f.var1, f.var2);
        end
    end
endmodule