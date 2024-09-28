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

	function logic [13:0] getframe();
		return ({addr, payload, parity});
	endfunction
endclass


logic [13:0] framedata;
frame one = new(3, 16);

initial begin
    ...
	@(negedge clk);
	framedata = one.getframe();
    ...
end