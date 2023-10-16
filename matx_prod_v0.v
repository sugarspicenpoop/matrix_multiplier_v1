`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.09.2023 20:07:44
// Design Name: 
// Module Name: matx_prod_v0
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


module matx_prod_v0(
    input clk,
    input nrst,
    input start,
    input [15:0] A1_row,
    input [15:0] A2_row,
    input [15:0] A3_row,
    input [15:0] A4_row,
    input [15:0] x_col,
    output [31:0] b_col,
    output done
    );
    
    reg start_reg;
    wire [15:0] A_row;
    wire [3:0] A_elem, x_elem;
    reg [31:0] b_col_reg;
    reg done_reg;
    
    reg [3:0] index_reg, jndex_reg;
    wire [7:0] mul_res;
    reg [7:0] b_elem_reg;
    
    always @(posedge clk, negedge nrst) begin
        if (!nrst) begin
            start_reg <= 1'b0;
            done_reg <= 1'b0;
            b_col_reg <= 32'd0;
            index_reg <= 3'd0;
            jndex_reg <= 3'd0;
            b_elem_reg <= 8'd0;
        end else if (start == 1'b1 && start_reg == 1'b0) begin
            start_reg <= 1'b1;
        end else if (start_reg && !done_reg) begin
            // Multiply the first three columns
            if (jndex_reg < 3'd3) begin
                b_elem_reg <= b_elem_reg + mul_res; 
                jndex_reg <= jndex_reg + 1; 
            end else begin
                jndex_reg <= 3'd0;
                if (index_reg < 3'd3) begin
                    if (index_reg == 3'd0) begin
                        b_col_reg[31:24] <= b_elem_reg + mul_res;
                    end else if (index_reg == 3'd1) begin
                        b_col_reg[23:16] <= b_elem_reg + mul_res;
                    end else if (index_reg == 3'd2) begin
                        b_col_reg[15:8] <= b_elem_reg + mul_res;
                    end
                    b_elem_reg <= 8'd0;
                    index_reg <= index_reg + 1;
                end else begin
                    b_col_reg[7:0] <= b_elem_reg + mul_res;
                    start_reg <= 1'b0;
                    done_reg <= 1'b1;
                    index_reg <= 3'd0;
                end
            end
        end
    end
    
    assign done = done_reg;
    assign b_col = b_col_reg;
    
    assign A_row = (index_reg == 3'd0) ? A1_row :
                   (index_reg == 3'd1) ? A2_row :
                   (index_reg == 3'd2) ? A3_row :
                   (index_reg == 3'd3) ? A4_row : 16'd0;
    
    assign A_elem = (jndex_reg == 3'd0) ? A_row[15:12] :
                    (jndex_reg == 3'd1) ? A_row[11:8] :
                    (jndex_reg == 3'd2) ? A_row[7:4] :
                    (jndex_reg == 3'd3) ? A_row[3:0] : 4'd0;
    
    assign x_elem = (jndex_reg == 3'd0) ? x_col[15:12] :
                    (jndex_reg == 3'd1) ? x_col[11:8] :
                    (jndex_reg == 3'd2) ? x_col[7:4] :
                    (jndex_reg == 3'd3) ? x_col[3:0] : 4'd0;
    
    assign mul_res = A_elem * x_elem;
    
endmodule
