module Project_7_Segment_Top
    (
        input i_Clk,
        input i_Switch_1,
        input i_Switch_2,
        input i_Switch_3,
        input i_Switch_4,

        output o_Segment1_A,
        output o_Segment1_B,
        output o_Segment1_C,
        output o_Segment1_D,
        output o_Segment1_E,
        output o_Segment1_F,
        output o_Segment1_G,

        output o_Segment2_A,
        output o_Segment2_B,
        output o_Segment2_C,
        output o_Segment2_D,
        output o_Segment2_E,
        output o_Segment2_F,
        output o_Segment2_G
    );

    wire w_Switch_1;
    wire w_Switch_2;
    wire w_Switch_3;
    wire w_Switch_4;

    reg r_Switch_1 = 1'b0;
    reg r_Switch_2 = 1'b0;
    reg r_Switch_3 = 1'b0;
    reg r_Switch_4 = 1'b0;

    reg [3:0] r_Count_1 = 4'b0000;
    reg [3:0] r_Count_2 = 4'b0000;

    wire w_Segment1_A;
    wire w_Segment1_B;
    wire w_Segment1_C;
    wire w_Segment1_D;
    wire w_Segment1_E;
    wire w_Segment1_F;
    wire w_Segment1_G;

    wire w_Segment2_A;
    wire w_Segment2_B;
    wire w_Segment2_C;
    wire w_Segment2_D;
    wire w_Segment2_E;
    wire w_Segment2_F;
    wire w_Segment2_G;

    Debounce_Switch Debounce_Switch_Inst_1
    (
        .i_Clk(i_Clk),
        .i_Switch(i_Switch_1),
        .o_Switch(w_Switch_1)
    );

    Debounce_Switch Debounce_Switch_Inst_2
    (
        .i_Clk(i_Clk),
        .i_Switch(i_Switch_2),
        .o_Switch(w_Switch_2)
    );

    Debounce_Switch Debounce_Switch_Inst_3
    (
        .i_Clk(i_Clk),
        .i_Switch(i_Switch_3),
        .o_Switch(w_Switch_3)
    );   
    
    Debounce_Switch Debounce_Switch_Inst_4
    (
        .i_Clk(i_Clk),
        .i_Switch(i_Switch_4),
        .o_Switch(w_Switch_4)
    );

    always @(posedge i_Clk)
    begin
        r_Switch_1 <= w_Switch_1;
        r_Switch_2 <= w_Switch_2;
        r_Switch_3 <= w_Switch_3;
        r_Switch_4 <= w_Switch_4;

        if (w_Switch_1 == 1'b1 && r_Switch_1 == 1'b0)
        begin
            if (r_Count_1 < 9)
                r_Count_1 <= r_Count_1 + 1;
        end

        if (w_Switch_2 == 1'b1 && r_Switch_2 == 1'b0)
        begin
            if (r_Count_1 > 0)
                r_Count_1 <= r_Count_1 - 1;
        end

        if (w_Switch_3 == 1'b1 && r_Switch_3 == 1'b0)
        begin
            if (r_Count_2 == 9) begin
                if (r_Count_1 < 9) begin
                    r_Count_1 <= r_Count_1 + 1;
                    r_Count_2 <= 0;
                end
            end else
                r_Count_2 <= r_Count_2 + 1;
        end

        if (w_Switch_4 == 1'b1 && r_Switch_4 == 1'b0)
        begin
            if (r_Count_2 == 0) begin
                if (r_Count_1 > 0) begin
                    r_Count_1 <= r_Count_1 - 1;
                    r_Count_2 <= 9;
                end
            end else if (r_Count_2 > 0)
                r_Count_2 <= r_Count_2 - 1;
        end

    end

    Binary_To_7Segment Inst_1 (
        .i_Clk(i_Clk),
        .i_Binary_Num(r_Count_1),
        .o_Segment_A(w_Segment1_A),
        .o_Segment_B(w_Segment1_B),
        .o_Segment_C(w_Segment1_C),
        .o_Segment_D(w_Segment1_D),
        .o_Segment_E(w_Segment1_E),
        .o_Segment_F(w_Segment1_F),
        .o_Segment_G(w_Segment1_G)
    );

        Binary_To_7Segment Inst_2 (
        .i_Clk(i_Clk),
        .i_Binary_Num(r_Count_2),
        .o_Segment_A(w_Segment2_A),
        .o_Segment_B(w_Segment2_B),
        .o_Segment_C(w_Segment2_C),
        .o_Segment_D(w_Segment2_D),
        .o_Segment_E(w_Segment2_E),
        .o_Segment_F(w_Segment2_F),
        .o_Segment_G(w_Segment2_G)
    );

    assign o_Segment1_A = ~w_Segment1_A;
    assign o_Segment1_B = ~w_Segment1_B;
    assign o_Segment1_C = ~w_Segment1_C;
    assign o_Segment1_D = ~w_Segment1_D;
    assign o_Segment1_E = ~w_Segment1_E;
    assign o_Segment1_F = ~w_Segment1_F;
    assign o_Segment1_G = ~w_Segment1_G;

    assign o_Segment2_A = ~w_Segment2_A;
    assign o_Segment2_B = ~w_Segment2_B;
    assign o_Segment2_C = ~w_Segment2_C;
    assign o_Segment2_D = ~w_Segment2_D;
    assign o_Segment2_E = ~w_Segment2_E;
    assign o_Segment2_F = ~w_Segment2_F;
    assign o_Segment2_G = ~w_Segment2_G;

endmodule