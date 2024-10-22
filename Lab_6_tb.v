`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 01:49:01 PM
// Design Name: 
// Module Name: Lab_6_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Lab_6_tb();
    //part 1A
    //SR_latch_tb uut();
    
    //part 1B
    //SR_FF_tb uut();
    
    //part 2
    //D_FF_tb uut();
    
    //part 3A
    //T_FF_tb uut();
    
    //part 3B
    //Counter_tb uut();
    
    //part 4
    Clock_Divider_tb uut();
endmodule

module SR_latch_tb();
    reg r, s;
    wire q, qbar;
    
    SR_latch dut(s, r, q, qbar);
    
    initial
        begin
            r = 0; s = 0;
            #5 s=1;
            #5 s=0;
            #5 r=1;
            #5 r=0; s=1;
            #5 s=0; r=1;
            #5 r=0; 
            #5 r=1; s=1;
        end
endmodule

module SR_FF_tb();
    reg r, s, clk;
    wire q, qbar;
    
    SR_FF dut(s, r, clk, q, qbar);
    
    always #2 clk = ~clk;
    
    initial
        begin
            clk = 0;
            r = 0; s = 0;
            #10 s=1;
            #10 s=0;
            #10 r=1;
            #10 r=0; s=1;
            #10 s=0; r=1;
            #10 r=0; 
            #10 r=1; s=1;
        end
endmodule

module D_FF_tb();
    reg clk, d, rstn;
    reg [2:0] delay;
    wire qA, qS;
    
    D_FF_Async dut(d, rstn, clk, qA);
    D_FF_Sync dut1(d, rstn, clk, qS);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        d = 0;
        rstn = 0;
        
        #10 d =1;
        #10 rstn  = 1; 
        #10 d =1;
        #5 d=0;
        #10 d =1;
        #5;
        #10 rstn  = 0;
        #10 d =0;
        #10;
    end
endmodule

module T_FF_tb();
    reg clk, t, rstn;
    wire q;
    
    T_FF dut(clk, rstn, t, q);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        t = 0;
        rstn = 0;
        
        #10 t = 1;
        #10 rstn = 1; 
        #10 t = 1;
        #5 t = 0;
        #10 t = 1;
        #5;
        #10 rstn = 0;
        #10 t = 0;
        #10;
    end
endmodule

module Counter_tb();
    reg clk, rstn;
    wire [2:0] q;
    
    Counter dut(clk, rstn, q);
    
    always #1 clk = ~clk;
    
    initial begin 
        clk = 0; rstn=0; 
        #5 rstn = 1; 
    end
endmodule

module Clock_Divider_tb();
    reg clk_in;
    wire clk_out;
    
    Clock_Divider dut(clk_in, clk_out);
    
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in;
    end
endmodule