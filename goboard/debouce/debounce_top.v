module Debounce_Project_Top
    (input i_Clk,
    input i_Switch_1,
    output o_LED_1);

    reg r_LED_1    = 1'b0;
    reg r_Switch_1 = 1'b0;
    wire w_Switch_1;

    Debounce_Switch Debounce_Inst
    (.i_Clk(i_Clk),
     .i_Switch(i_Switch_1),
     .o_Switch(w_Switch_1));

    always @(posedge i_Clk)
    begin
        r_Switch_1 <= w_Switch_1;

        if (w_Switch_1 == 1'b0 && r_Switch_1 == 1'b1)
        begin 
            r_LED_1 <= ~r_LED_1;
        end
    end

    assign o_LED_1 = r_LED_1;

endmodule