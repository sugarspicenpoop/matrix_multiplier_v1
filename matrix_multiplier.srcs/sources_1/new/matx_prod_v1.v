`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.09.2023 11:32:30
// Design Name: 
// Module Name: matx_prod_v1
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


module matx_prod_v1(
    input clk,
    input nrst,
    input start,
    input [15:0] A1_row,
    input [15:0] A2_row,
    input [15:0] A3_row,
    input [15:0] A4_row,
    input [15:0] x_col,
    output reg [31:0] b_col,
    output reg done
    );
    
    reg start_reg;
    wire [15:0] A_row;
    wire [3:0] A_elem, x_elem;
    
    reg [3:0] index_reg, jndex_reg;
    wire [7:0] mul_res;
    reg [7:0] b_elem_reg;
    
    reg [3:0] state;
    
    always @(posedge clk, negedge nrst) begin
        if (!nrst) begin
            start_reg <= 1'b0;
            done <= 1'b0;
            b_col <= 32'd0;
            index_reg <= 3'd0;
            jndex_reg <= 3'd0;
            b_elem_reg <= 8'd0;
            
            state <= 4'h0;
        end else begin
            case (state)
                4'h0: begin
                        start_reg <= 1'b1;
                        b_col[31:24] = A1_row[3:0] * x_col[3:0] + A1_row[7:4] * x_col[7:4] + A1_row[11:8] * x_col[11:8] + A1_row[15:12] * x_col[15:12];
                        state = 4'h1;
                      end
                4'h1: begin
                        b_col[23:16] = A2_row[3:0] * x_col[3:0] + A2_row[7:4] * x_col[7:4] + A2_row[11:8] * x_col[11:8] + A2_row[15:12] * x_col[15:12];
                        state = 4'h2;
                      end
                4'h2: begin
                        b_col[15:8] = A3_row[3:0] * x_col[3:0] + A3_row[7:4] * x_col[7:4] + A3_row[11:8] * x_col[11:8] + A3_row[15:12] * x_col[15:12];
                        state = 4'h3;
                      end
                4'h3: begin
                        b_col[7:0] = A4_row[3:0] * x_col[3:0] + A4_row[7:4] * x_col[7:4] + A4_row[11:8] * x_col[11:8] + A4_row[15:12] * x_col[15:12];
                        state = 4'h4;
                        done <= 1'b1;
                      end
                default: ;
            endcase
        end
    end
    
endmodule
