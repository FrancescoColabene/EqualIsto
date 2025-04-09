


-- Stefano Carraro 10583364
-- Francesco Colabene 10675235


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity demux is 
    Port(
        sel: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(8 downto 0);
        out0,out1: out STD_LOGIC_VECTOR(8 downto 0)
    );
end demux;

architecture Behavioral of demux is 
begin
    process(input,sel)
    begin
        if sel = '0' then
            out0 <= input;
            out1 <= "000000000";
        elsif sel = '1' then
            out1 <= input;
            out0 <= "000000000";
        else 
            out1 <= "XXXXXXXXX";
            out0 <= "XXXXXXXXX";
        end if;
    end process;
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity sum_end is
    Port(
        r1,r2,r3,r4,r5,r6,r7,r8: in STD_LOGIC_VECTOR(7 downto 0);
        output : out STD_LOGIC_VECTOR(15 downto 0)
    );
end sum_end;

architecture Behavioral of sum_end is
begin
    process(r1,r2,r3,r4,r5,r6,r7,r8)
    begin
        output <= '0' & r8 & '0' + r7 & '0' + r6 & '0' + r5 & '0' + r4 & '0' + r3 & '0' + r2 & '0' + r1;
    end process;
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity par_sum is
    Port(
        x: in STD_LOGIC_VECTOR(7 downto 0);
        y: in STD_LOGIC;
        z: out STD_LOGIC_VECTOR(7 downto 0)
    );
end par_sum;

architecture Behavioral of par_sum is
begin
    process(x,y)
    begin
        if y = '0' then
            z <= (others =>'0');
        else
            z <= x;
        end if;
    end process;
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity mult is
    Port(
        i_1mult: in STD_LOGIC_VECTOR(7 downto 0);
        i_2mult: in STD_LOGIC_VECTOR(7 downto 0);
        o_mult: out STD_LOGIC_VECTOR(15 downto 0)
    );
end mult;

architecture Behavioral of mult is
signal f: STD_LOGIC_VECTOR(63 downto 0);
component par_sum is
    Port(
        x: in STD_LOGIC_VECTOR(7 downto 0);
        y: in STD_LOGIC;
        z: out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;
component sum_end is
    Port(
        r1,r2,r3,r4,r5,r6,r7,r8: in STD_LOGIC_VECTOR(7 downto 0);
        output : out STD_LOGIC_VECTOR(15 downto 0)
    );
end component;
begin
M1 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(0),
    z => f(7 downto 0)
    );
M2 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(1),
    z => f(15 downto 8)
    );
M3 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(2),
    z => f(23 downto 16)
    );
M4 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(3),
    z => f(31 downto 24)
    );
M5 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(4),
    z => f(39 downto 32)
    );
M6 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(5),
    z => f(47 downto 40)
    );
M7 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(6),
    z => f(55 downto 48)
    );
M8 : par_sum
    port map(
    x => i_1mult,
    y => i_2mult(7),
    z => f(63 downto 56)
    );

MX : sum_end
    port map(
    r1 => f(7 downto 0),
    r2 => f(15 downto 8),
    r3 => f(23 downto 16),
    r4 => f(31 downto 24),
    r5 => f(39 downto 32),
    r6 => f(47 downto 40),
    r7 => f(55 downto 48),
    r8 => f(63 downto 56),
    output => o_mult
    );
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    Port(
        i_clk: in STD_LOGIC;
        i_rst: in STD_LOGIC;
        i_data: in STD_LOGIC_VECTOR (7 downto 0);
        o_data: out STD_LOGIC_VECTOR (7 downto 0);
        r1_load: in STD_LOGIC;
        r2_load: in STD_LOGIC;
        r3_load: in STD_LOGIC;
        r4_load: in STD_LOGIC;
        r5_load: in STD_LOGIC;
        r6_load: in STD_LOGIC;
        r8_load: in STD_LOGIC;
        r9_load: in STD_LOGIC;
        r12_load: in STD_LOGIC;
        dem2_sel: in STD_LOGIC;
        dem3_sel: in STD_LOGIC;
        dem4_sel: in STD_LOGIC;
        muxr3_sel: in STD_LOGIC;
        muxr4_sel: in STD_LOGIC;
        muxr5_sel: in STD_LOGIC;
        mux1_sel: in STD_LOGIC;
        mux2_sel: in STD_LOGIC;
        muxr8_sel: in STD_LOGIC;
        muxr9_sel: in STD_LOGIC_VECTOR (1 downto 0);
        mux3_sel: in STD_LOGIC;
        o_end: out STD_LOGIC;
        o_max: out STD_LOGIC;
        o_min: out STD_LOGIC;
        o_top: out STD_LOGIC;
        o_gr: out STD_LOGIC;
        o_cond: out STD_LOGIC;
        
        o_reg4: inout STD_LOGIC_VECTOR(15 downto 0);
        sum_2: inout STD_LOGIC_VECTOR (15 downto 0)
        );
