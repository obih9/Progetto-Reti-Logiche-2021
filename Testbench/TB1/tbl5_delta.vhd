
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


signal RAM: ram_type := (
			 0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  255  , 8)),
			 3 => std_logic_vector(to_unsigned(  254  , 8)),
			 4 => std_logic_vector(to_unsigned(  255  , 8)),
			 5 => std_logic_vector(to_unsigned(  255  , 8)),
			 6 => std_logic_vector(to_unsigned(  255  , 8)),
			 7 => std_logic_vector(to_unsigned(  255  , 8)),
                         others => (others =>'0'));         
			 -- delta=240 shift=1    

signal RAM1: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  255  , 8)),
			 3 => std_logic_vector(to_unsigned(  254  , 8)),
			 4 => std_logic_vector(to_unsigned(  255  , 8)),
			 5 => std_logic_vector(to_unsigned(  255  , 8)),
			 6 => std_logic_vector(to_unsigned(  255  , 8)),
			 7 => std_logic_vector(to_unsigned(  253  , 8)),
                         others => (others =>'0'));      

signal RAM2: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  255  , 8)),
			 3 => std_logic_vector(to_unsigned(  254  , 8)),
			 4 => std_logic_vector(to_unsigned(  255  , 8)),
			 5 => std_logic_vector(to_unsigned(  255  , 8)),
			 6 => std_logic_vector(to_unsigned(  255  , 8)),
			 7 => std_logic_vector(to_unsigned(  252  , 8)),
                         others => (others =>'0'));  

signal RAM3: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  127  , 8)),
			 3 => std_logic_vector(to_unsigned(  122  , 8)),
			 4 => std_logic_vector(to_unsigned(  124  , 8)),
			 5 => std_logic_vector(to_unsigned(  128  , 8)),
			 6 => std_logic_vector(to_unsigned(  125  , 8)),
			 7 => std_logic_vector(to_unsigned(  122  , 8)),
                         others => (others =>'0'));
						 
signal RAM4: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  100  , 8)),
			 3 => std_logic_vector(to_unsigned(  99  , 8)),
			 4 => std_logic_vector(to_unsigned(  100  , 8)),
			 5 => std_logic_vector(to_unsigned(  106  , 8)),
			 6 => std_logic_vector(to_unsigned(  105  , 8)),
			 7 => std_logic_vector(to_unsigned(  99  , 8)),
                         others => (others =>'0')); 							

signal RAM5: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  110  , 8)),
			 3 => std_logic_vector(to_unsigned(  115  , 8)),
			 4 => std_logic_vector(to_unsigned(  124  , 8)),
			 5 => std_logic_vector(to_unsigned(  110  , 8)),
			 6 => std_logic_vector(to_unsigned(  111  , 8)),
			 7 => std_logic_vector(to_unsigned(  120  , 8)),
                         others => (others =>'0')); 							

signal RAM6: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  110  , 8)),
			 3 => std_logic_vector(to_unsigned(  115  , 8)),
			 4 => std_logic_vector(to_unsigned(  125  , 8)),
			 5 => std_logic_vector(to_unsigned(  110  , 8)),
			 6 => std_logic_vector(to_unsigned(  111  , 8)),
			 7 => std_logic_vector(to_unsigned(  120  , 8)),
                         others => (others =>'0')); 							 

signal RAM7: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  200  , 8)),
			 3 => std_logic_vector(to_unsigned(  199  , 8)),
			 4 => std_logic_vector(to_unsigned(  170  , 8)),
			 5 => std_logic_vector(to_unsigned(  177  , 8)),
			 6 => std_logic_vector(to_unsigned(  180  , 8)),
			 7 => std_logic_vector(to_unsigned(  171  , 8)),
                         others => (others =>'0')); 	

signal RAM8: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  201  , 8)),
			 3 => std_logic_vector(to_unsigned(  199  , 8)),
			 4 => std_logic_vector(to_unsigned(  170  , 8)),
			 5 => std_logic_vector(to_unsigned(  177  , 8)),
			 6 => std_logic_vector(to_unsigned(  180  , 8)),
			 7 => std_logic_vector(to_unsigned(  171  , 8)),
                         others => (others =>'0')); 	

signal RAM9: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  220  , 8)),
			 3 => std_logic_vector(to_unsigned(  170  , 8)),
			 4 => std_logic_vector(to_unsigned(  200  , 8)),
			 5 => std_logic_vector(to_unsigned(  190  , 8)),
			 6 => std_logic_vector(to_unsigned(  187  , 8)),
			 7 => std_logic_vector(to_unsigned(  158  , 8)),
                         others => (others =>'0')); 	

