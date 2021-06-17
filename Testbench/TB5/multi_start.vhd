library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity project_tb is
end project_tb;


architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 5 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;


type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal i: integer := 0;

signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned(7, 8)), 
1 => std_logic_vector(to_unsigned(5, 8)), 
2 => std_logic_vector(to_unsigned(13, 8)), 
3 => std_logic_vector(to_unsigned(25, 8)), 
4 => std_logic_vector(to_unsigned(19, 8)), 
5 => std_logic_vector(to_unsigned(8, 8)), 
6 => std_logic_vector(to_unsigned(79, 8)), 
7 => std_logic_vector(to_unsigned(95, 8)), 
8 => std_logic_vector(to_unsigned(65, 8)), 
9 => std_logic_vector(to_unsigned(159, 8)), 
10 => std_logic_vector(to_unsigned(30, 8)), 
11 => std_logic_vector(to_unsigned(96, 8)), 
12 => std_logic_vector(to_unsigned(64, 8)), 
13 => std_logic_vector(to_unsigned(52, 8)), 
14 => std_logic_vector(to_unsigned(141, 8)), 
15 => std_logic_vector(to_unsigned(154, 8)), 
16 => std_logic_vector(to_unsigned(242, 8)), 
17 => std_logic_vector(to_unsigned(101, 8)), 
18 => std_logic_vector(to_unsigned(66, 8)), 
19 => std_logic_vector(to_unsigned(54, 8)), 
20 => std_logic_vector(to_unsigned(75, 8)), 
21 => std_logic_vector(to_unsigned(6, 8)), 
22 => std_logic_vector(to_unsigned(202, 8)), 
23 => std_logic_vector(to_unsigned(147, 8)), 
24 => std_logic_vector(to_unsigned(166, 8)), 
25 => std_logic_vector(to_unsigned(111, 8)), 
26 => std_logic_vector(to_unsigned(240, 8)), 
27 => std_logic_vector(to_unsigned(60, 8)), 
28 => std_logic_vector(to_unsigned(235, 8)), 
29 => std_logic_vector(to_unsigned(35, 8)), 
30 => std_logic_vector(to_unsigned(169, 8)), 
31 => std_logic_vector(to_unsigned(47, 8)), 
32 => std_logic_vector(to_unsigned(113, 8)), 
33 => std_logic_vector(to_unsigned(182, 8)), 
34 => std_logic_vector(to_unsigned(73, 8)), 
35 => std_logic_vector(to_unsigned(132, 8)), 
36 => std_logic_vector(to_unsigned(190, 8)), 
others => (others =>'0'));


signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned(9, 8)), 
1 => std_logic_vector(to_unsigned(4, 8)), 
2 => std_logic_vector(to_unsigned(0, 8)), 
3 => std_logic_vector(to_unsigned(55, 8)), 
4 => std_logic_vector(to_unsigned(2, 8)), 
5 => std_logic_vector(to_unsigned(96, 8)), 
6 => std_logic_vector(to_unsigned(119, 8)), 
7 => std_logic_vector(to_unsigned(54, 8)), 
8 => std_logic_vector(to_unsigned(237, 8)), 
9 => std_logic_vector(to_unsigned(17, 8)), 
10 => std_logic_vector(to_unsigned(41, 8)), 
11 => std_logic_vector(to_unsigned(83, 8)), 
12 => std_logic_vector(to_unsigned(84, 8)), 
13 => std_logic_vector(to_unsigned(95, 8)), 
14 => std_logic_vector(to_unsigned(158, 8)), 
15 => std_logic_vector(to_unsigned(90, 8)), 
16 => std_logic_vector(to_unsigned(41, 8)), 
17 => std_logic_vector(to_unsigned(49, 8)), 
18 => std_logic_vector(to_unsigned(0, 8)), 
19 => std_logic_vector(to_unsigned(152, 8)), 
20 => std_logic_vector(to_unsigned(33, 8)), 
21 => std_logic_vector(to_unsigned(60, 8)), 
22 => std_logic_vector(to_unsigned(131, 8)), 
23 => std_logic_vector(to_unsigned(68, 8)), 
24 => std_logic_vector(to_unsigned(229, 8)), 
25 => std_logic_vector(to_unsigned(178, 8)), 
26 => std_logic_vector(to_unsigned(181, 8)), 
27 => std_logic_vector(to_unsigned(155, 8)), 
28 => std_logic_vector(to_unsigned(251, 8)), 
29 => std_logic_vector(to_unsigned(57, 8)), 
30 => std_logic_vector(to_unsigned(90, 8)), 
31 => std_logic_vector(to_unsigned(147, 8)), 
32 => std_logic_vector(to_unsigned(29, 8)), 
33 => std_logic_vector(to_unsigned(90, 8)), 
34 => std_logic_vector(to_unsigned(203, 8)), 
35 => std_logic_vector(to_unsigned(31, 8)), 
36 => std_logic_vector(to_unsigned(186, 8)), 
37 => std_logic_vector(to_unsigned(66, 8)), 
others => (others =>'0'));


signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned(2, 8)), 
1 => std_logic_vector(to_unsigned(6, 8)), 
2 => std_logic_vector(to_unsigned(84, 8)), 
3 => std_logic_vector(to_unsigned(126, 8)), 
4 => std_logic_vector(to_unsigned(250, 8)), 
5 => std_logic_vector(to_unsigned(168, 8)), 
6 => std_logic_vector(to_unsigned(221, 8)), 
7 => std_logic_vector(to_unsigned(152, 8)), 
8 => std_logic_vector(to_unsigned(2, 8)), 
9 => std_logic_vector(to_unsigned(6, 8)), 
10 => std_logic_vector(to_unsigned(201, 8)), 
11 => std_logic_vector(to_unsigned(3, 8)), 
12 => std_logic_vector(to_unsigned(158, 8)), 
13 => std_logic_vector(to_unsigned(234, 8)), 
others => (others =>'0'));


component project_reti_logiche is
port (
i_clk         : in  std_logic;
i_rst         : in  std_logic;
i_start       : in  std_logic;
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
i_rst      	=> tb_rst,
i_start       => tb_start,
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
if i = 0 then
if mem_we = '1' then
RAM0(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM0(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 1 then
if mem_we = '1' then
RAM1(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 2 then
if mem_we = '1' then
RAM2(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
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
i <= i + 1;

wait for 100 ns;
tb_start <= '1';
wait for c_CLOCK_PERIOD;
wait until tb_done = '1';
wait for c_CLOCK_PERIOD;
tb_start <= '0';
wait until tb_done = '0';
wait for 100 ns;
i <= i + 1;

wait for 100 ns;
tb_start <= '1';
wait for c_CLOCK_PERIOD;
wait until tb_done = '1';
wait for c_CLOCK_PERIOD;
tb_start <= '0';
wait until tb_done = '0';
wait for 100 ns;


assert RAM0(37) = std_logic_vector(to_unsigned(14,8)) report  " TEST FALLITO (WORKING ZONE). Expected  14  found  " & integer'image(to_integer(unsigned(RAM0(37))))  severity failure; 
assert RAM0(38) = std_logic_vector(to_unsigned(38,8)) report  " TEST FALLITO (WORKING ZONE). Expected  38  found  " & integer'image(to_integer(unsigned(RAM0(38))))  severity failure; 
assert RAM0(39) = std_logic_vector(to_unsigned(26,8)) report  " TEST FALLITO (WORKING ZONE). Expected  26  found  " & integer'image(to_integer(unsigned(RAM0(39))))  severity failure; 
assert RAM0(40) = std_logic_vector(to_unsigned(4,8)) report  " TEST FALLITO (WORKING ZONE). Expected  4  found  " & integer'image(to_integer(unsigned(RAM0(40))))  severity failure; 
assert RAM0(41) = std_logic_vector(to_unsigned(146,8)) report  " TEST FALLITO (WORKING ZONE). Expected  146  found  " & integer'image(to_integer(unsigned(RAM0(41))))  severity failure; 
assert RAM0(42) = std_logic_vector(to_unsigned(178,8)) report  " TEST FALLITO (WORKING ZONE). Expected  178  found  " & integer'image(to_integer(unsigned(RAM0(42))))  severity failure; 
assert RAM0(43) = std_logic_vector(to_unsigned(118,8)) report  " TEST FALLITO (WORKING ZONE). Expected  118  found  " & integer'image(to_integer(unsigned(RAM0(43))))  severity failure; 
assert RAM0(44) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(44))))  severity failure; 
assert RAM0(45) = std_logic_vector(to_unsigned(48,8)) report  " TEST FALLITO (WORKING ZONE). Expected  48  found  " & integer'image(to_integer(unsigned(RAM0(45))))  severity failure; 
assert RAM0(46) = std_logic_vector(to_unsigned(180,8)) report  " TEST FALLITO (WORKING ZONE). Expected  180  found  " & integer'image(to_integer(unsigned(RAM0(46))))  severity failure; 
assert RAM0(47) = std_logic_vector(to_unsigned(116,8)) report  " TEST FALLITO (WORKING ZONE). Expected  116  found  " & integer'image(to_integer(unsigned(RAM0(47))))  severity failure; 
assert RAM0(48) = std_logic_vector(to_unsigned(92,8)) report  " TEST FALLITO (WORKING ZONE). Expected  92  found  " & integer'image(to_integer(unsigned(RAM0(48))))  severity failure; 
assert RAM0(49) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(49))))  severity failure; 
assert RAM0(50) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(50))))  severity failure; 
assert RAM0(51) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(51))))  severity failure; 
assert RAM0(52) = std_logic_vector(to_unsigned(190,8)) report  " TEST FALLITO (WORKING ZONE). Expected  190  found  " & integer'image(to_integer(unsigned(RAM0(52))))  severity failure; 
assert RAM0(53) = std_logic_vector(to_unsigned(120,8)) report  " TEST FALLITO (WORKING ZONE). Expected  120  found  " & integer'image(to_integer(unsigned(RAM0(53))))  severity failure; 
assert RAM0(54) = std_logic_vector(to_unsigned(96,8)) report  " TEST FALLITO (WORKING ZONE). Expected  96  found  " & integer'image(to_integer(unsigned(RAM0(54))))  severity failure; 
assert RAM0(55) = std_logic_vector(to_unsigned(138,8)) report  " TEST FALLITO (WORKING ZONE). Expected  138  found  " & integer'image(to_integer(unsigned(RAM0(55))))  severity failure; 
assert RAM0(56) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM0(56))))  severity failure; 
assert RAM0(57) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(57))))  severity failure; 
assert RAM0(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(58))))  severity failure; 
assert RAM0(59) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(59))))  severity failure; 
assert RAM0(60) = std_logic_vector(to_unsigned(210,8)) report  " TEST FALLITO (WORKING ZONE). Expected  210  found  " & integer'image(to_integer(unsigned(RAM0(60))))  severity failure; 
assert RAM0(61) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(61))))  severity failure; 
assert RAM0(62) = std_logic_vector(to_unsigned(108,8)) report  " TEST FALLITO (WORKING ZONE). Expected  108  found  " & integer'image(to_integer(unsigned(RAM0(62))))  severity failure; 
assert RAM0(63) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(63))))  severity failure; 
assert RAM0(64) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM0(64))))  severity failure; 
assert RAM0(65) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(65))))  severity failure; 
assert RAM0(66) = std_logic_vector(to_unsigned(82,8)) report  " TEST FALLITO (WORKING ZONE). Expected  82  found  " & integer'image(to_integer(unsigned(RAM0(66))))  severity failure; 
assert RAM0(67) = std_logic_vector(to_unsigned(214,8)) report  " TEST FALLITO (WORKING ZONE). Expected  214  found  " & integer'image(to_integer(unsigned(RAM0(67))))  severity failure; 
assert RAM0(68) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(68))))  severity failure; 
assert RAM0(69) = std_logic_vector(to_unsigned(134,8)) report  " TEST FALLITO (WORKING ZONE). Expected  134  found  " & integer'image(to_integer(unsigned(RAM0(69))))  severity failure; 
assert RAM0(70) = std_logic_vector(to_unsigned(252,8)) report  " TEST FALLITO (WORKING ZONE). Expected  252  found  " & integer'image(to_integer(unsigned(RAM0(70))))  severity failure; 
assert RAM0(71) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(71))))  severity failure; 