end datapath;

architecture Behavioral of datapath is

component demux is
    Port(
            sel: in STD_LOGIC;
            input: in STD_LOGIC_VECTOR(8 downto 0);
            out0,out1: out STD_LOGIC_VECTOR(8 downto 0)
    );
end component;

component mult is
    Port (
             i_1mult: in STD_LOGIC_VECTOR (7 downto 0);
             i_2mult: in STD_LOGIC_VECTOR (7 downto 0);
             o_mult: out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;

signal o_reg1: STD_LOGIC_VECTOR (7 downto 0);
signal o_reg2: STD_LOGIC_VECTOR (7 downto 0);
signal o_reg3: STD_LOGIC_VECTOR (15 downto 0);
signal o_reg5: STD_LOGIC_VECTOR (8 downto 0);
signal o_reg6: STD_LOGIC_VECTOR (7 downto 0);
signal o_reg8: STD_LOGIC_VECTOR (8 downto 0);
signal o_reg9: STD_LOGIC_VECTOR (3 downto 0);  
signal o_reg12: STD_LOGIC_VECTOR (15 downto 0);
signal demux2_0: STD_LOGIC_VECTOR (8 downto 0);
signal demux2_1: STD_LOGIC_VECTOR (8 downto 0);
signal demux3_0: STD_LOGIC_VECTOR (8 downto 0);
signal demux3_1: STD_LOGIC_VECTOR (8 downto 0);
signal demux4_0: STD_LOGIC_VECTOR (8 downto 0);
signal demux4_1: STD_LOGIC_VECTOR (8 downto 0); 
signal muxr3: STD_LOGIC_VECTOR (15 downto 0);
signal muxr4: STD_LOGIC_VECTOR (15 downto 0);
signal muxr5: STD_LOGIC_VECTOR (8 downto 0);
signal mux_sub: STD_LOGIC_VECTOR (8 downto 0);
signal mux_sum: STD_LOGIC_VECTOR (8 downto 0);
signal muxr8: STD_LOGIC_VECTOR (8 downto 0);
signal muxr9: STD_LOGIC_VECTOR (3 downto 0);
signal shift_2: STD_LOGIC_VECTOR (9 downto 0);
signal shift_3: STD_LOGIC_VECTOR (15 downto 0);
signal sub_1: STD_LOGIC_VECTOR (15 downto 0);
signal sub_2: STD_LOGIC_VECTOR (8 downto 0);
signal sub_3: STD_LOGIC_VECTOR (7 downto 0);
signal sub_4: STD_LOGIC_VECTOR (8 downto 0);
signal sum_1: STD_LOGIC_VECTOR (15 downto 0);
signal sum_3: STD_LOGIC_VECTOR (8 downto 0);

signal multin1: STD_LOGIC_VECTOR (7 downto 0);
signal multin2: STD_LOGIC_VECTOR (7 downto 0);
signal multout: STD_LOGIC_VECTOR (15 downto 0);

begin   
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg1 <= "00000000";
        elsif rising_edge(i_clk) then
            if r1_load = '1' then
                o_reg1 <= i_data;
            end if;
        end if;
    end process;
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg2 <= "00000000";
        elsif rising_edge(i_clk) then
            if r2_load = '1' then
                o_reg2 <= i_data;
            end if;
        end if;
    end process;
    
    M1: mult port map(
        i_1mult => multin1,
        i_2mult => multin2,
        o_mult => multout
    );

    multin1 <= o_reg1;
    multin2 <= o_reg2;

    with muxr3_sel select
    muxr3 <= multout when '0',
             sub_1 when '1',
             "XXXXXXXXXXXXXXXX" when others;
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg3 <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if r3_load = '1' then
                o_reg3 <= muxr3;
            end if;
        end if;
    end process;
    
    sub_1 <= o_reg3 - "0000000000000001";

    o_end <= '1' when (o_reg3 = "000000000000000") else '0';

    with muxr4_sel select
    muxr4 <= "0000000000000010" when '0',
             sum_1 when '1',
             "XXXXXXXXXXXXXXXX" when others;
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg4 <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if r4_load = '1' then
                o_reg4 <= muxr4;
            end if;
        end if;
    end process;
    
    sum_1 <= o_reg4 + "0000000000000001";
    
    sum_2 <= multout + o_reg4;
    
    o_max <= '1' when ('0' & i_data > o_reg5) else '0';
    
    with muxr5_sel select
    muxr5 <= demux4_0 when '0',
             '0' & i_data when '1',
             "XXXXXXXXX" when others;

    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg5 <= "000000000";
        elsif rising_edge(i_clk) then
            if r5_load = '1' then
                o_reg5 <= muxr5;
            end if;
        end if;
    end process;
    
    o_min <= '1' when (i_data < o_reg6) else '0';
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg6 <= "00000000";
        elsif rising_edge(i_clk) then
            if r6_load = '1' then
                o_reg6 <= i_data;
            end if;
        end if;
    end process;

    DE2: demux port map(
        sel => dem2_sel,
        input => o_reg5,
        out0 => demux2_0, 
        out1 => demux2_1
    );

    with mux1_sel select
    mux_sub <= demux2_1 when '0',
             '0' & i_data when '1',
             "XXXXXXXXX" when others;

    sub_2 <= (mux_sub - ('0' & o_reg6));

    DE3: demux port map(
        sel => dem3_sel,
        input => sub_2,
        out0 => demux3_0,
        out1 => demux3_1
    );
              
    with mux2_sel select
    mux_sum <= demux3_1 when '0',
             "00000" & o_reg9 when '1',
             "XXXXXXXXX" when others;
             
    sum_3 <= (mux_sum + "000000001");
    
    DE4: demux port map(
        sel => dem4_sel,
        input => sum_3,
        out0 => demux4_0,
        out1 => demux4_1
    );
    
    sub_3 <= ("00001000" - o_reg9);
    
    with muxr9_sel select
    muxr9 <= "0000" when "00",
             demux4_1 (3 downto 0) when "01",
             sub_3 (3 downto 0) when "11",
             "XXXX" when others; 
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg9 <= "0000";
        elsif rising_edge(i_clk) then
            if r9_load = '1' then
                o_reg9 <= muxr9;
            end if;
        end if;
    end process;
    
    
    with muxr8_sel select
    muxr8 <= "000000010" when '0',
             shift_2 (8 downto 0) when '1',
             "XXXXXXXXX" when others;
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg8 <= "000000000";
        elsif rising_edge(i_clk) then
            if r8_load = '1' then
                o_reg8 <= muxr8;
            end if;
        end if;
    end process;
    
    sub_4 <= (demux2_0 - o_reg8);
    
    
    shift_2 <= o_reg8 (8 downto 0) & "0";
    
    o_top <= '1' when (demux2_0 = "100000000") else '0';
    
    o_gr <= '1' when (sub_4 > "100000000") else '0';
    
    
    process(demux3_0,o_reg9)
    begin
        case o_reg9 (3 downto 0) is
            when "0000" =>
                shift_3 <=  "00000000" & demux3_0(7 downto 0);
                
            when "0001" =>
                shift_3 <=  "0000000" & demux3_0(7 downto 0) & "0";
                
            when "0010" =>
                shift_3 <=  "000000" & demux3_0(7 downto 0) & "00";
                
            when "0011" =>
                shift_3 <=  "00000" & demux3_0(7 downto 0) & "000";
                
            when "0100" =>
                shift_3 <=  "0000" & demux3_0(7 downto 0) & "0000";
                               
            when "0101" =>
                shift_3 <=  "000" & demux3_0(7 downto 0) & "00000";
                
            when "0110" =>
                shift_3 <=  "00" & demux3_0(7 downto 0) & "000000";
                
            when "0111" =>
                shift_3 <=  "0" & demux3_0(7 downto 0) & "0000000";
                
            when "1000" =>                                                   
                shift_3 <=  "0000000000000000";             --in realtà questo caso è superfluo: infatti il delta sarebbe 0, cioè CUR-MIN = 0 sempre!
                
            when others =>
                shift_3 <=  "XXXXXXXXXXXXXXXX";
        end case;
    end process;
    
    
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            o_reg12 <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if r12_load = '1' then
                o_reg12 <= shift_3;
            end if;
        end if;
    end process;      
    
    o_cond <= '1' when (o_reg12 > "0000000011111111") else '0'; 
    
    with mux3_sel select
    o_data <= o_reg12 (7 downto 0) when '0',
              "11111111" when '1',
              "XXXXXXXX" when others;
    
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity project_reti_logiche is
    Port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            i_start : in std_logic;
            i_data : in std_logic_vector(7 downto 0);
            o_address : out std_logic_vector(15 downto 0);
            o_done : out std_logic;
            o_en : out std_logic;
            o_we : out std_logic;
            o_data : out std_logic_vector (7 downto 0)
    );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
