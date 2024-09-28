class first;
    int data = 34;
    task display();
        $display("value of data: %0d", data);
    endtask
endclass

class second;
    first f1;
    //do not use void here as new function doesnot have return type
    function new();
        f1 = new();
    endfunction
endclass

module tb;
    second s;
    initial begin
       s = new(); 
       //$display("value of data: %0d",s.f1.data);
       s.f1.display(); //output is 34
       s.f1.data = 45;
       s.f1.display(); //output is 45
    end
endmodule