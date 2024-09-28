class first;
    int data = 12;
    //instead of utilizing the handler in the second class use the copy funciton here

    function first copy();
        copy = new();
        copy.data = data;
    endfunction
endclass

class second;
    int ds = 34;

    first f1;

    function new();
        f1 = new();
    endfunction

    function second copy();
        copy = new();
        copy.ds = ds;
        copy.f1 = f1.copy;
    endfunction

endclass

module tb;
    second s1, s2;
    initial begin
        s1 = new();
        s2 = new();
        s1.ds = 45;
        s2 = s1.copy();
        $display("Value of s2: %0d", s2.ds); //45
        s2.ds = 37;
        $display("Value of s1: %0d", s1.ds); //45 The value of s1.ds is not updated that means changed made in copy object data is not updated in the original object data member
        
        s2.f1.data = 90;
        $display("Value of s1: %0d", s1.f1.data); //12 the value of classes cant be updated fromt the copy object class
    end
endmodule

//Both data members and class from the copoy object can't update the original class and data members of original object
//This is deep copy

//summary

//only datamembers => create custom copy method => task
//Data Member + Other class instance => shallow copy => copy of DM + class handlers for both original as well as copy remain same
//Data member + Other class instance => deep copy => copy of DM + independent handler for the class 