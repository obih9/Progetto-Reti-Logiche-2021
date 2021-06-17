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

signal i: integer := 0;

signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned(6, 8)), 
1 => std_logic_vector(to_unsigned(10, 8)), 
2 => std_logic_vector(to_unsigned(33, 8)), 
3 => std_logic_vector(to_unsigned(212, 8)), 
4 => std_logic_vector(to_unsigned(64, 8)), 
5 => std_logic_vector(to_unsigned(59, 8)), 
6 => std_logic_vector(to_unsigned(175, 8)), 
7 => std_logic_vector(to_unsigned(11, 8)), 
8 => std_logic_vector(to_unsigned(205, 8)), 
9 => std_logic_vector(to_unsigned(159, 8)), 
10 => std_logic_vector(to_unsigned(225, 8)), 
11 => std_logic_vector(to_unsigned(163, 8)), 
12 => std_logic_vector(to_unsigned(190, 8)), 
13 => std_logic_vector(to_unsigned(214, 8)), 
14 => std_logic_vector(to_unsigned(20, 8)), 
15 => std_logic_vector(to_unsigned(242, 8)), 
16 => std_logic_vector(to_unsigned(134, 8)), 
17 => std_logic_vector(to_unsigned(2, 8)), 
18 => std_logic_vector(to_unsigned(192, 8)), 
19 => std_logic_vector(to_unsigned(76, 8)), 
20 => std_logic_vector(to_unsigned(140, 8)), 
21 => std_logic_vector(to_unsigned(121, 8)), 
22 => std_logic_vector(to_unsigned(77, 8)), 
23 => std_logic_vector(to_unsigned(30, 8)), 
24 => std_logic_vector(to_unsigned(247, 8)), 
25 => std_logic_vector(to_unsigned(68, 8)), 
26 => std_logic_vector(to_unsigned(122, 8)), 
27 => std_logic_vector(to_unsigned(9, 8)), 
28 => std_logic_vector(to_unsigned(196, 8)), 
29 => std_logic_vector(to_unsigned(75, 8)), 
30 => std_logic_vector(to_unsigned(252, 8)), 
31 => std_logic_vector(to_unsigned(19, 8)), 
32 => std_logic_vector(to_unsigned(0, 8)), 
33 => std_logic_vector(to_unsigned(29, 8)), 
34 => std_logic_vector(to_unsigned(231, 8)), 
35 => std_logic_vector(to_unsigned(65, 8)), 
36 => std_logic_vector(to_unsigned(89, 8)), 
37 => std_logic_vector(to_unsigned(150, 8)), 
38 => std_logic_vector(to_unsigned(76, 8)), 
39 => std_logic_vector(to_unsigned(38, 8)), 
40 => std_logic_vector(to_unsigned(54, 8)), 
41 => std_logic_vector(to_unsigned(45, 8)), 
42 => std_logic_vector(to_unsigned(201, 8)), 
43 => std_logic_vector(to_unsigned(244, 8)), 
44 => std_logic_vector(to_unsigned(3, 8)), 
45 => std_logic_vector(to_unsigned(221, 8)), 
46 => std_logic_vector(to_unsigned(230, 8)), 
47 => std_logic_vector(to_unsigned(138, 8)), 
48 => std_logic_vector(to_unsigned(223, 8)), 
49 => std_logic_vector(to_unsigned(166, 8)), 
50 => std_logic_vector(to_unsigned(214, 8)), 
51 => std_logic_vector(to_unsigned(107, 8)), 
52 => std_logic_vector(to_unsigned(31, 8)), 
53 => std_logic_vector(to_unsigned(35, 8)), 
54 => std_logic_vector(to_unsigned(137, 8)), 
55 => std_logic_vector(to_unsigned(23, 8)), 
56 => std_logic_vector(to_unsigned(103, 8)), 
57 => std_logic_vector(to_unsigned(4, 8)), 
58 => std_logic_vector(to_unsigned(32, 8)), 
59 => std_logic_vector(to_unsigned(43, 8)), 
60 => std_logic_vector(to_unsigned(79, 8)), 
61 => std_logic_vector(to_unsigned(28, 8)), 
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
wait for 100 ns;
wait for c_CLOCK_PERIOD;
tb_rst <= '1';
wait for c_CLOCK_PERIOD;
wait for 100 ns;
tb_rst <= '0';
wait for 1400 ns;
tb_rst <= '1';
wait for c_CLOCK_PERIOD;
wait for 100 ns;
tb_rst <= '0';
wait for c_CLOCK_PERIOD;
wait until tb_done = '1';
wait for c_CLOCK_PERIOD;
tb_start <= '0';
wait until tb_done = '0';
wait for 100 ns;



