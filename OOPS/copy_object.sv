class first;
    int data;
endclass

module tb;
    first f1;
    first p1; //copy of original class

    initial begin
        f1 = new();  //step1: constructor
        f1.data = 24; // step2: processing

        p1 = new f1; //step3: create an object and copy the f1 contents of f2
        $display("value of data member: %0d", p1.data); //4: processing

        p1.data = 32;
        $display("value of data member: %0d", p1.data); //You will still see the value of 24 instead of 32 as you wont get the access to the data but only the value
    end

endmodule