component datapath is
    Port ( 
        i_clk : in STD_LOGIC;
        i_rst: in STD_LOGIC;
        i_data: in STD_LOGIC_VECTOR(7 downto 0);
        o_data: out STD_LOGIC_VECTOR(7 downto 0);
        r1_load: in STD_LOGIC;
        r2_load: in STD_LOGIC;
        r3_load: in STD_LOGIC;
        r4_load: in STD_LOGIC;
        r5_load: in STD_LOGIC;
        r6_load: in STD_LOGIC;
        r8_load: in STD_LOGIC;
        r9_load: in STD_LOGIC;
        r12_load: in STD_LOGIC;
        dem2_sel: in STD_LOGIC;
        dem3_sel: in STD_LOGIC;
        dem4_sel: in STD_LOGIC;
        muxr3_sel: in STD_LOGIC;
        muxr4_sel: in STD_LOGIC;
        muxr5_sel: in STD_LOGIC;
        mux1_sel: in STD_LOGIC;
        mux2_sel: in STD_LOGIC;
        muxr8_sel: in STD_LOGIC;
        muxr9_sel: in STD_LOGIC_VECTOR (1 downto 0);
        mux3_sel: in STD_LOGIC;
        o_end: out STD_LOGIC;
        o_max: out STD_LOGIC;
        o_min: out STD_LOGIC;
        o_top: out STD_LOGIC;
        o_gr: out STD_LOGIC;
        o_cond: out STD_LOGIC;
        
        o_reg4: inout STD_LOGIC_VECTOR(15 downto 0);
        sum_2: inout STD_LOGIC_VECTOR(15 downto 0)
        );