assert RAM1(38) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM1(38))))  severity failure; 
assert RAM1(39) = std_logic_vector(to_unsigned(110,8)) report  " TEST FALLITO (WORKING ZONE). Expected  110  found  " & integer'image(to_integer(unsigned(RAM1(39))))  severity failure; 
assert RAM1(40) = std_logic_vector(to_unsigned(4,8)) report  " TEST FALLITO (WORKING ZONE). Expected  4  found  " & integer'image(to_integer(unsigned(RAM1(40))))  severity failure; 
assert RAM1(41) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM1(41))))  severity failure; 
assert RAM1(42) = std_logic_vector(to_unsigned(238,8)) report  " TEST FALLITO (WORKING ZONE). Expected  238  found  " & integer'image(to_integer(unsigned(RAM1(42))))  severity failure; 
assert RAM1(43) = std_logic_vector(to_unsigned(108,8)) report  " TEST FALLITO (WORKING ZONE). Expected  108  found  " & integer'image(to_integer(unsigned(RAM1(43))))  severity failure; 
assert RAM1(44) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(44))))  severity failure; 
assert RAM1(45) = std_logic_vector(to_unsigned(34,8)) report  " TEST FALLITO (WORKING ZONE). Expected  34  found  " & integer'image(to_integer(unsigned(RAM1(45))))  severity failure; 
assert RAM1(46) = std_logic_vector(to_unsigned(82,8)) report  " TEST FALLITO (WORKING ZONE). Expected  82  found  " & integer'image(to_integer(unsigned(RAM1(46))))  severity failure; 
assert RAM1(47) = std_logic_vector(to_unsigned(166,8)) report  " TEST FALLITO (WORKING ZONE). Expected  166  found  " & integer'image(to_integer(unsigned(RAM1(47))))  severity failure; 
assert RAM1(48) = std_logic_vector(to_unsigned(168,8)) report  " TEST FALLITO (WORKING ZONE). Expected  168  found  " & integer'image(to_integer(unsigned(RAM1(48))))  severity failure; 
assert RAM1(49) = std_logic_vector(to_unsigned(190,8)) report  " TEST FALLITO (WORKING ZONE). Expected  190  found  " & integer'image(to_integer(unsigned(RAM1(49))))  severity failure; 
assert RAM1(50) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(50))))  severity failure; 
assert RAM1(51) = std_logic_vector(to_unsigned(180,8)) report  " TEST FALLITO (WORKING ZONE). Expected  180  found  " & integer'image(to_integer(unsigned(RAM1(51))))  severity failure; 
assert RAM1(52) = std_logic_vector(to_unsigned(82,8)) report  " TEST FALLITO (WORKING ZONE). Expected  82  found  " & integer'image(to_integer(unsigned(RAM1(52))))  severity failure; 
assert RAM1(53) = std_logic_vector(to_unsigned(98,8)) report  " TEST FALLITO (WORKING ZONE). Expected  98  found  " & integer'image(to_integer(unsigned(RAM1(53))))  severity failure; 
assert RAM1(54) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM1(54))))  severity failure; 
assert RAM1(55) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(55))))  severity failure; 
assert RAM1(56) = std_logic_vector(to_unsigned(66,8)) report  " TEST FALLITO (WORKING ZONE). Expected  66  found  " & integer'image(to_integer(unsigned(RAM1(56))))  severity failure; 
assert RAM1(57) = std_logic_vector(to_unsigned(120,8)) report  " TEST FALLITO (WORKING ZONE). Expected  120  found  " & integer'image(to_integer(unsigned(RAM1(57))))  severity failure; 
assert RAM1(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(58))))  severity failure; 
assert RAM1(59) = std_logic_vector(to_unsigned(136,8)) report  " TEST FALLITO (WORKING ZONE). Expected  136  found  " & integer'image(to_integer(unsigned(RAM1(59))))  severity failure; 
assert RAM1(60) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(60))))  severity failure; 
assert RAM1(61) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(61))))  severity failure; 
assert RAM1(62) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(62))))  severity failure; 
assert RAM1(63) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(63))))  severity failure; 
assert RAM1(64) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(64))))  severity failure; 
assert RAM1(65) = std_logic_vector(to_unsigned(114,8)) report  " TEST FALLITO (WORKING ZONE). Expected  114  found  " & integer'image(to_integer(unsigned(RAM1(65))))  severity failure; 
assert RAM1(66) = std_logic_vector(to_unsigned(180,8)) report  " TEST FALLITO (WORKING ZONE). Expected  180  found  " & integer'image(to_integer(unsigned(RAM1(66))))  severity failure; 
assert RAM1(67) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(67))))  severity failure; 
assert RAM1(68) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM1(68))))  severity failure; 
assert RAM1(69) = std_logic_vector(to_unsigned(180,8)) report  " TEST FALLITO (WORKING ZONE). Expected  180  found  " & integer'image(to_integer(unsigned(RAM1(69))))  severity failure; 
assert RAM1(70) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(70))))  severity failure; 
assert RAM1(71) = std_logic_vector(to_unsigned(62,8)) report  " TEST FALLITO (WORKING ZONE). Expected  62  found  " & integer'image(to_integer(unsigned(RAM1(71))))  severity failure; 
assert RAM1(72) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(72))))  severity failure; 
assert RAM1(73) = std_logic_vector(to_unsigned(132,8)) report  " TEST FALLITO (WORKING ZONE). Expected  132  found  " & integer'image(to_integer(unsigned(RAM1(73))))  severity failure; 


