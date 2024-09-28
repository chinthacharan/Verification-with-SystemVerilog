//static property is shared by all the instances of a class

class frame;
    static int frmcount;
    int tag;
    logic [4:0] addr;
    logic [7:0] payload;
    logic parity;

    function new(input int add, dat);
        addr = add;
        payload = dat;
        genpar();
        frmcount++;
        tag = frmcount;
    endfunction
    
    ...
endclass

frame f1 = new(1,0)
//f1 => frmcount 1, tag 1, addr 1, Payload 0 and parity 1

frame f2 = new(3, 2)
//f1 => frmcount 2, tag 1, addr 1, payload 0 and parity 1
//f2 => frmcount 2, tag 2, addr 3, payload 2 and parity 1

//see how the static property is updated in f1