end component;

signal r1_load: STD_LOGIC;
signal r2_load: STD_LOGIC;
signal r3_load: STD_LOGIC;
signal r4_load: STD_LOGIC;
signal r5_load: STD_LOGIC;
signal r6_load: STD_LOGIC;
signal r8_load: STD_LOGIC;
signal r9_load: STD_LOGIC;
signal r12_load: STD_LOGIC;
signal dem2_sel: STD_LOGIC;
signal dem3_sel: STD_LOGIC;
signal dem4_sel: STD_LOGIC;
signal muxr3_sel: STD_LOGIC;
signal muxr4_sel: STD_LOGIC;
signal muxr5_sel: STD_LOGIC;
signal mux1_sel: STD_LOGIC;
signal mux2_sel: STD_LOGIC;
signal muxr8_sel: STD_LOGIC;
signal muxr9_sel: STD_LOGIC_VECTOR (1 downto 0);
signal mux3_sel: STD_LOGIC;
signal o_end: STD_LOGIC;
signal o_max: STD_LOGIC;
signal o_min: STD_LOGIC;
signal o_top: STD_LOGIC;
signal o_gr: STD_LOGIC;
signal o_cond: STD_LOGIC;

signal o_reg4: STD_LOGIC_VECTOR(15 downto 0);
signal sum_2: STD_LOGIC_VECTOR(15 downto 0);

type S is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19);
signal cur_state, next_state: S;

