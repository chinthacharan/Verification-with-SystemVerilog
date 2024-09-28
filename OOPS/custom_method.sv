class first;
    int data = 34;
endclass

module tb;
    first f1;
    first f2;

    initial begin
        f1 = new();
        f1.data = 45;
        f2 = new f1; //copy of data members in f1 is copied to f2
        f2.data = 56;
        $display("%0d", f2.data); //56
        $display("%0d", f1.data); //45
    end 
endmodule

//custom method is useful in shallow copy and deep copy
//custom method

class first;
    int data = 34;
    bit [7:0] temp = 8'h11;

    function first copy();
        copy = new();
        copy.data = data;
        copy.temp = temp;
    endfunction

endclass

module tb;
    first f1;
    first f2;

    initial begin
        f1 = new();
        f2 = new();

        f2 = f1.copy;
        $display("Data: %0d and Temp: %0x", f2.data, f2.temp); //34, 11
    end
     
endmodule