signal RAM10: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  221  , 8)),
			 3 => std_logic_vector(to_unsigned(  170  , 8)),
			 4 => std_logic_vector(to_unsigned(  200  , 8)),
			 5 => std_logic_vector(to_unsigned(  190  , 8)),
			 6 => std_logic_vector(to_unsigned(  187  , 8)),
			 7 => std_logic_vector(to_unsigned(  158  , 8)),
                         others => (others =>'0')); 
						 
signal RAM11: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  230  , 8)),
			 3 => std_logic_vector(to_unsigned(  104  , 8)),
			 4 => std_logic_vector(to_unsigned(  150  , 8)),
			 5 => std_logic_vector(to_unsigned(  200  , 8)),
			 6 => std_logic_vector(to_unsigned(  170  , 8)),
			 7 => std_logic_vector(to_unsigned(  130  , 8)),
                         others => (others =>'0')); 
						 						 
signal RAM12: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  231  , 8)),
			 3 => std_logic_vector(to_unsigned(  104  , 8)),
			 4 => std_logic_vector(to_unsigned(  150  , 8)),
			 5 => std_logic_vector(to_unsigned(  200  , 8)),
			 6 => std_logic_vector(to_unsigned(  170  , 8)),
			 7 => std_logic_vector(to_unsigned(  130  , 8)),
                         others => (others =>'0')); 
						 						 						 
signal RAM13: ram_type := (
			  0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  3  , 8)),
			 2 => std_logic_vector(to_unsigned(  255  , 8)),
			 3 => std_logic_vector(to_unsigned(  140  , 8)),
			 4 => std_logic_vector(to_unsigned(  7  , 8)),
			 5 => std_logic_vector(to_unsigned(  1  , 8)),
			 6 => std_logic_vector(to_unsigned(  200  , 8)),
			 7 => std_logic_vector(to_unsigned(  66  , 8)),
                         others => (others =>'0'));
						 
signal RAM14: ram_type := (
               0 => std_logic_vector(to_unsigned(  2  , 8)),
              1 => std_logic_vector(to_unsigned(  3  , 8)),
              2 => std_logic_vector(to_unsigned(  255  , 8)),
              3 => std_logic_vector(to_unsigned(  140  , 8)),
              4 => std_logic_vector(to_unsigned(  7  , 8)),
              5 => std_logic_vector(to_unsigned(  0  , 8)),
              6 => std_logic_vector(to_unsigned(  200  , 8)),
              7 => std_logic_vector(to_unsigned(  66  , 8)),
                          others => (others =>'0'));
                                                  
