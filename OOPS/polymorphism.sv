class first;
    int data = 12;

    virtual function void display();    //declare all classes as virtual
        $display("First: Value of data: %0d", data);
    endfunction
endclass

class second extends first; //child class
    int temp = 34;

    function void add();
        $display("second: Value after addition: %0d", temp+4);
    endfunction

    function void display();        //same function name as parent class
        $display("second: value of data: %0d", data);
    endfunction
endclass

module tb;
    first f;
    second s;

    initial begin
        f = new();
        s = new();

        f = s;
        f.display();

    end
endmodule

//In cases where method with same name present in parent and child class
//Polymorphism
//If there any update to the function then the function from first is displayed if there is no change in fucntion then funciton from second class is displayed
