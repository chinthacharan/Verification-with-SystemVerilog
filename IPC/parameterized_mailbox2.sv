class transaction;
    bit [7:0] data;
endclass

class generator;
    int data = 12;
    transaction t;

    mailbox #(transaction) mbx;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        t.new();
        t.data = 45;
        mbx.put(temp);
        $display("[GEN] : Data send from Gen : %0d", t.data);
    endtask
endclass

class driver;
    mailbox #(transaction) mbx;
    transaction data;

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction

    task run();
        mbx.get(data);
        $display("[DRV]: Data Rcvd : %0d", data.data);
    endtask
endclass

module tb;
    generator gen;
    driver drv;
    mailbox #(transaction) mbx;

    initial begin
        mbx = new();
        gen = new(mbx);
        drv = new(mbx);

        gen.run();
        drv.run();
    end
endmodule