signal RAM15: ram_type := (
                0 => std_logic_vector(to_unsigned(  2  , 8)),
               1 => std_logic_vector(to_unsigned(  3  , 8)),
               2 => std_logic_vector(to_unsigned(  255  , 8)),
               3 => std_logic_vector(to_unsigned(  255  , 8)),
               4 => std_logic_vector(to_unsigned(  255  , 8)),
               5 => std_logic_vector(to_unsigned(  255  , 8)),
               6 => std_logic_vector(to_unsigned(  255  , 8)),
               7 => std_logic_vector(to_unsigned(  255  , 8)),
                           others => (others =>'0'));

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
			elsif i ="0100" then
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
			elsif i ="0111" then
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
			elsif i = "1001" then
				if mem_we = '1' then
					RAM9(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM9(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i ="1010" then
				if mem_we = '1' then
					RAM10(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM10(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i = "1011" then 
				if mem_we = '1' then
					RAM11(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM11(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i = "1100" then 
				if mem_we = '1' then
					RAM12(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM12(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i = "1101" then
				if mem_we = '1' then
					RAM13(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM13(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i ="1110" then
				if mem_we = '1' then
					RAM14(conv_integer(mem_address))  <= mem_i_data;
					mem_o_data                      <= mem_i_data after 1 ns;
				else
					mem_o_data <= RAM14(conv_integer(mem_address)) after 1 ns;
				end if;
			elsif i ="1111" then
                if mem_we = '1' then
                    RAM15(conv_integer(mem_address))  <= mem_i_data;
                    mem_o_data                      <= mem_i_data after 1 ns;
                else
                    mem_o_data <= RAM15(conv_integer(mem_address)) after 1 ns;
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
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "0010";

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
    i <= "1001";
	
					wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1010";
	
					wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1011";
	
					wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1100";
	
						wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1101";
	
							wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1110";
    
    	wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "1111";
	
	
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    
	assert RAM(8) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(6))))  severity failure; 
	assert RAM(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(7))))  severity failure; 
	assert RAM(10) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(8))))  severity failure; 
	assert RAM(11) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(9))))  severity failure;
	assert RAM(12) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM(13) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM1(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(6))))  severity failure; 
	assert RAM1(9) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM1(7))))  severity failure; 
	assert RAM1(10) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(8))))  severity failure; 
	assert RAM1(11) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(9))))  severity failure;
	assert RAM1(12) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM1(10))))  severity failure; 
	assert RAM1(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(11))))  severity failure;

	assert RAM2(8) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM2(9) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM2(10) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM2(11) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM2(12) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(10))))  severity failure; 
	assert RAM2(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(11))))  severity failure;

	assert RAM3(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(6))))  severity failure; 
	assert RAM3(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(7))))  severity failure; 
	assert RAM3(10) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM3(8))))  severity failure; 
	assert RAM3(11) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM3(9))))  severity failure;
	assert RAM3(12) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM3(10))))  severity failure; 
	assert RAM3(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM3(11))))  severity failure;

	assert RAM4(8) = std_logic_vector(to_unsigned( 32 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM4(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM4(10) = std_logic_vector(to_unsigned( 32 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM4(11) = std_logic_vector(to_unsigned( 224 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  224  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM4(12) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM4(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM5(8) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM5(9) = std_logic_vector(to_unsigned( 160 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM5(10) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM5(11) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM5(12) = std_logic_vector(to_unsigned( 32 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  32  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM5(13) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM6(8) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM6(9) = std_logic_vector(to_unsigned( 80 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM6(10) = std_logic_vector(to_unsigned( 240 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  240  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM6(11) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM6(12) = std_logic_vector(to_unsigned( 16 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM6(13) = std_logic_vector(to_unsigned( 160 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM7(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM7(9) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM7(10) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM7(11) = std_logic_vector(to_unsigned( 112 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  112  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM7(12) = std_logic_vector(to_unsigned( 160 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  160  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM7(13) = std_logic_vector(to_unsigned( 16 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  16  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM8(8) = std_logic_vector(to_unsigned( 248 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  248  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM8(9) = std_logic_vector(to_unsigned( 232 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM8(10) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM8(11) = std_logic_vector(to_unsigned( 56 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  56  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM8(12) = std_logic_vector(to_unsigned( 80 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  80  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM8(13) = std_logic_vector(to_unsigned( 8 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  8  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM9(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM9(9) = std_logic_vector(to_unsigned( 96 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  96  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM9(10) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM9(11) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM9(12) = std_logic_vector(to_unsigned( 232 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  232  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM9(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM10(8) = std_logic_vector(to_unsigned( 252 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  252  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM10(9) = std_logic_vector(to_unsigned( 48 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  48  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM10(10) = std_logic_vector(to_unsigned( 168 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  168  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM10(11) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM10(12) = std_logic_vector(to_unsigned( 116 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  116  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM10(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM11(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM11(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM11(10) = std_logic_vector(to_unsigned( 184 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  184  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM11(11) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM11(12) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM11(13) = std_logic_vector(to_unsigned( 104 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  104  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM12(8) = std_logic_vector(to_unsigned( 254 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  254  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM12(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM12(10) = std_logic_vector(to_unsigned( 92 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  92  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM12(11) = std_logic_vector(to_unsigned( 192 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  192  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM12(12) = std_logic_vector(to_unsigned( 132 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  132  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM12(13) = std_logic_vector(to_unsigned( 52 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  52  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM13(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM13(9) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM13(10) = std_logic_vector(to_unsigned( 12 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  12  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM13(11) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM13(12) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM13(13) = std_logic_vector(to_unsigned( 130 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  130  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

	assert RAM14(8) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
	assert RAM14(9) = std_logic_vector(to_unsigned( 140 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  140  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
	assert RAM14(10) = std_logic_vector(to_unsigned( 7 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  7  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
	assert RAM14(11) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	assert RAM14(12) = std_logic_vector(to_unsigned( 200 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  200  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM14(13) = std_logic_vector(to_unsigned( 66 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  66  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;

assert RAM15(8) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(6))))  severity failure; 
	assert RAM15(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(7))))  severity failure; 
	assert RAM15(10) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(8))))  severity failure; 
	assert RAM15(11) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(9))))  severity failure;
	assert RAM15(12) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(10))))  severity failure; 
	assert RAM15(13) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(11))))  severity failure;




    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 


