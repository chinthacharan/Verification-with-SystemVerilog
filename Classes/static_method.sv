class frame;
    static int frmcount;
    int tag;
    logic [4:0] addr;
    logic [7:0] payload;
    logic parity;

    function new (input int add, dat);
        addr = add;
        payload = dat;
        genpar();
        frmcount++;
        tag = frmcount();
    endfunction

    static function int getcount();
        return (frmcount);
    endfunction

    ...
endclass

int frames;
frame f1, f2;
initial begin
    frames = f1.getcount(); //0
    frames = frame::getcount(); //0

    f1 = new(3, 4);
    f2 = new(5, 6);
    frames = f2.getcount(); //2
end