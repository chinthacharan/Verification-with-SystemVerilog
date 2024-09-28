class first;
    int data = 12;
endclass

class second;
    int ds = 34;

    first f1;

    function new();
        f1 = new();
    endfunction
endclass

module tb;
    second s1, s2;
    initial begin
        s1 = new();
        s1.ds = 45;
        s2 = new s1;
        $display("Value of ds:%0d", s2.ds); //45
        s2.ds = 78;
        $display("Value of ds:%0d", s1.ds); //45

        s2.f1.data = 56;
        $display("Value of data: %0d", s1.f1.data); //56 value is updated from the copy object
    end
endmodule

//for data members the value if not updated from the copy object but for handler it can be updaetd from the copy object
//This is called shallow copy