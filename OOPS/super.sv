//we use this keyword if we have same name for argument and data member of a class

class first;    //parent class
    int data;
    //custom constructor
    function new(input int data);
        this.data = data
    endfunction

endclass

class second extends first;  //child class
    int temp;
    //use the super keyword if you wish to refer to the method of parent class
    function new(input int data, input int temp);
        super.new(data);
        this.temp = temp;
    endfunction
endclass

module tb;
    second s;

    initial begin
        s = new(67, 45);
        $display("Value of data : %0d and Temp: %0d", s.data, s.temp);
    end
endmodule