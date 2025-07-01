`timescale 1ns / 1ps

module tb_clock;

    // Inputs
    reg clk;
    reg reset;
    reg ena;

    // Outputs
    wire pm;
    wire [7:0] hh;
    wire [7:0] mm;
    wire [7:0] ss;

    // Instantiate the Unit Under Test (UUT)
    clock uut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .pm(pm),
        .hh(hh),
        .mm(mm),
        .ss(ss)
    );

    // Generate clock: 10ns period => 100 MHz
    always #5 clk = ~clk;

    initial begin
        $display("Time\t\tHH\tMM\tSS\tPM");
        $monitor("%0t\t\t%2h\t%2h\t%2h\t%b", $time, hh, mm, ss, pm);

        // Initialize inputs
        clk = 0;
        reset = 1;
        ena = 0;
        #20;

        // Release reset and enable counting
        reset = 0;
        ena = 1;

        // Simulate for a few minutes (simulate many seconds)
        #3000; // ~3μs of simulated time (you can increase to see minutes/hour transitions)

        // Stop simulation
        $finish;
    end

endmodule