assert RAM2(14) = std_logic_vector(to_unsigned(164,8)) report  " TEST FALLITO (WORKING ZONE). Expected  164  found  " & integer'image(to_integer(unsigned(RAM2(14))))  severity failure; 
assert RAM2(15) = std_logic_vector(to_unsigned(248,8)) report  " TEST FALLITO (WORKING ZONE). Expected  248  found  " & integer'image(to_integer(unsigned(RAM2(15))))  severity failure; 
assert RAM2(16) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(16))))  severity failure; 
assert RAM2(17) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(17))))  severity failure; 
assert RAM2(18) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(18))))  severity failure; 
assert RAM2(19) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(19))))  severity failure; 
assert RAM2(20) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM2(20))))  severity failure; 
assert RAM2(21) = std_logic_vector(to_unsigned(8,8)) report  " TEST FALLITO (WORKING ZONE). Expected  8  found  " & integer'image(to_integer(unsigned(RAM2(21))))  severity failure; 
assert RAM2(22) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(22))))  severity failure; 
assert RAM2(23) = std_logic_vector(to_unsigned(2,8)) report  " TEST FALLITO (WORKING ZONE). Expected  2  found  " & integer'image(to_integer(unsigned(RAM2(23))))  severity failure; 
assert RAM2(24) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(24))))  severity failure; 
assert RAM2(25) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(25))))  severity failure; 



assert false report " Simulation Ended! TEST PASSATO " severity failure;

end process test;
end projecttb;