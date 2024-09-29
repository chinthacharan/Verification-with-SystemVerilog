//Design file
module fifo(
    input wreq, rreq,
    input clk,
    input rst,
    input [7:0] wdata,
    output [7:0] rdata,
    output f, e
);

endmodule

//testbench file
class transaction;
    bit clk;
    bit rst;

    rand bit wreq, rreq;
    rand bit [7:0] wdata;
    rand bit [7:0] rdata;
    bit empty;
    bit full;

    constraint cntrl_wr {
        wreq dist {0 := 30; 1 := 70;};
    }

    constraint cntrl_rd {
        rreq dist {0 := 30; 1 := 70;};
    }

    constraint wr_rd{
        wreq != rreq;
    }

endclass