//Aggregation refers to a class which collects a number of other classes into one object

class frame;
    logic [4:0] addr;
    logic [7:0] payload;
    bit parity;

    function new(input int add, dat);
        addr = add;
        payload = dat;
        genpar();
        ...
    endfunction

    ...
endclass

class twoframe;
    frame f1;
    frame f2;

    function new(input int basea, d1, d2);
        f1 = new(basea, d1);
        f2 = new(basea+1, d2);
    endfunction
    ...
endclass

twoframe tf1 = new(2, 3, 4);
initial begin
    tf1.f2.addr = 4;
    $display("base %h",tf1.f1.addr)
end