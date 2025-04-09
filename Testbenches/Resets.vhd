
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 15 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal i: std_logic_vector(3 downto 0) := "0000";


signal RAM: ram_type := (0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
             2 => std_logic_vector(to_unsigned(  69  , 8)),
             3 => std_logic_vector(to_unsigned(  69  , 8)),
             4 => std_logic_vector(to_unsigned(  69  , 8)),
             5 => std_logic_vector(to_unsigned(  69  , 8)),
                         others => (others =>'0'));         
			 -- delta=0 shift=8*              *non è uno shift di 8, ma moltiplico per 11111111    

signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  90  , 8)),
			 3 => std_logic_vector(to_unsigned(  91  , 8)),
			 4 => std_logic_vector(to_unsigned(  90  , 8)),
			 5 => std_logic_vector(to_unsigned(  91  , 8)),
			 6 => std_logic_vector(to_unsigned(  90  , 8)),
			 7 => std_logic_vector(to_unsigned(  91  , 8)),
                         others => (others =>'0'));
             -- delta=1 shift=7

signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned(  3  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
			 2 => std_logic_vector(to_unsigned(  50  , 8)),
			 3 => std_logic_vector(to_unsigned(  51  , 8)),
			 4 => std_logic_vector(to_unsigned(  52  , 8)),
			 5 => std_logic_vector(to_unsigned(  51  , 8)),
             6 => std_logic_vector(to_unsigned(  53  , 8)),
			 7 => std_logic_vector(to_unsigned(  49  , 8)),
                         others => (others =>'0'));              
             -- delta=4 shift=6

signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned(  1  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  42  , 8)),
			 3 => std_logic_vector(to_unsigned(  36  , 8)),
			 4 => std_logic_vector(to_unsigned(  30  , 8)),
                         others => (others =>'0'));   
             -- delta=12 shift=5            
                         
                         
signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned(  3  , 8)),
			 1 => std_logic_vector(to_unsigned(  4  , 8)),
			 2 => std_logic_vector(to_unsigned(  183  , 8)),
			 3 => std_logic_vector(to_unsigned(  181  , 8)),
			 4 => std_logic_vector(to_unsigned(  160  , 8)),
			 5 => std_logic_vector(to_unsigned(  174  , 8)),
			 6 => std_logic_vector(to_unsigned(  184  , 8)),
			 7 => std_logic_vector(to_unsigned(  176  , 8)),
			 8 => std_logic_vector(to_unsigned(  179  , 8)),
			 9 => std_logic_vector(to_unsigned(  164  , 8)),
			 10 => std_logic_vector(to_unsigned(  161  , 8)),
			 11 => std_logic_vector(to_unsigned(  169  , 8)),
			 12 => std_logic_vector(to_unsigned(  159  , 8)),
			 13 => std_logic_vector(to_unsigned(  163  , 8)),		 			 			 
                         others => (others =>'0'));
             -- delta=25 shift=4
             
                                                               
signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned(  1  , 8)),
			 1 => std_logic_vector(to_unsigned(  5  , 8)),
			 2 => std_logic_vector(to_unsigned(  95  , 8)),
			 3 => std_logic_vector(to_unsigned(  107  , 8)),
			 4 => std_logic_vector(to_unsigned(  121  , 8)),
			 5 => std_logic_vector(to_unsigned(  91  , 8)),
			 6 => std_logic_vector(to_unsigned(  141  , 8)),			 			 
                         others => (others =>'0'));  
             -- delta=50 shift=3             

signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned(  4  , 8)),
			 1 => std_logic_vector(to_unsigned(  1  , 8)),
			 2 => std_logic_vector(to_unsigned(  0  , 8)),
			 3 => std_logic_vector(to_unsigned(  90  , 8)),
			 4 => std_logic_vector(to_unsigned(  30  , 8)),
			 5 => std_logic_vector(to_unsigned(  60  , 8)),
                         others => (others =>'0'));
             -- delta=90 shift=2
                         
signal RAM7: ram_type := (
             0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
			 2 => std_logic_vector(to_unsigned(  200  , 8)),
			 3 => std_logic_vector(to_unsigned(  96  , 8)),
			 4 => std_logic_vector(to_unsigned(  123  , 8)),
			 5 => std_logic_vector(to_unsigned(  43  , 8)),
                         others => (others =>'0'));
             -- delta=157 shift=1
             
