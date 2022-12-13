module Debounce_Switch (input i_Clk, input i_Switch, output o_Switch);

    parameter c_DEBOUNCE_LIMIT = 250000; // 10 ms at 25 MHz

    reg [17:0] r_Count = 0;
    reg r_State = 1'b0;

    always @(posedge i_Clk)
    begin
        // switch input is differnet and the switch register value
        if (i_Switch !== r_State && r_Count < c_DEBOUNCE_LIMIT)
            // increase the counter until it's stable for enough time
            r_Count <= r_Count + 1;

        // end of the counter reached, switch is stable. register
        // the switch value and reset the counter
        else if (r_Count == c_DEBOUNCE_LIMIT)
        begin
            r_State <= i_Switch;
            r_Count <= 0;
        end

        // switches are the same, reset the count
        else
            r_Count <= 0;
    end

    assign o_Switch = r_State;

endmodule