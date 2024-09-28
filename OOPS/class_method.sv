//ways of assigning a method to a class
//Task and Function
//Task supports timing control where a function do not support timing control
//Task support multiple output port where a function do not support output port

task sys_rst();
 rst <= 1'b1;
 #30
 rst <= 1'b0;
endtask 


module tb;
    bit [4:0] res = 0;
    bit [3:0] ain = 4'b0100;
    bit [3:0] bin = 4'b0010;

    function bit [4:0] add(input bit[3:0] a, b);
     return a + b;
    endfunction

    function void display_ain_bin();
    //do not use the delay before display here as timing control is not allowed in function
        $display("Value of ain: %0d, value of bin:%bin" ain, bin);
    endfunction

    initial begin
        res = add(4'b0100, 4'b0010);
        display_ain_bin();
        $display("valuye of addition: %0d", res);
    end
endmodule

