class first;
    int data = 12;

    function void display();
        $display("Valueb of data:%0d", data);
    endfunction

    function void add();
        $display("Value of addition: %0d", temp+4);
    endfunction
endclass

//use extend to extend the capability of a class
class second extends first;
    int temp = 34;
endclass

module tb;
    second s;

    inital begin
        s = new();
        $display("Valuye of data:%0d", s.data); //12
        s.display();    //12
        $display("Valuye of temp:%0d", s.temp); //34
        s.add();    //38
    end
endmodule

//extended class will take or inherit the properties of original class
//original class is parent class and extended class is child class