signal RAM8: ram_type := (
             0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
			 2 => std_logic_vector(to_unsigned(  64  , 8)),
			 3 => std_logic_vector(to_unsigned(  128  , 8)),
			 4 => std_logic_vector(to_unsigned(  255  , 8)),
			 5 => std_logic_vector(to_unsigned(  0  , 8)),
                         others => (others =>'0'));
             -- delta=255 shift=0

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
if tb_clk'event and tb_clk = '1' then
    if enable_wire = '1' then
        if i = "0000" then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i ="0001" then
            if mem_we = '1' then
                RAM1(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0010" then 
            if mem_we = '1' then
                RAM2(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0011" then 
            if mem_we = '1' then
                RAM3(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0100" then 
            if mem_we = '1' then
                RAM4(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0101" then 
            if mem_we = '1' then
                RAM5(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0110" then 
            if mem_we = '1' then
                RAM6(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "0111" then 
            if mem_we = '1' then
                RAM7(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "1000" then 
            if mem_we = '1' then
                RAM8(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM8(conv_integer(mem_address)) after 1 ns;
            end if;    
        end if;
    end if;
end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0001";

    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 515 ns;
    --test reset in mezzo al codice
    tb_rst <= '1';
    tb_start <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
--    wait for 100 ns;
--    tb_start <= '1';
--    wait for c_CLOCK_PERIOD;
--    wait until tb_done = '1';
--    wait for c_CLOCK_PERIOD;
--    tb_start <= '0';
--    wait until tb_done = '0';
--    wait for 100 ns;
    i <= "0010";

    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 340 ns;
    tb_rst <= '1';
    tb_start <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0011";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0100";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0101";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0110";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0111";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1000";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    
    
    --RAM
	assert RAM(6)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(6))))  severity failure;
    assert RAM(7)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(7))))  severity failure;
    assert RAM(8)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(8))))  severity failure;
    assert RAM(9)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(9))))  severity failure;

	--RAM1
	assert RAM1(8)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM1(8))))  severity failure;
    assert RAM1(9)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM1(9))))  severity failure;
    assert RAM1(10)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM1(10))))  severity failure;
    assert RAM1(11)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM1(11))))  severity failure;
    assert RAM1(12)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM1(12))))  severity failure;
    assert RAM1(13)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM1(13))))  severity failure;

	--RAM2
	assert RAM2(8)= std_logic_vector(to_unsigned( 64 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure;
    assert RAM2(9)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
    assert RAM2(10)= std_logic_vector(to_unsigned( 192 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM2(10))))  severity failure;
    assert RAM2(11)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM2(11))))  severity failure;
    assert RAM2(12)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM2(12))))  severity failure;
    assert RAM2(13)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM2(13))))  severity failure;

	--RAM3
    assert RAM3(5)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM3(5))))  severity failure;
    assert RAM3(6)= std_logic_vector(to_unsigned( 192 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM3(6))))  severity failure;
    assert RAM3(7)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM3(7))))  severity failure;

    --RAM4
    assert RAM4(14)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(14))))  severity failure;
    assert RAM4(15)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(15))))  severity failure;
    assert RAM4(16)= std_logic_vector(to_unsigned( 16 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 16 found " & integer'image(to_integer(unsigned(RAM4(16))))  severity failure;
    assert RAM4(17)= std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM4(17))))  severity failure;
    assert RAM4(18)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(18))))  severity failure;
    assert RAM4(19)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(19))))  severity failure;
    assert RAM4(20)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(20))))  severity failure;
    assert RAM4(21)= std_logic_vector(to_unsigned( 80 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 80 found " & integer'image(to_integer(unsigned(RAM4(21))))  severity failure;
    assert RAM4(22)= std_logic_vector(to_unsigned( 32 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM4(22))))  severity failure;
    assert RAM4(23)= std_logic_vector(to_unsigned( 160 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 160 found " & integer'image(to_integer(unsigned(RAM4(23))))  severity failure;
    assert RAM4(24)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM4(24))))  severity failure;
    assert RAM4(25)= std_logic_vector(to_unsigned( 64 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM4(25))))  severity failure;
    
    --RAM5
    assert RAM5(7)= std_logic_vector(to_unsigned( 32 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM5(7))))  severity failure;
    assert RAM5(8)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM5(8))))  severity failure;
    assert RAM5(9)= std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM5(9))))  severity failure;
    assert RAM5(10)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM5(10))))  severity failure;
    assert RAM5(11)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM5(11))))  severity failure;

    --RAM6
    assert RAM6(6)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM6(6))))  severity failure;
    assert RAM6(7)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM6(7))))  severity failure;
    assert RAM6(8)= std_logic_vector(to_unsigned( 120 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 120 found " & integer'image(to_integer(unsigned(RAM6(8))))  severity failure;
    assert RAM6(9)= std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM6(9))))  severity failure;
    
    --RAM7
    assert RAM7(6)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM7(6))))  severity failure;
    assert RAM7(7)= std_logic_vector(to_unsigned( 106 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 106 found " & integer'image(to_integer(unsigned(RAM7(7))))  severity failure;
    assert RAM7(8)= std_logic_vector(to_unsigned( 160 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 160 found " & integer'image(to_integer(unsigned(RAM7(8))))  severity failure;
    assert RAM7(9)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM7(9))))  severity failure;

    --RAM8
    assert RAM8(6)= std_logic_vector(to_unsigned( 64 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM8(6))))  severity failure;
    assert RAM8(7)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM8(7))))  severity failure;
    assert RAM8(8)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM8(8))))  severity failure;
    assert RAM8(9)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM8(9))))  severity failure;
    
	
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb;