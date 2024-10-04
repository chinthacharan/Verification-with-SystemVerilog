//Trigger : ->
//sense event : edge sensitive blocking @(), level sensitive non blocking wait()

module tb;
    event a1, a2;

    initial begin
        -> a1;
        #10;
        -> a2;
    end
//with edge @() we might miss an event but with level sensitive wait() we wont miss an event
    initial begin
        //@(a1);
        wait(a1.triggered);
        $display("Event A1 trigger");
        //@(a2);
        wait(a2.triggered);
        $display("Event A2 Trigger");
    end
endmodule