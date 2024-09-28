module tb;
    //default direction: input
    /*
    task add (input [3:0] a, input bit [3:0] b, output bit [4:0] y);
        y = a + b;
    endtask
    */
    bit [3:0] a, b;
    bit [4:0] y;

    bit clk = 0;
    always #10 clk = ~clk;

    task add ();
        y = a + b;
        $display("a: %0d and b: %0d and y:%0d", a, b, y);
    endtask

    task stim_a_b();
        a = 1;
        b = 3;
        add ();
        #10;
        a = 5; 
        b = 6;
        add ();
        #10
        a = 7;
        b = 8;
        add ();
        #10 
    endtask

    /*
    initial begin
        a = 7;
        b = 7;
        add(a, b, y);
        $display("value of y : %0d", y);
    end
    */

    task stim_clk ();
        @(posedge clk);
        a = $urandom();
        b = $urandom();
        add();
    endtask

    initial begin
        #110;
        $finish();
    end

    initial begin
        //stim_a_b();
        for(int i = 0; i<11 ; i++) begin
         stim_clk();
        end
    end
endmodule


module tb;
    bit [5:0] addr;
    bit en;
    bit wr;
    
    bit clk = 0;
    always #40 clk = ~clk;
    
    task gen_stimulus();
     @(posedge clk);
     en = $urandom();
     wr = $urandom();
     addr = $urandom();
    endtask

endmodule