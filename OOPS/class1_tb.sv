class first;
 bit [2:0] data;
 bit [1:0] data2;

endclass

module tb;
 first f;
 //we cant directly use the handler to access the data in class like we did with modules
 //solution is to use the constructor incase of classes
 //f.data;
 //f.data2;
 initial begin
    //allocating the memory
    f = new();
    f.data = 3'b010;
    f.data2 = 2'b10;
    //way to deallocate the memory
    //f = null;
    #1;
    $display("value of data: %0d and data2: %0d", f.data, f.data2);
 end

endmodule