//super allows a sub-class to access parent members
//Must be the first line of sub-class constructor to overwrite the implicit call

class frame;
    logic [4:0] addr;
    logic [7:0] payload;
    bit parity;

    function new(input int add, dat);
        addr = add;
        payload = dat;
        genpar();
    endfunction

    ...
endclass

class goodtagframe extends frame;
    ...
    function new(input int add, dat);
        super.new(add, dat);
        frmcount++;
        tag = frmcount;
    endfunction
    ...
endclass