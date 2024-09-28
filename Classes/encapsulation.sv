//Data can be hidden using local and protected 
//Parent-class
class frame;
    local logic [4:0] addr;   //visible inside the class
    local logic [7:0] payload;
    protected bit parity;    //visible inside and any sub-class (it can beinherited)
    function new( input int add, dat);
    ...
    endfunction
 ...
endclass

//sub-class
class tagframe extends frame;
    local static int frmcount;
    int tag;

    ...
endclass

//sub-class
class errframe extends tagframe;
    local static int errcount;
    ...
    function void add_error();
        parity = ~parity;
        errcount++;
    endfunction
endclass

errframe one = new(add1, data1)
initial begin  
    one.errcount = 0;  //ERROR
    one.parity = 1;  //ERROR
    one.add_error(); //OK
    ...
end

