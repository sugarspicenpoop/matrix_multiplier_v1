`timescale 1ns / 1ps

module matx_prod_tb;
    
    reg clk;
    reg nrst;
    reg start;
    reg [3:0] A11, A12, A13, A14;
    reg [3:0] A21, A22, A23, A24;
    reg [3:0] A31, A32, A33, A34;
    reg [3:0] A41, A42, A43, A44;
    reg [3:0] x1, x2, x3, x4;
    wire [7:0] b1, b2, b3, b4;
    wire done;
    
    matx_prod_v1 uut(
        .clk(clk),
        .nrst(nrst),
        .start(start),
        .A1_row({A11, A12, A13, A14}),
        .A2_row({A21, A22, A23, A24}),
        .A3_row({A31, A32, A33, A34}),
        .A4_row({A41, A42, A43, A44}),
        .x_col({x1, x2, x3, x4}),
        .b_col({b1, b2, b3, b4}),
        .done(done));
    
    initial begin
        clk <= 1'b0;
        start <= 1'b0;
        
        // Set the x vector
        x1 = 4'd1;
        x2 = 4'd2;
        x3 = 4'd3;
        x4 = 4'd4;
        
        // Test 1
        nrst <= 1'b0;
        {A11, A12, A13, A14} <= 16'h1000;
        {A21, A22, A23, A24} <= 16'h0100;
        {A31, A32, A33, A34} <= 16'h0010;
        {A41, A42, A43, A44} <= 16'h0001;
        
        #20 nrst <= 1'b1;
        #10 start <= 1'b1;
        #10 start <= 1'b0;
        wait(done == 1'b1);
        #10;
        
        $display("----------");
        $display("Test 1");
        $display("Matrix A:");
        $display("[%d, %d ,%d ,%d]", A11, A12, A13, A14);
        $display("[%d, %d ,%d ,%d]", A21, A22, A23, A24);
        $display("[%d, %d ,%d ,%d]", A31, A32, A33, A34);
        $display("[%d, %d ,%d ,%d]", A41, A42, A43, A44);
        $write("Vector x: ");
        $display("[%d ,%d ,%d, %d]'", x1, x2, x3, x4);
        $write("Vector b: ");
        $display("[%d ,%d ,%d, %d]'", b1, b2, b3, b4);
        if (b1 != 1 || b2 != 2 || b3 != 3 || b4 != 4)
            $display("Test failed\n");
        else
            $display("Test passed!\n");
        
        // Test 2
        nrst <= 1'b0;
        {A11, A12, A13, A14} <= 16'h1001;
        {A21, A22, A23, A24} <= 16'h0110;
        {A31, A32, A33, A34} <= 16'h0110;
        {A41, A42, A43, A44} <= 16'h1001;
        
        #20 nrst <= 1'b1;
        #10 start <= 1'b1;
        #10 start <= 1'b0;
        wait(done == 1'b1);
        #10;
        
        $display("----------");
        $display("Test 2");
        $display("Matrix A:");
        $display("[%d, %d ,%d ,%d]", A11, A12, A13, A14);
        $display("[%d, %d ,%d ,%d]", A21, A22, A23, A24);
        $display("[%d, %d ,%d ,%d]", A31, A32, A33, A34);
        $display("[%d, %d ,%d ,%d]", A41, A42, A43, A44);
        $write("Vector x: ");
        $display("[%d ,%d ,%d, %d]'", x1, x2, x3, x4);
        $write("Vector b: ");
        $display("[%d ,%d ,%d, %d]'", b1, b2, b3, b4);
        if (b1 != 5 || b2 != 5 || b3 != 5 || b4 != 5)
            $display("Test failed\n");
        else
            $display("Test passed!\n");
        
        // Test 3
        nrst <= 1'b0;
        {A11, A12, A13, A14} <= 16'h0123;
        {A21, A22, A23, A24} <= 16'h4567;
        {A31, A32, A33, A34} <= 16'h89AB;
        {A41, A42, A43, A44} <= 16'hCDEF;
        
        #20 nrst <= 1'b1;
        #10 start <= 1'b1;
        #10 start <= 1'b0;
        wait(done == 1'b1);
        #10;
        
        $display("----------");
        $display("Test 3");
        $display("Matrix A:");
        $display("[%d, %d ,%d ,%d]", A11, A12, A13, A14);
        $display("[%d, %d ,%d ,%d]", A21, A22, A23, A24);
        $display("[%d, %d ,%d ,%d]", A31, A32, A33, A34);
        $display("[%d, %d ,%d ,%d]", A41, A42, A43, A44);
        $write("Vector x: ");
        $display("[%d ,%d ,%d, %d]'", x1, x2, x3, x4);
        $write("Vector b: ");
        $display("[%d ,%d ,%d, %d]'", b1, b2, b3, b4);
        if (b1 != 20 || b2 != 60 || b3 != 100 || b4 != 140)
            $display("Test failed\n");
        else
            $display("Test passed!\n");
        
        // Test 4
        nrst <= 1'b0;
        {A11, A12, A13, A14} <= 16'h1010;
        {A21, A22, A23, A24} <= 16'h2121;
        {A31, A32, A33, A34} <= 16'h3232;
        {A41, A42, A43, A44} <= 16'h4343;
        
        #20 nrst <= 1'b1;
        #10 start <= 1'b1;
        #10 start <= 1'b0;
        wait(done == 1'b1);
        #10;
        
        $display("----------");
        $display("Test 4");
        $display("Matrix A:");
        $display("[%d, %d ,%d ,%d]", A11, A12, A13, A14);
        $display("[%d, %d ,%d ,%d]", A21, A22, A23, A24);
        $display("[%d, %d ,%d ,%d]", A31, A32, A33, A34);
        $display("[%d, %d ,%d ,%d]", A41, A42, A43, A44);
        $write("Vector x: ");
        $display("[%d ,%d ,%d, %d]'", x1, x2, x3, x4);
        $write("Vector b: ");
        $display("[%d ,%d ,%d, %d]'", b1, b2, b3, b4);
        if (b1 != 4 || b2 != 14 || b3 != 24 || b4 != 34)
            $display("Test failed\n");
        else
            $display("Test passed!\n");
        
        // Test 5
        nrst <= 1'b0;
        {A11, A12, A13, A14} <= 16'h3210;
        {A21, A22, A23, A24} <= 16'h7654;
        {A31, A32, A33, A34} <= 16'hBA98;
        {A41, A42, A43, A44} <= 16'hFEDC;
        
        #20 nrst <= 1'b1;
        #10 start <= 1'b1;
        #10 start <= 1'b0;
        wait(done == 1'b1);
        #10;
        
        $display("----------");
        $display("Test 5");
        $display("Matrix A:");
        $display("[%d, %d ,%d ,%d]", A11, A12, A13, A14);
        $display("[%d, %d ,%d ,%d]", A21, A22, A23, A24);
        $display("[%d, %d ,%d ,%d]", A31, A32, A33, A34);
        $display("[%d, %d ,%d ,%d]", A41, A42, A43, A44);
        $write("Vector x: ");
        $display("[%d ,%d ,%d, %d]'", x1, x2, x3, x4);
        $write("Vector b: ");
        $display("[%d ,%d ,%d, %d]'", b1, b2, b3, b4);
        if (b1 != 10 || b2 != 50 || b3 != 90 || b4 != 130)
            $display("Test failed\n");
        else
            $display("Test passed!\n");
        
        $finish;
    end
    
    always @* begin
        #5 clk <= ~clk;
    end
    
endmodule