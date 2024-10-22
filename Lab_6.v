`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 01:44:07 PM
// Design Name: 
// Module Name: Lab_6
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


//module Lab_6(input S, R, clk, output Q, Qbar);
//    //part 1A
////    SR_latch SRL(S, R, Q, Qbar);
    
//    //part 1B
//    SR_FF SRFF(S, R, clk, Q, Qbar);
//endmodule

module SR_latch(input S, R, output Q, Qbar);
    nor #1 N1(Q, R, Qbar);
    nor #1 N2(Qbar, S, Q);
endmodule

module SR_FF(input S, R, clk, output reg Q, Qbar);
    always @(posedge clk)
        begin
            Q <= ~(R | Qbar);
            Qbar <= ~(S | Q);
        end
endmodule

module D_FF_Async(input D, RSTN, clk, output reg Q);
    always @(posedge clk or RSTN)
    begin
        if(!RSTN)
            Q<=0;
        else
            Q<=D;
    end
endmodule

module D_FF_Sync(input D, RSTN, clk, output reg Q);
    always @(posedge clk)
    begin
        if(!RSTN) //if(RST)
            Q<=0;
        else
            Q<=D;
    end
endmodule

module T_FF(input clk, RSTN, T, output reg Q);
    always @(posedge clk) begin
       if(!RSTN)
            Q<=0;
       else if(T)
            Q<=~Q;
       else
            Q<=Q;
    end
endmodule

module Counter(input clk, RSTN, output [2:0]Q);
    wire t2, t3;
    
    T_FF num1(clk, RSTN, 1, Q[0]); //RSTN = 1, T=1
    assign t2 = Q[0];
    T_FF num2(clk, RSTN, t2, Q[1]);
    assign t3 = Q[1]&Q[0];
    T_FF num3(clk, RSTN, t3, Q[2]);
endmodule

module Clock_Divider(clk_in, clk_out);
    input clk_in;
    output reg clk_out = 1'b0;
    reg [1:0] counter = 2'b0;
    
    always @(posedge clk_in) begin
        counter <= counter + 1;
        if (counter == 2'b01) begin
            clk_out <= ~clk_out; //toggle clk_out
            counter <= 0;
        end
    end
endmodule