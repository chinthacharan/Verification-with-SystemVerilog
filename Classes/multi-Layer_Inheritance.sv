//Base class
class frame;
	logic [4:0] addr;
	logic [7:0] payload;
	logic parity = 0;

	function new (input int add, dat);
		addr = add;
		payload = dat;
		genpar();
	endfunction

	function void genpar();
		parity = ^(addr, payload);
	endfunction
endclass

//Sub-class
class tagframe extends frame;
    static int frmcount;
    int tag;

    function new(input int add, dat);
        super.new(add, dat);
        ...
    endfunction
    ...
endclass

//sub-class
class errframe extends tagframe;
    static int errcount;

    function new(input int add, dat);
        super.new(add, dat);
    endfunction
    ...
endclass

//you can pass argurments only one level at a time.
