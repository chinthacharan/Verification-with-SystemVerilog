
//generally for scalar we use pass by value
// generally for arrays for pass by reference

//pass by value
module tb;
    task swap (input bit [1:0] a, b);
      bit [1:0] temp;
      temp = a;
      a = b;
      b = temp;
      $display("Value of a: %0d and b: %0d", a, b);
    endtask    

    bit [1:0] a;
    bit [1:0] b;
    initial begin
        a = 1;
        b = 2;
        swap(a,b);
        $display("value of a: %0d and b: %0d", a, b);
    end
endmodule

//pass by reference
module tb;
    task automatic swap (ref bit [1:0] a, b);
        bit [1:0] temp;
        temp = a;
        a = b;
        b = temp;
        $display("value of a:%0d and b:%0d", a, b);
    endtask

    bit [1:0] a;
    bit [1:0] b;
    initial begin
        a = 1;
        b = 2;
        swap(a, b);
        $display("value of a: %0d and b: %0d", a, b);
    end
endmodule