assert RAM0(62) = std_logic_vector(to_unsigned(66,8)) report  " TEST FALLITO (WORKING ZONE). Expected  66  found  " & integer'image(to_integer(unsigned(RAM0(62))))  severity failure; 
assert RAM0(63) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(63))))  severity failure; 
assert RAM0(64) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM0(64))))  severity failure; 
assert RAM0(65) = std_logic_vector(to_unsigned(118,8)) report  " TEST FALLITO (WORKING ZONE). Expected  118  found  " & integer'image(to_integer(unsigned(RAM0(65))))  severity failure; 
assert RAM0(66) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(66))))  severity failure; 
assert RAM0(67) = std_logic_vector(to_unsigned(22,8)) report  " TEST FALLITO (WORKING ZONE). Expected  22  found  " & integer'image(to_integer(unsigned(RAM0(67))))  severity failure; 
assert RAM0(68) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(68))))  severity failure; 
assert RAM0(69) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(69))))  severity failure; 
assert RAM0(70) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(70))))  severity failure; 
assert RAM0(71) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(71))))  severity failure; 
assert RAM0(72) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(72))))  severity failure; 
assert RAM0(73) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(73))))  severity failure; 
assert RAM0(74) = std_logic_vector(to_unsigned(40,8)) report  " TEST FALLITO (WORKING ZONE). Expected  40  found  " & integer'image(to_integer(unsigned(RAM0(74))))  severity failure; 
assert RAM0(75) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(75))))  severity failure; 
assert RAM0(76) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(76))))  severity failure; 
assert RAM0(77) = std_logic_vector(to_unsigned(4,8)) report  " TEST FALLITO (WORKING ZONE). Expected  4  found  " & integer'image(to_integer(unsigned(RAM0(77))))  severity failure; 
assert RAM0(78) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(78))))  severity failure; 
assert RAM0(79) = std_logic_vector(to_unsigned(152,8)) report  " TEST FALLITO (WORKING ZONE). Expected  152  found  " & integer'image(to_integer(unsigned(RAM0(79))))  severity failure; 
assert RAM0(80) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(80))))  severity failure; 
assert RAM0(81) = std_logic_vector(to_unsigned(242,8)) report  " TEST FALLITO (WORKING ZONE). Expected  242  found  " & integer'image(to_integer(unsigned(RAM0(81))))  severity failure; 
assert RAM0(82) = std_logic_vector(to_unsigned(154,8)) report  " TEST FALLITO (WORKING ZONE). Expected  154  found  " & integer'image(to_integer(unsigned(RAM0(82))))  severity failure; 
assert RAM0(83) = std_logic_vector(to_unsigned(60,8)) report  " TEST FALLITO (WORKING ZONE). Expected  60  found  " & integer'image(to_integer(unsigned(RAM0(83))))  severity failure; 
assert RAM0(84) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(84))))  severity failure; 
assert RAM0(85) = std_logic_vector(to_unsigned(136,8)) report  " TEST FALLITO (WORKING ZONE). Expected  136  found  " & integer'image(to_integer(unsigned(RAM0(85))))  severity failure; 
assert RAM0(86) = std_logic_vector(to_unsigned(244,8)) report  " TEST FALLITO (WORKING ZONE). Expected  244  found  " & integer'image(to_integer(unsigned(RAM0(86))))  severity failure; 
assert RAM0(87) = std_logic_vector(to_unsigned(18,8)) report  " TEST FALLITO (WORKING ZONE). Expected  18  found  " & integer'image(to_integer(unsigned(RAM0(87))))  severity failure; 
assert RAM0(88) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(88))))  severity failure; 
assert RAM0(89) = std_logic_vector(to_unsigned(150,8)) report  " TEST FALLITO (WORKING ZONE). Expected  150  found  " & integer'image(to_integer(unsigned(RAM0(89))))  severity failure; 
assert RAM0(90) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(90))))  severity failure; 
assert RAM0(91) = std_logic_vector(to_unsigned(38,8)) report  " TEST FALLITO (WORKING ZONE). Expected  38  found  " & integer'image(to_integer(unsigned(RAM0(91))))  severity failure; 
assert RAM0(92) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM0(92))))  severity failure; 
assert RAM0(93) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM0(93))))  severity failure; 
assert RAM0(94) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(94))))  severity failure; 
assert RAM0(95) = std_logic_vector(to_unsigned(130,8)) report  " TEST FALLITO (WORKING ZONE). Expected  130  found  " & integer'image(to_integer(unsigned(RAM0(95))))  severity failure; 
assert RAM0(96) = std_logic_vector(to_unsigned(178,8)) report  " TEST FALLITO (WORKING ZONE). Expected  178  found  " & integer'image(to_integer(unsigned(RAM0(96))))  severity failure; 
assert RAM0(97) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(97))))  severity failure; 
assert RAM0(98) = std_logic_vector(to_unsigned(152,8)) report  " TEST FALLITO (WORKING ZONE). Expected  152  found  " & integer'image(to_integer(unsigned(RAM0(98))))  severity failure; 
assert RAM0(99) = std_logic_vector(to_unsigned(76,8)) report  " TEST FALLITO (WORKING ZONE). Expected  76  found  " & integer'image(to_integer(unsigned(RAM0(99))))  severity failure; 
assert RAM0(100) = std_logic_vector(to_unsigned(108,8)) report  " TEST FALLITO (WORKING ZONE). Expected  108  found  " & integer'image(to_integer(unsigned(RAM0(100))))  severity failure; 
assert RAM0(101) = std_logic_vector(to_unsigned(90,8)) report  " TEST FALLITO (WORKING ZONE). Expected  90  found  " & integer'image(to_integer(unsigned(RAM0(101))))  severity failure; 
assert RAM0(102) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(102))))  severity failure; 
assert RAM0(103) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(103))))  severity failure; 
assert RAM0(104) = std_logic_vector(to_unsigned(6,8)) report  " TEST FALLITO (WORKING ZONE). Expected  6  found  " & integer'image(to_integer(unsigned(RAM0(104))))  severity failure; 
assert RAM0(105) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(105))))  severity failure; 
assert RAM0(106) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(106))))  severity failure; 
assert RAM0(107) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(107))))  severity failure; 
assert RAM0(108) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(108))))  severity failure; 
assert RAM0(109) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(109))))  severity failure; 
assert RAM0(110) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(110))))  severity failure; 
assert RAM0(111) = std_logic_vector(to_unsigned(214,8)) report  " TEST FALLITO (WORKING ZONE). Expected  214  found  " & integer'image(to_integer(unsigned(RAM0(111))))  severity failure; 
assert RAM0(112) = std_logic_vector(to_unsigned(62,8)) report  " TEST FALLITO (WORKING ZONE). Expected  62  found  " & integer'image(to_integer(unsigned(RAM0(112))))  severity failure; 
assert RAM0(113) = std_logic_vector(to_unsigned(70,8)) report  " TEST FALLITO (WORKING ZONE). Expected  70  found  " & integer'image(to_integer(unsigned(RAM0(113))))  severity failure; 
assert RAM0(114) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(114))))  severity failure; 
assert RAM0(115) = std_logic_vector(to_unsigned(46,8)) report  " TEST FALLITO (WORKING ZONE). Expected  46  found  " & integer'image(to_integer(unsigned(RAM0(115))))  severity failure; 
assert RAM0(116) = std_logic_vector(to_unsigned(206,8)) report  " TEST FALLITO (WORKING ZONE). Expected  206  found  " & integer'image(to_integer(unsigned(RAM0(116))))  severity failure; 
assert RAM0(117) = std_logic_vector(to_unsigned(8,8)) report  " TEST FALLITO (WORKING ZONE). Expected  8  found  " & integer'image(to_integer(unsigned(RAM0(117))))  severity failure; 
assert RAM0(118) = std_logic_vector(to_unsigned(64,8)) report  " TEST FALLITO (WORKING ZONE). Expected  64  found  " & integer'image(to_integer(unsigned(RAM0(118))))  severity failure; 
assert RAM0(119) = std_logic_vector(to_unsigned(86,8)) report  " TEST FALLITO (WORKING ZONE). Expected  86  found  " & integer'image(to_integer(unsigned(RAM0(119))))  severity failure; 
assert RAM0(120) = std_logic_vector(to_unsigned(158,8)) report  " TEST FALLITO (WORKING ZONE). Expected  158  found  " & integer'image(to_integer(unsigned(RAM0(120))))  severity failure; 
assert RAM0(121) = std_logic_vector(to_unsigned(56,8)) report  " TEST FALLITO (WORKING ZONE). Expected  56  found  " & integer'image(to_integer(unsigned(RAM0(121))))  severity failure; 



assert false report " Simulation Ended! TEST PASSATO " severity failure;

end process test;
end projecttb;