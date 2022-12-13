library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project_7_Segment_Top is 
    port (
        i_Clk      : in std_logic;
        i_Switch_1 : in std_logic;
        i_Switch_2 : in std_logic;
        i_Switch_3 : in std_logic;
        i_Switch_4 : in std_logic;

        o_Segment1_A : out std_logic;
        o_Segment1_B : out std_logic;
        o_Segment1_C : out std_logic;
        o_Segment1_D : out std_logic;
        o_Segment1_E : out std_logic;
        o_Segment1_F : out std_logic;
        o_Segment1_G : out std_logic;

        o_Segment2_A : out std_logic;
        o_Segment2_B : out std_logic;
        o_Segment2_C : out std_logic;
        o_Segment2_D : out std_logic;
        o_Segment2_E : out std_logic;
        o_Segment2_F : out std_logic;
        o_Segment2_G : out std_logic
    );

end entity Project_7_Segment_Top;

architecture RTL of Project_7_Segment_Top is
    signal w_Switch_1 : std_logic;  
    signal r_Switch_1 : std_logic := '0';

    signal w_Switch_2 : std_logic;
    signal r_Switch_2 : std_logic := '0';

    signal w_Switch_3 : std_logic;
    signal r_Switch_3 : std_logic := '0';

    signal w_Switch_4 : std_logic;
    signal r_Switch_4 : std_logic := '0';

    signal r_Count_1 : integer range 0 to 9 := 0;
    signal r_Count_2 : integer range 0 to 9 := 0;

    signal w_Segment1_A : std_logic;
    signal w_Segment1_B : std_logic;
    signal w_Segment1_C : std_logic;
    signal w_Segment1_D : std_logic;
    signal w_Segment1_E : std_logic;
    signal w_Segment1_F : std_logic;
    signal w_Segment1_G : std_logic;

    signal w_Segment2_A : std_logic;
    signal w_Segment2_B : std_logic;
    signal w_Segment2_C : std_logic;
    signal w_Segment2_D : std_logic;
    signal w_Segment2_E : std_logic;
    signal w_Segment2_F : std_logic;
    signal w_Segment2_G : std_logic;

    begin
        Debounce1_Inst : entity work.Debounce_Switch
        port map (
          i_Clk    => i_Clk,
          i_Switch => i_Switch_1,
          o_Switch => w_Switch_1
        );

        Debounce2_Inst : entity work.Debounce_Switch
        port map (
          i_Clk    => i_Clk,
          i_Switch => i_Switch_2,
          o_Switch => w_Switch_2
        );

        Debounce3_Inst : entity work.Debounce_Switch
        port map (
          i_Clk    => i_Clk,
          i_Switch => i_Switch_3,
          o_Switch => w_Switch_3
        );

        Debounce4_Inst : entity work.Debounce_Switch
        port map (
          i_Clk    => i_Clk,
          i_Switch => i_Switch_4,
          o_Switch => w_Switch_4
        );

        p_Switch_Count : process(i_Clk)
        begin
            if rising_edge(i_Clk) then
                r_Switch_1 <= w_Switch_1;
                r_Switch_2 <= w_Switch_2;
                r_Switch_3 <= w_Switch_3;
                r_Switch_4 <= w_Switch_4;

                if (w_Switch_1 = '1' and r_Switch_1 = '0') then
                    if (r_Count_1 = 9) then
                      -- do nothing if we are at 9x
                      -- r_count_1 <= 0;
                    else
                      r_count_1 <= r_Count_1 + 1; 
                    end if; 
                end if;

                if (w_Switch_2 = '1' and r_Switch_2 = '0') then
                    if (r_Count_1 = 0) then
                      -- r_Count_1 <= 9;
                      --r_Count_2 <= 9;
                    else
                      r_Count_1 <= r_Count_1 - 1; 
                    end if; 
                end if;

                if (w_Switch_3 = '1' and r_Switch_3 = '0') then
                    if (r_Count_2 = 9) then
                      if (r_Count_1 < 9) then
                        r_Count_2 <= 0;
                        r_Count_1 <= r_Count_1 + 1; 
                      end if;
                    else
                      r_Count_2 <= r_Count_2 + 1;
                    end if; 
                end if;

                if (w_Switch_4 = '1' and r_Switch_4 = '0') then
                    if (r_Count_2 = 0 and r_Count_1 >= 1) then
                      r_Count_2 <= 9;
                      r_Count_1 <= r_Count_1 - 1;
                    elsif (r_Count_2 = 0 and r_Count_1 = 0) then
                        -- do nothing, we are now at 00
                    else
                      r_Count_2 <= r_Count_2 - 1; 
                    end if; 
                end if;
            end if; 
        end process p_Switch_Count;

        SevenSeg1_Inst : entity work.Binary_To_7Segment 
        port map(
            i_Clk => i_Clk,
            i_Binary_Num => std_logic_vector(to_unsigned(r_Count_1, 4)),
            o_Segment_A  => w_Segment1_A,
            o_Segment_B  => w_Segment1_B,
            o_Segment_C  => w_Segment1_C,
            o_Segment_D  => w_Segment1_D,
            o_Segment_E  => w_Segment1_E,
            o_Segment_F  => w_Segment1_F,
            o_Segment_G  => w_Segment1_G
        );

        o_Segment1_A <= not w_Segment1_A;
        o_Segment1_B <= not w_Segment1_B;
        o_Segment1_C <= not w_Segment1_C;
        o_Segment1_D <= not w_Segment1_D;
        o_Segment1_E <= not w_Segment1_E;
        o_Segment1_F <= not w_Segment1_F;
        o_Segment1_G <= not w_Segment1_G;

        SevenSeg2_Inst : entity work.Binary_To_7Segment 
        port map(
            i_Clk => i_Clk,
            i_Binary_Num => std_logic_vector(to_unsigned(r_Count_2, 4)),
            o_Segment_A  => w_Segment2_A,
            o_Segment_B  => w_Segment2_B,
            o_Segment_C  => w_Segment2_C,
            o_Segment_D  => w_Segment2_D,
            o_Segment_E  => w_Segment2_E,
            o_Segment_F  => w_Segment2_F,
            o_Segment_G  => w_Segment2_G
        );

        o_Segment2_A <= not w_Segment2_A;
        o_Segment2_B <= not w_Segment2_B;
        o_Segment2_C <= not w_Segment2_C;
        o_Segment2_D <= not w_Segment2_D;
        o_Segment2_E <= not w_Segment2_E;
        o_Segment2_F <= not w_Segment2_F;
        o_Segment2_G <= not w_Segment2_G;

    end architecture RTL;