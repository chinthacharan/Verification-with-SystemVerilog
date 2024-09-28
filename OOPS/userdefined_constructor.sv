//user defined constructor

class first;
    int data;
    /*
    function new();
        data = 32;
    endfunction
    */
    function new(input int datain = 0)
        data = datain;
    endfunction
endclass

module tb;
    first f1;

    initial begin
        f1 = new(32);
        $display("Data: %0d", f1.data); //output is 32
    end
endmodule



//multiple arguments

class first;
    int data1;
    bit [7:0] data2;
    shortint data3;
    function new(input int data1 = 0, input bit[7:0] data2 = 8'b0, input shortint data3 = 0)
        this.data1 = data1; //if the argument and the data member name is same then we use "this"
        this.data2 = data2;
        this.data3 = daat3;
    endfunction

    task display();
        $display("value of daat1:%0d, data2: %0d and data3 : %0d", data1, data2, data3);
    endtask
endclass

module tb;
    first f1;

    initial begin
        //f1 = new(23, 4, 35); //following the position of declaration of arguments
        f1 = new(.data2(4), .data3(5), .data1(23)); //dot named convention
        f1.display();
        //$display("Data1: %0d, data2: %0d, data3 : %0d", f1.data1, f1.data2, f1.data3); //output is 32
    end
endmodule