begin

    D1: datapath port map(
        i_clk,
        i_rst,
        i_data,
        o_data,
        r1_load,
        r2_load,
        r3_load,
        r4_load,
        r5_load,
        r6_load,
        r8_load,
        r9_load,
        r12_load,
        dem2_sel,
        dem3_sel,
        dem4_sel,
        muxr3_sel,
        muxr4_sel,
        muxr5_sel,
        mux1_sel,
        mux2_sel,
        muxr8_sel,
        muxr9_sel,
        mux3_sel,
        o_end,
        o_max ,
        o_min,
        o_top,
        o_gr,
        o_cond,
        o_reg4,
        sum_2
    );

    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif rising_edge(i_clk) then
            cur_state <= next_state;
        end if;
    end process;

    process(cur_state, i_start, o_end, o_max, o_min, o_gr, o_cond, o_top)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 =>
                if i_start = '1' then
                    next_state <= S1;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                next_state <= S4;
            when S4 =>
                  next_state <= S5;
             when S5 =>
                if o_end = '0' then
                    next_state <= S6;
                else
                    next_state <= S19; -- per gestire numero di righe/colonne =0
                end if; 
            when S6 =>
                if o_end = '1' then
                    next_state <= S10;             
                elsif o_max = '1' then
                    next_state <= S9;
                elsif o_min = '1' then
                    next_state <= S8;
                else 
                    next_state <= S7;
                end if;
            when S7 =>
                next_state <= S6;
            when S8 =>
                next_state <= S6;
            when S9 =>
                next_state <= S6;
            when S10 =>
                next_state <= S11;
            when S11 => 
                if o_top = '1' then
                    next_state <= S15;
                else
                    next_state <= S12;
                end if;
            when S12 =>
                if o_gr = '0' then
                    next_state <= S13;
                else
                    next_state <= S14;
                end if;
            when S13 =>
                    next_state <= S12;
            when S14 =>
                next_state <= S16;
            when S15 =>
                next_state <= S16;
            when S16 =>
                if o_end = '0' then
                    next_state <= S17;
                else
                    next_state <= S19;
                end if;
            when S17 =>
                next_state <= S18;
            when S18 =>
                next_state <= S16;
            when S19 =>
                if i_start = '1' then
                    next_state <= S19;
                else
                    next_state <= S0;
                end if;
                
        end case;
    end process;
    
    -- FUNZIONE DEI SINGOLI STATI + VALORI DI DEFAULT
    
    process(cur_state,o_reg4,sum_2,o_cond)
    begin
        r1_load <= '0';
        r2_load <= '0';
        r3_load <= '0';
        r4_load <= '0';
        r5_load <= '0';
        r6_load <= '0';
        r8_load <= '0';
        r9_load <= '0';
        r12_load <= '0';
        dem2_sel <= '0';
        dem3_sel <= '0';
        dem4_sel <= '0';
        muxr3_sel <= '0';
        muxr4_sel <= '0';
        muxr5_sel <= '0';
        mux1_sel <= '0';
        mux2_sel <= '0';
        muxr8_sel <= '0';
        muxr9_sel <= "00";
        mux3_sel <= '0';
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';
        o_address <= o_reg4;
        

        case cur_state is
            when S0 =>
            when S1 =>
                o_address <= "0000000000000000";
                o_en <= '1';
            when S2 =>
                o_address <= "0000000000000001";
                o_en <= '1';
                r1_load <= '1';
            when S3 =>
                muxr4_sel <= '0';
                r2_load <= '1';
                r4_load <= '1';
            when S4 =>
                o_en <= '1';
                muxr3_sel <= '0';
                r3_load <= '1';
            when S5 =>
                o_en <= '1';
                muxr5_sel <= '1';
                r5_load <= '1';
                r6_load <= '1';
            when S6 =>
                o_en <= '1';
                muxr3_sel <= '1';
                r3_load <= '1';
                muxr4_sel <= '1';
                r4_load <= '1';
            when S7 => 
                o_en <= '1';
            when S8 =>
                o_en <= '1';
                r6_load <= '1';                            
            when S9 =>
                o_en <= '1';
                muxr5_sel <= '1';
                r5_load <= '1';                
            when S10 =>
                muxr5_sel <= '0';
                r5_load <= '1'; 
                muxr3_sel <= '0';
                r3_load <= '1';
                muxr4_sel <= '0';
                r4_load <= '1';
                dem2_sel <= '1';
                mux1_sel <= '0';
                dem3_sel <= '1';
                mux2_sel <= '0';
                dem4_sel <= '0';
                muxr8_sel <= '0';
                r8_load <= '1';
                muxr9_sel <= "00";
                r9_load <= '1';
            when S11 =>
            when S12 =>
            when S13 =>
                muxr8_sel <= '1';
                r8_load <= '1';
                muxr9_sel <= "01";
                r9_load <= '1';
                mux2_sel <= '1';
                dem4_sel <= '1';
            when S14 =>
                muxr9_sel <= "11";
                r9_load <= '1';
                o_en <= '1';
            when S15 =>
                o_en <= '1';
            when S16 =>
                r12_load <= '1';
                mux1_sel <= '1';
                dem3_sel <= '0';
            when S17 =>
                o_address <= sum_2;
                o_en <= '1';
                o_we <= '1';
                mux3_sel <= o_cond;
                muxr3_sel <= '1';
                r3_load <= '1';
                muxr4_sel <= '1';
                r4_load <= '1';
           when S18 =>
                o_en <= '1';
            when S19 =>
                o_done <= '1';
        end case;
    end process;

end Behavioral;