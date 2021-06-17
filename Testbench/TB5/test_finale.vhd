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

signal RAM0: ram_type := (0 => std_logic_vector(to_unsigned(7, 8)), 
1 => std_logic_vector(to_unsigned(9, 8)), 
2 => std_logic_vector(to_unsigned(29, 8)), 
3 => std_logic_vector(to_unsigned(63, 8)), 
4 => std_logic_vector(to_unsigned(34, 8)), 
5 => std_logic_vector(to_unsigned(130, 8)), 
6 => std_logic_vector(to_unsigned(27, 8)), 
7 => std_logic_vector(to_unsigned(18, 8)), 
8 => std_logic_vector(to_unsigned(41, 8)), 
9 => std_logic_vector(to_unsigned(40, 8)), 
10 => std_logic_vector(to_unsigned(173, 8)), 
11 => std_logic_vector(to_unsigned(182, 8)), 
12 => std_logic_vector(to_unsigned(247, 8)), 
13 => std_logic_vector(to_unsigned(0, 8)), 
14 => std_logic_vector(to_unsigned(113, 8)), 
15 => std_logic_vector(to_unsigned(167, 8)), 
16 => std_logic_vector(to_unsigned(37, 8)), 
17 => std_logic_vector(to_unsigned(97, 8)), 
18 => std_logic_vector(to_unsigned(104, 8)), 
19 => std_logic_vector(to_unsigned(182, 8)), 
20 => std_logic_vector(to_unsigned(144, 8)), 
21 => std_logic_vector(to_unsigned(55, 8)), 
22 => std_logic_vector(to_unsigned(239, 8)), 
23 => std_logic_vector(to_unsigned(131, 8)), 
24 => std_logic_vector(to_unsigned(181, 8)), 
25 => std_logic_vector(to_unsigned(218, 8)), 
26 => std_logic_vector(to_unsigned(171, 8)), 
27 => std_logic_vector(to_unsigned(184, 8)), 
28 => std_logic_vector(to_unsigned(15, 8)), 
29 => std_logic_vector(to_unsigned(220, 8)), 
30 => std_logic_vector(to_unsigned(254, 8)), 
31 => std_logic_vector(to_unsigned(131, 8)), 
32 => std_logic_vector(to_unsigned(254, 8)), 
33 => std_logic_vector(to_unsigned(27, 8)), 
34 => std_logic_vector(to_unsigned(195, 8)), 
35 => std_logic_vector(to_unsigned(32, 8)), 
36 => std_logic_vector(to_unsigned(158, 8)), 
37 => std_logic_vector(to_unsigned(222, 8)), 
38 => std_logic_vector(to_unsigned(50, 8)), 
39 => std_logic_vector(to_unsigned(199, 8)), 
40 => std_logic_vector(to_unsigned(6, 8)), 
41 => std_logic_vector(to_unsigned(224, 8)), 
42 => std_logic_vector(to_unsigned(125, 8)), 
43 => std_logic_vector(to_unsigned(253, 8)), 
44 => std_logic_vector(to_unsigned(224, 8)), 
45 => std_logic_vector(to_unsigned(239, 8)), 
46 => std_logic_vector(to_unsigned(165, 8)), 
47 => std_logic_vector(to_unsigned(5, 8)), 
48 => std_logic_vector(to_unsigned(80, 8)), 
49 => std_logic_vector(to_unsigned(13, 8)), 
50 => std_logic_vector(to_unsigned(187, 8)), 
51 => std_logic_vector(to_unsigned(224, 8)), 
52 => std_logic_vector(to_unsigned(68, 8)), 
53 => std_logic_vector(to_unsigned(171, 8)), 
54 => std_logic_vector(to_unsigned(99, 8)), 
55 => std_logic_vector(to_unsigned(249, 8)), 
56 => std_logic_vector(to_unsigned(133, 8)), 
57 => std_logic_vector(to_unsigned(14, 8)), 
58 => std_logic_vector(to_unsigned(178, 8)), 
59 => std_logic_vector(to_unsigned(148, 8)), 
60 => std_logic_vector(to_unsigned(234, 8)), 
61 => std_logic_vector(to_unsigned(176, 8)), 
62 => std_logic_vector(to_unsigned(24, 8)), 
63 => std_logic_vector(to_unsigned(232, 8)), 
64 => std_logic_vector(to_unsigned(204, 8)), 
others => (others =>'0'));


signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned(5, 8)), 
1 => std_logic_vector(to_unsigned(6, 8)), 
2 => std_logic_vector(to_unsigned(106, 8)), 
3 => std_logic_vector(to_unsigned(185, 8)), 
4 => std_logic_vector(to_unsigned(59, 8)), 
5 => std_logic_vector(to_unsigned(49, 8)), 
6 => std_logic_vector(to_unsigned(192, 8)), 
7 => std_logic_vector(to_unsigned(27, 8)), 
8 => std_logic_vector(to_unsigned(174, 8)), 
9 => std_logic_vector(to_unsigned(189, 8)), 
10 => std_logic_vector(to_unsigned(251, 8)), 
11 => std_logic_vector(to_unsigned(157, 8)), 
12 => std_logic_vector(to_unsigned(98, 8)), 
13 => std_logic_vector(to_unsigned(0, 8)), 
14 => std_logic_vector(to_unsigned(238, 8)), 
15 => std_logic_vector(to_unsigned(112, 8)), 
16 => std_logic_vector(to_unsigned(187, 8)), 
17 => std_logic_vector(to_unsigned(206, 8)), 
18 => std_logic_vector(to_unsigned(180, 8)), 
19 => std_logic_vector(to_unsigned(102, 8)), 
20 => std_logic_vector(to_unsigned(50, 8)), 
21 => std_logic_vector(to_unsigned(174, 8)), 
22 => std_logic_vector(to_unsigned(236, 8)), 
23 => std_logic_vector(to_unsigned(64, 8)), 
24 => std_logic_vector(to_unsigned(96, 8)), 
25 => std_logic_vector(to_unsigned(128, 8)), 
26 => std_logic_vector(to_unsigned(43, 8)), 
27 => std_logic_vector(to_unsigned(16, 8)), 
28 => std_logic_vector(to_unsigned(152, 8)), 
29 => std_logic_vector(to_unsigned(19, 8)), 
30 => std_logic_vector(to_unsigned(220, 8)), 
31 => std_logic_vector(to_unsigned(115, 8)), 
others => (others =>'0'));


signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned(2, 8)), 
1 => std_logic_vector(to_unsigned(13, 8)), 
2 => std_logic_vector(to_unsigned(45, 8)), 
3 => std_logic_vector(to_unsigned(87, 8)), 
4 => std_logic_vector(to_unsigned(119, 8)), 
5 => std_logic_vector(to_unsigned(237, 8)), 
6 => std_logic_vector(to_unsigned(114, 8)), 
7 => std_logic_vector(to_unsigned(38, 8)), 
8 => std_logic_vector(to_unsigned(170, 8)), 
9 => std_logic_vector(to_unsigned(109, 8)), 
10 => std_logic_vector(to_unsigned(195, 8)), 
11 => std_logic_vector(to_unsigned(13, 8)), 
12 => std_logic_vector(to_unsigned(109, 8)), 
13 => std_logic_vector(to_unsigned(177, 8)), 
14 => std_logic_vector(to_unsigned(125, 8)), 
15 => std_logic_vector(to_unsigned(40, 8)), 
16 => std_logic_vector(to_unsigned(128, 8)), 
17 => std_logic_vector(to_unsigned(49, 8)), 
18 => std_logic_vector(to_unsigned(143, 8)), 
19 => std_logic_vector(to_unsigned(178, 8)), 
20 => std_logic_vector(to_unsigned(223, 8)), 
21 => std_logic_vector(to_unsigned(123, 8)), 
22 => std_logic_vector(to_unsigned(242, 8)), 
23 => std_logic_vector(to_unsigned(63, 8)), 
24 => std_logic_vector(to_unsigned(251, 8)), 
25 => std_logic_vector(to_unsigned(29, 8)), 
26 => std_logic_vector(to_unsigned(80, 8)), 
27 => std_logic_vector(to_unsigned(148, 8)), 
others => (others =>'0'));


signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned(3, 8)), 
1 => std_logic_vector(to_unsigned(15, 8)), 
2 => std_logic_vector(to_unsigned(7, 8)), 
3 => std_logic_vector(to_unsigned(77, 8)), 
4 => std_logic_vector(to_unsigned(115, 8)), 
5 => std_logic_vector(to_unsigned(52, 8)), 
6 => std_logic_vector(to_unsigned(164, 8)), 
7 => std_logic_vector(to_unsigned(234, 8)), 
8 => std_logic_vector(to_unsigned(33, 8)), 
9 => std_logic_vector(to_unsigned(22, 8)), 
10 => std_logic_vector(to_unsigned(16, 8)), 
11 => std_logic_vector(to_unsigned(204, 8)), 
12 => std_logic_vector(to_unsigned(131, 8)), 
13 => std_logic_vector(to_unsigned(212, 8)), 
14 => std_logic_vector(to_unsigned(217, 8)), 
15 => std_logic_vector(to_unsigned(240, 8)), 
16 => std_logic_vector(to_unsigned(133, 8)), 
17 => std_logic_vector(to_unsigned(86, 8)), 
18 => std_logic_vector(to_unsigned(24, 8)), 
19 => std_logic_vector(to_unsigned(5, 8)), 
20 => std_logic_vector(to_unsigned(135, 8)), 
21 => std_logic_vector(to_unsigned(167, 8)), 
22 => std_logic_vector(to_unsigned(183, 8)), 
23 => std_logic_vector(to_unsigned(103, 8)), 
24 => std_logic_vector(to_unsigned(34, 8)), 
25 => std_logic_vector(to_unsigned(170, 8)), 
26 => std_logic_vector(to_unsigned(166, 8)), 
27 => std_logic_vector(to_unsigned(30, 8)), 
28 => std_logic_vector(to_unsigned(199, 8)), 
29 => std_logic_vector(to_unsigned(246, 8)), 
30 => std_logic_vector(to_unsigned(178, 8)), 
31 => std_logic_vector(to_unsigned(248, 8)), 
32 => std_logic_vector(to_unsigned(35, 8)), 
33 => std_logic_vector(to_unsigned(185, 8)), 
34 => std_logic_vector(to_unsigned(69, 8)), 
35 => std_logic_vector(to_unsigned(150, 8)), 
36 => std_logic_vector(to_unsigned(238, 8)), 
37 => std_logic_vector(to_unsigned(233, 8)), 
38 => std_logic_vector(to_unsigned(128, 8)), 
39 => std_logic_vector(to_unsigned(15, 8)), 
40 => std_logic_vector(to_unsigned(255, 8)), 
41 => std_logic_vector(to_unsigned(145, 8)), 
42 => std_logic_vector(to_unsigned(219, 8)), 
43 => std_logic_vector(to_unsigned(130, 8)), 
44 => std_logic_vector(to_unsigned(101, 8)), 
45 => std_logic_vector(to_unsigned(180, 8)), 
46 => std_logic_vector(to_unsigned(114, 8)), 
others => (others =>'0'));


signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned(13, 8)), 
1 => std_logic_vector(to_unsigned(7, 8)), 
2 => std_logic_vector(to_unsigned(139, 8)), 
3 => std_logic_vector(to_unsigned(240, 8)), 
4 => std_logic_vector(to_unsigned(146, 8)), 
5 => std_logic_vector(to_unsigned(50, 8)), 
6 => std_logic_vector(to_unsigned(167, 8)), 
7 => std_logic_vector(to_unsigned(249, 8)), 
8 => std_logic_vector(to_unsigned(85, 8)), 
9 => std_logic_vector(to_unsigned(81, 8)), 
10 => std_logic_vector(to_unsigned(159, 8)), 
11 => std_logic_vector(to_unsigned(115, 8)), 
12 => std_logic_vector(to_unsigned(25, 8)), 
13 => std_logic_vector(to_unsigned(150, 8)), 
14 => std_logic_vector(to_unsigned(37, 8)), 
15 => std_logic_vector(to_unsigned(17, 8)), 
16 => std_logic_vector(to_unsigned(185, 8)), 
17 => std_logic_vector(to_unsigned(222, 8)), 
18 => std_logic_vector(to_unsigned(87, 8)), 
19 => std_logic_vector(to_unsigned(79, 8)), 
20 => std_logic_vector(to_unsigned(204, 8)), 
21 => std_logic_vector(to_unsigned(64, 8)), 
22 => std_logic_vector(to_unsigned(207, 8)), 
23 => std_logic_vector(to_unsigned(220, 8)), 
24 => std_logic_vector(to_unsigned(64, 8)), 
25 => std_logic_vector(to_unsigned(96, 8)), 
26 => std_logic_vector(to_unsigned(183, 8)), 
27 => std_logic_vector(to_unsigned(194, 8)), 
28 => std_logic_vector(to_unsigned(197, 8)), 
29 => std_logic_vector(to_unsigned(108, 8)), 
30 => std_logic_vector(to_unsigned(53, 8)), 
31 => std_logic_vector(to_unsigned(176, 8)), 
32 => std_logic_vector(to_unsigned(118, 8)), 
33 => std_logic_vector(to_unsigned(192, 8)), 
34 => std_logic_vector(to_unsigned(160, 8)), 
35 => std_logic_vector(to_unsigned(8, 8)), 
36 => std_logic_vector(to_unsigned(242, 8)), 
37 => std_logic_vector(to_unsigned(71, 8)), 
38 => std_logic_vector(to_unsigned(1, 8)), 
39 => std_logic_vector(to_unsigned(71, 8)), 
40 => std_logic_vector(to_unsigned(153, 8)), 
41 => std_logic_vector(to_unsigned(161, 8)), 
42 => std_logic_vector(to_unsigned(186, 8)), 
43 => std_logic_vector(to_unsigned(178, 8)), 
44 => std_logic_vector(to_unsigned(55, 8)), 
45 => std_logic_vector(to_unsigned(223, 8)), 
46 => std_logic_vector(to_unsigned(195, 8)), 
47 => std_logic_vector(to_unsigned(240, 8)), 
48 => std_logic_vector(to_unsigned(190, 8)), 
49 => std_logic_vector(to_unsigned(26, 8)), 
50 => std_logic_vector(to_unsigned(63, 8)), 
51 => std_logic_vector(to_unsigned(138, 8)), 
52 => std_logic_vector(to_unsigned(91, 8)), 
53 => std_logic_vector(to_unsigned(14, 8)), 
54 => std_logic_vector(to_unsigned(102, 8)), 
55 => std_logic_vector(to_unsigned(155, 8)), 
56 => std_logic_vector(to_unsigned(111, 8)), 
57 => std_logic_vector(to_unsigned(30, 8)), 
58 => std_logic_vector(to_unsigned(93, 8)), 
59 => std_logic_vector(to_unsigned(52, 8)), 
60 => std_logic_vector(to_unsigned(138, 8)), 
61 => std_logic_vector(to_unsigned(146, 8)), 
62 => std_logic_vector(to_unsigned(228, 8)), 
63 => std_logic_vector(to_unsigned(0, 8)), 
64 => std_logic_vector(to_unsigned(82, 8)), 
65 => std_logic_vector(to_unsigned(132, 8)), 
66 => std_logic_vector(to_unsigned(9, 8)), 
67 => std_logic_vector(to_unsigned(69, 8)), 
68 => std_logic_vector(to_unsigned(204, 8)), 
69 => std_logic_vector(to_unsigned(10, 8)), 
70 => std_logic_vector(to_unsigned(140, 8)), 
71 => std_logic_vector(to_unsigned(101, 8)), 
72 => std_logic_vector(to_unsigned(171, 8)), 
73 => std_logic_vector(to_unsigned(71, 8)), 
74 => std_logic_vector(to_unsigned(23, 8)), 
75 => std_logic_vector(to_unsigned(226, 8)), 
76 => std_logic_vector(to_unsigned(38, 8)), 
77 => std_logic_vector(to_unsigned(218, 8)), 
78 => std_logic_vector(to_unsigned(210, 8)), 
79 => std_logic_vector(to_unsigned(228, 8)), 
80 => std_logic_vector(to_unsigned(245, 8)), 
81 => std_logic_vector(to_unsigned(17, 8)), 
82 => std_logic_vector(to_unsigned(111, 8)), 
83 => std_logic_vector(to_unsigned(80, 8)), 
84 => std_logic_vector(to_unsigned(32, 8)), 
85 => std_logic_vector(to_unsigned(213, 8)), 
86 => std_logic_vector(to_unsigned(235, 8)), 
87 => std_logic_vector(to_unsigned(143, 8)), 
88 => std_logic_vector(to_unsigned(243, 8)), 
89 => std_logic_vector(to_unsigned(72, 8)), 
90 => std_logic_vector(to_unsigned(195, 8)), 
91 => std_logic_vector(to_unsigned(125, 8)), 
92 => std_logic_vector(to_unsigned(219, 8)), 
others => (others =>'0'));


signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned(2, 8)), 
1 => std_logic_vector(to_unsigned(10, 8)), 
2 => std_logic_vector(to_unsigned(45, 8)), 
3 => std_logic_vector(to_unsigned(44, 8)), 
4 => std_logic_vector(to_unsigned(135, 8)), 
5 => std_logic_vector(to_unsigned(114, 8)), 
6 => std_logic_vector(to_unsigned(248, 8)), 
7 => std_logic_vector(to_unsigned(145, 8)), 
8 => std_logic_vector(to_unsigned(255, 8)), 
9 => std_logic_vector(to_unsigned(93, 8)), 
10 => std_logic_vector(to_unsigned(61, 8)), 
11 => std_logic_vector(to_unsigned(70, 8)), 
12 => std_logic_vector(to_unsigned(116, 8)), 
13 => std_logic_vector(to_unsigned(31, 8)), 
14 => std_logic_vector(to_unsigned(108, 8)), 
15 => std_logic_vector(to_unsigned(79, 8)), 
16 => std_logic_vector(to_unsigned(242, 8)), 
17 => std_logic_vector(to_unsigned(81, 8)), 
18 => std_logic_vector(to_unsigned(68, 8)), 
19 => std_logic_vector(to_unsigned(3, 8)), 
20 => std_logic_vector(to_unsigned(192, 8)), 
21 => std_logic_vector(to_unsigned(148, 8)), 
others => (others =>'0'));


signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned(11, 8)), 
1 => std_logic_vector(to_unsigned(3, 8)), 
2 => std_logic_vector(to_unsigned(127, 8)), 
3 => std_logic_vector(to_unsigned(178, 8)), 
4 => std_logic_vector(to_unsigned(137, 8)), 
5 => std_logic_vector(to_unsigned(199, 8)), 
6 => std_logic_vector(to_unsigned(118, 8)), 
7 => std_logic_vector(to_unsigned(6, 8)), 
8 => std_logic_vector(to_unsigned(162, 8)), 
9 => std_logic_vector(to_unsigned(30, 8)), 
10 => std_logic_vector(to_unsigned(132, 8)), 
11 => std_logic_vector(to_unsigned(208, 8)), 
12 => std_logic_vector(to_unsigned(74, 8)), 
13 => std_logic_vector(to_unsigned(11, 8)), 
14 => std_logic_vector(to_unsigned(66, 8)), 
15 => std_logic_vector(to_unsigned(67, 8)), 
16 => std_logic_vector(to_unsigned(157, 8)), 
17 => std_logic_vector(to_unsigned(65, 8)), 
18 => std_logic_vector(to_unsigned(160, 8)), 
19 => std_logic_vector(to_unsigned(218, 8)), 
20 => std_logic_vector(to_unsigned(135, 8)), 
21 => std_logic_vector(to_unsigned(21, 8)), 
22 => std_logic_vector(to_unsigned(249, 8)), 
23 => std_logic_vector(to_unsigned(244, 8)), 
24 => std_logic_vector(to_unsigned(100, 8)), 
25 => std_logic_vector(to_unsigned(235, 8)), 
26 => std_logic_vector(to_unsigned(69, 8)), 
27 => std_logic_vector(to_unsigned(168, 8)), 
28 => std_logic_vector(to_unsigned(239, 8)), 
29 => std_logic_vector(to_unsigned(5, 8)), 
30 => std_logic_vector(to_unsigned(60, 8)), 
31 => std_logic_vector(to_unsigned(18, 8)), 
32 => std_logic_vector(to_unsigned(154, 8)), 
33 => std_logic_vector(to_unsigned(187, 8)), 
34 => std_logic_vector(to_unsigned(197, 8)), 
others => (others =>'0'));


signal RAM7: ram_type := (0 => std_logic_vector(to_unsigned(7, 8)), 
1 => std_logic_vector(to_unsigned(8, 8)), 
2 => std_logic_vector(to_unsigned(59, 8)), 
3 => std_logic_vector(to_unsigned(42, 8)), 
4 => std_logic_vector(to_unsigned(37, 8)), 
5 => std_logic_vector(to_unsigned(89, 8)), 
6 => std_logic_vector(to_unsigned(174, 8)), 
7 => std_logic_vector(to_unsigned(245, 8)), 
8 => std_logic_vector(to_unsigned(163, 8)), 
9 => std_logic_vector(to_unsigned(186, 8)), 
10 => std_logic_vector(to_unsigned(55, 8)), 
11 => std_logic_vector(to_unsigned(230, 8)), 
12 => std_logic_vector(to_unsigned(87, 8)), 
13 => std_logic_vector(to_unsigned(121, 8)), 
14 => std_logic_vector(to_unsigned(135, 8)), 
15 => std_logic_vector(to_unsigned(49, 8)), 
16 => std_logic_vector(to_unsigned(0, 8)), 
17 => std_logic_vector(to_unsigned(156, 8)), 
18 => std_logic_vector(to_unsigned(42, 8)), 
19 => std_logic_vector(to_unsigned(244, 8)), 
20 => std_logic_vector(to_unsigned(0, 8)), 
21 => std_logic_vector(to_unsigned(22, 8)), 
22 => std_logic_vector(to_unsigned(57, 8)), 
23 => std_logic_vector(to_unsigned(168, 8)), 
24 => std_logic_vector(to_unsigned(5, 8)), 
25 => std_logic_vector(to_unsigned(62, 8)), 
26 => std_logic_vector(to_unsigned(228, 8)), 
27 => std_logic_vector(to_unsigned(23, 8)), 
28 => std_logic_vector(to_unsigned(217, 8)), 
29 => std_logic_vector(to_unsigned(159, 8)), 
30 => std_logic_vector(to_unsigned(220, 8)), 
31 => std_logic_vector(to_unsigned(252, 8)), 
32 => std_logic_vector(to_unsigned(33, 8)), 
33 => std_logic_vector(to_unsigned(23, 8)), 
34 => std_logic_vector(to_unsigned(38, 8)), 
35 => std_logic_vector(to_unsigned(70, 8)), 
36 => std_logic_vector(to_unsigned(112, 8)), 
37 => std_logic_vector(to_unsigned(213, 8)), 
38 => std_logic_vector(to_unsigned(59, 8)), 
39 => std_logic_vector(to_unsigned(20, 8)), 
40 => std_logic_vector(to_unsigned(143, 8)), 
41 => std_logic_vector(to_unsigned(115, 8)), 
42 => std_logic_vector(to_unsigned(250, 8)), 
43 => std_logic_vector(to_unsigned(230, 8)), 
44 => std_logic_vector(to_unsigned(236, 8)), 
45 => std_logic_vector(to_unsigned(129, 8)), 
46 => std_logic_vector(to_unsigned(23, 8)), 
47 => std_logic_vector(to_unsigned(236, 8)), 
48 => std_logic_vector(to_unsigned(29, 8)), 
49 => std_logic_vector(to_unsigned(65, 8)), 
50 => std_logic_vector(to_unsigned(225, 8)), 
51 => std_logic_vector(to_unsigned(29, 8)), 
52 => std_logic_vector(to_unsigned(87, 8)), 
53 => std_logic_vector(to_unsigned(26, 8)), 
54 => std_logic_vector(to_unsigned(197, 8)), 
55 => std_logic_vector(to_unsigned(92, 8)), 
56 => std_logic_vector(to_unsigned(89, 8)), 
57 => std_logic_vector(to_unsigned(169, 8)), 
others => (others =>'0'));


signal RAM8: ram_type := (0 => std_logic_vector(to_unsigned(5, 8)), 
1 => std_logic_vector(to_unsigned(6, 8)), 
2 => std_logic_vector(to_unsigned(72, 8)), 
3 => std_logic_vector(to_unsigned(80, 8)), 
4 => std_logic_vector(to_unsigned(46, 8)), 
5 => std_logic_vector(to_unsigned(106, 8)), 
6 => std_logic_vector(to_unsigned(104, 8)), 
7 => std_logic_vector(to_unsigned(85, 8)), 
8 => std_logic_vector(to_unsigned(176, 8)), 
9 => std_logic_vector(to_unsigned(216, 8)), 
10 => std_logic_vector(to_unsigned(42, 8)), 
11 => std_logic_vector(to_unsigned(236, 8)), 
12 => std_logic_vector(to_unsigned(236, 8)), 
13 => std_logic_vector(to_unsigned(185, 8)), 
14 => std_logic_vector(to_unsigned(95, 8)), 
15 => std_logic_vector(to_unsigned(231, 8)), 
16 => std_logic_vector(to_unsigned(159, 8)), 
17 => std_logic_vector(to_unsigned(75, 8)), 
18 => std_logic_vector(to_unsigned(104, 8)), 
19 => std_logic_vector(to_unsigned(182, 8)), 
20 => std_logic_vector(to_unsigned(55, 8)), 
21 => std_logic_vector(to_unsigned(134, 8)), 
22 => std_logic_vector(to_unsigned(247, 8)), 
23 => std_logic_vector(to_unsigned(24, 8)), 
24 => std_logic_vector(to_unsigned(163, 8)), 
25 => std_logic_vector(to_unsigned(79, 8)), 
26 => std_logic_vector(to_unsigned(51, 8)), 
27 => std_logic_vector(to_unsigned(105, 8)), 
28 => std_logic_vector(to_unsigned(171, 8)), 
29 => std_logic_vector(to_unsigned(140, 8)), 
30 => std_logic_vector(to_unsigned(18, 8)), 
31 => std_logic_vector(to_unsigned(31, 8)), 
others => (others =>'0'));


signal RAM9: ram_type := (0 => std_logic_vector(to_unsigned(3, 8)), 
1 => std_logic_vector(to_unsigned(6, 8)), 
2 => std_logic_vector(to_unsigned(112, 8)), 
3 => std_logic_vector(to_unsigned(236, 8)), 
4 => std_logic_vector(to_unsigned(197, 8)), 
5 => std_logic_vector(to_unsigned(216, 8)), 
6 => std_logic_vector(to_unsigned(65, 8)), 
7 => std_logic_vector(to_unsigned(117, 8)), 
8 => std_logic_vector(to_unsigned(176, 8)), 
9 => std_logic_vector(to_unsigned(107, 8)), 
10 => std_logic_vector(to_unsigned(97, 8)), 
11 => std_logic_vector(to_unsigned(157, 8)), 
12 => std_logic_vector(to_unsigned(36, 8)), 
13 => std_logic_vector(to_unsigned(192, 8)), 
14 => std_logic_vector(to_unsigned(132, 8)), 
15 => std_logic_vector(to_unsigned(195, 8)), 
16 => std_logic_vector(to_unsigned(11, 8)), 
17 => std_logic_vector(to_unsigned(236, 8)), 
18 => std_logic_vector(to_unsigned(121, 8)), 
19 => std_logic_vector(to_unsigned(67, 8)), 
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
elsif i = 3 then
if mem_we = '1' then
RAM3(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 4 then
if mem_we = '1' then
RAM4(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 5 then
if mem_we = '1' then
RAM5(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 6 then
if mem_we = '1' then
RAM6(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 7 then
if mem_we = '1' then
RAM7(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 8 then
if mem_we = '1' then
RAM8(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM8(conv_integer(mem_address)) after 1 ns;
end if;
elsif i = 9 then
if mem_we = '1' then
RAM9(conv_integer(mem_address))  <= mem_i_data;
mem_o_data                      <= mem_i_data after 1 ns;
else
mem_o_data <= RAM9(conv_integer(mem_address)) after 1 ns;
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
i <= i + 1;

wait for 100 ns;
tb_start <= '1';
wait for c_CLOCK_PERIOD;
wait until tb_done = '1';
wait for c_CLOCK_PERIOD;
tb_start <= '0';
wait until tb_done = '0';
wait for 100 ns;


assert RAM0(65) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM0(65))))  severity failure; 
assert RAM0(66) = std_logic_vector(to_unsigned(126,8)) report  " TEST FALLITO (WORKING ZONE). Expected  126  found  " & integer'image(to_integer(unsigned(RAM0(66))))  severity failure; 
assert RAM0(67) = std_logic_vector(to_unsigned(68,8)) report  " TEST FALLITO (WORKING ZONE). Expected  68  found  " & integer'image(to_integer(unsigned(RAM0(67))))  severity failure; 
assert RAM0(68) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(68))))  severity failure; 
assert RAM0(69) = std_logic_vector(to_unsigned(54,8)) report  " TEST FALLITO (WORKING ZONE). Expected  54  found  " & integer'image(to_integer(unsigned(RAM0(69))))  severity failure; 
assert RAM0(70) = std_logic_vector(to_unsigned(36,8)) report  " TEST FALLITO (WORKING ZONE). Expected  36  found  " & integer'image(to_integer(unsigned(RAM0(70))))  severity failure; 
assert RAM0(71) = std_logic_vector(to_unsigned(82,8)) report  " TEST FALLITO (WORKING ZONE). Expected  82  found  " & integer'image(to_integer(unsigned(RAM0(71))))  severity failure; 
assert RAM0(72) = std_logic_vector(to_unsigned(80,8)) report  " TEST FALLITO (WORKING ZONE). Expected  80  found  " & integer'image(to_integer(unsigned(RAM0(72))))  severity failure; 
assert RAM0(73) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(73))))  severity failure; 
assert RAM0(74) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(74))))  severity failure; 
assert RAM0(75) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(75))))  severity failure; 
assert RAM0(76) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM0(76))))  severity failure; 
assert RAM0(77) = std_logic_vector(to_unsigned(226,8)) report  " TEST FALLITO (WORKING ZONE). Expected  226  found  " & integer'image(to_integer(unsigned(RAM0(77))))  severity failure; 
assert RAM0(78) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(78))))  severity failure; 
assert RAM0(79) = std_logic_vector(to_unsigned(74,8)) report  " TEST FALLITO (WORKING ZONE). Expected  74  found  " & integer'image(to_integer(unsigned(RAM0(79))))  severity failure; 
assert RAM0(80) = std_logic_vector(to_unsigned(194,8)) report  " TEST FALLITO (WORKING ZONE). Expected  194  found  " & integer'image(to_integer(unsigned(RAM0(80))))  severity failure; 
assert RAM0(81) = std_logic_vector(to_unsigned(208,8)) report  " TEST FALLITO (WORKING ZONE). Expected  208  found  " & integer'image(to_integer(unsigned(RAM0(81))))  severity failure; 
assert RAM0(82) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(82))))  severity failure; 
assert RAM0(83) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(83))))  severity failure; 
assert RAM0(84) = std_logic_vector(to_unsigned(110,8)) report  " TEST FALLITO (WORKING ZONE). Expected  110  found  " & integer'image(to_integer(unsigned(RAM0(84))))  severity failure; 
assert RAM0(85) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(85))))  severity failure; 
assert RAM0(86) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(86))))  severity failure; 
assert RAM0(87) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(87))))  severity failure; 
assert RAM0(88) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(88))))  severity failure; 
assert RAM0(89) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(89))))  severity failure; 
assert RAM0(90) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(90))))  severity failure; 
assert RAM0(91) = std_logic_vector(to_unsigned(30,8)) report  " TEST FALLITO (WORKING ZONE). Expected  30  found  " & integer'image(to_integer(unsigned(RAM0(91))))  severity failure; 
assert RAM0(92) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(92))))  severity failure; 
assert RAM0(93) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(93))))  severity failure; 
assert RAM0(94) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(94))))  severity failure; 
assert RAM0(95) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(95))))  severity failure; 
assert RAM0(96) = std_logic_vector(to_unsigned(54,8)) report  " TEST FALLITO (WORKING ZONE). Expected  54  found  " & integer'image(to_integer(unsigned(RAM0(96))))  severity failure; 
assert RAM0(97) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(97))))  severity failure; 
assert RAM0(98) = std_logic_vector(to_unsigned(64,8)) report  " TEST FALLITO (WORKING ZONE). Expected  64  found  " & integer'image(to_integer(unsigned(RAM0(98))))  severity failure; 
assert RAM0(99) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(99))))  severity failure; 
assert RAM0(100) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(100))))  severity failure; 
assert RAM0(101) = std_logic_vector(to_unsigned(100,8)) report  " TEST FALLITO (WORKING ZONE). Expected  100  found  " & integer'image(to_integer(unsigned(RAM0(101))))  severity failure; 
assert RAM0(102) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(102))))  severity failure; 
assert RAM0(103) = std_logic_vector(to_unsigned(12,8)) report  " TEST FALLITO (WORKING ZONE). Expected  12  found  " & integer'image(to_integer(unsigned(RAM0(103))))  severity failure; 
assert RAM0(104) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(104))))  severity failure; 
assert RAM0(105) = std_logic_vector(to_unsigned(250,8)) report  " TEST FALLITO (WORKING ZONE). Expected  250  found  " & integer'image(to_integer(unsigned(RAM0(105))))  severity failure; 
assert RAM0(106) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(106))))  severity failure; 
assert RAM0(107) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(107))))  severity failure; 
assert RAM0(108) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(108))))  severity failure; 
assert RAM0(109) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(109))))  severity failure; 
assert RAM0(110) = std_logic_vector(to_unsigned(10,8)) report  " TEST FALLITO (WORKING ZONE). Expected  10  found  " & integer'image(to_integer(unsigned(RAM0(110))))  severity failure; 
assert RAM0(111) = std_logic_vector(to_unsigned(160,8)) report  " TEST FALLITO (WORKING ZONE). Expected  160  found  " & integer'image(to_integer(unsigned(RAM0(111))))  severity failure; 
assert RAM0(112) = std_logic_vector(to_unsigned(26,8)) report  " TEST FALLITO (WORKING ZONE). Expected  26  found  " & integer'image(to_integer(unsigned(RAM0(112))))  severity failure; 
assert RAM0(113) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(113))))  severity failure; 
assert RAM0(114) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(114))))  severity failure; 
assert RAM0(115) = std_logic_vector(to_unsigned(136,8)) report  " TEST FALLITO (WORKING ZONE). Expected  136  found  " & integer'image(to_integer(unsigned(RAM0(115))))  severity failure; 
assert RAM0(116) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(116))))  severity failure; 
assert RAM0(117) = std_logic_vector(to_unsigned(198,8)) report  " TEST FALLITO (WORKING ZONE). Expected  198  found  " & integer'image(to_integer(unsigned(RAM0(117))))  severity failure; 
assert RAM0(118) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(118))))  severity failure; 
assert RAM0(119) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(119))))  severity failure; 
assert RAM0(120) = std_logic_vector(to_unsigned(28,8)) report  " TEST FALLITO (WORKING ZONE). Expected  28  found  " & integer'image(to_integer(unsigned(RAM0(120))))  severity failure; 
assert RAM0(121) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(121))))  severity failure; 
assert RAM0(122) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(122))))  severity failure; 
assert RAM0(123) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(123))))  severity failure; 
assert RAM0(124) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(124))))  severity failure; 
assert RAM0(125) = std_logic_vector(to_unsigned(48,8)) report  " TEST FALLITO (WORKING ZONE). Expected  48  found  " & integer'image(to_integer(unsigned(RAM0(125))))  severity failure; 
assert RAM0(126) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(126))))  severity failure; 
assert RAM0(127) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM0(127))))  severity failure; 


assert RAM1(32) = std_logic_vector(to_unsigned(212,8)) report  " TEST FALLITO (WORKING ZONE). Expected  212  found  " & integer'image(to_integer(unsigned(RAM1(32))))  severity failure; 
assert RAM1(33) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(33))))  severity failure; 
assert RAM1(34) = std_logic_vector(to_unsigned(118,8)) report  " TEST FALLITO (WORKING ZONE). Expected  118  found  " & integer'image(to_integer(unsigned(RAM1(34))))  severity failure; 
assert RAM1(35) = std_logic_vector(to_unsigned(98,8)) report  " TEST FALLITO (WORKING ZONE). Expected  98  found  " & integer'image(to_integer(unsigned(RAM1(35))))  severity failure; 
assert RAM1(36) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(36))))  severity failure; 
assert RAM1(37) = std_logic_vector(to_unsigned(54,8)) report  " TEST FALLITO (WORKING ZONE). Expected  54  found  " & integer'image(to_integer(unsigned(RAM1(37))))  severity failure; 
assert RAM1(38) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(38))))  severity failure; 
assert RAM1(39) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(39))))  severity failure; 
assert RAM1(40) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(40))))  severity failure; 
assert RAM1(41) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(41))))  severity failure; 
assert RAM1(42) = std_logic_vector(to_unsigned(196,8)) report  " TEST FALLITO (WORKING ZONE). Expected  196  found  " & integer'image(to_integer(unsigned(RAM1(42))))  severity failure; 
assert RAM1(43) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM1(43))))  severity failure; 
assert RAM1(44) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(44))))  severity failure; 
assert RAM1(45) = std_logic_vector(to_unsigned(224,8)) report  " TEST FALLITO (WORKING ZONE). Expected  224  found  " & integer'image(to_integer(unsigned(RAM1(45))))  severity failure; 
assert RAM1(46) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(46))))  severity failure; 
assert RAM1(47) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(47))))  severity failure; 
assert RAM1(48) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(48))))  severity failure; 
assert RAM1(49) = std_logic_vector(to_unsigned(204,8)) report  " TEST FALLITO (WORKING ZONE). Expected  204  found  " & integer'image(to_integer(unsigned(RAM1(49))))  severity failure; 
assert RAM1(50) = std_logic_vector(to_unsigned(100,8)) report  " TEST FALLITO (WORKING ZONE). Expected  100  found  " & integer'image(to_integer(unsigned(RAM1(50))))  severity failure; 
assert RAM1(51) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(51))))  severity failure; 
assert RAM1(52) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(52))))  severity failure; 
assert RAM1(53) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM1(53))))  severity failure; 
assert RAM1(54) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM1(54))))  severity failure; 
assert RAM1(55) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(55))))  severity failure; 
assert RAM1(56) = std_logic_vector(to_unsigned(86,8)) report  " TEST FALLITO (WORKING ZONE). Expected  86  found  " & integer'image(to_integer(unsigned(RAM1(56))))  severity failure; 
assert RAM1(57) = std_logic_vector(to_unsigned(32,8)) report  " TEST FALLITO (WORKING ZONE). Expected  32  found  " & integer'image(to_integer(unsigned(RAM1(57))))  severity failure; 
assert RAM1(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(58))))  severity failure; 
assert RAM1(59) = std_logic_vector(to_unsigned(38,8)) report  " TEST FALLITO (WORKING ZONE). Expected  38  found  " & integer'image(to_integer(unsigned(RAM1(59))))  severity failure; 
assert RAM1(60) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM1(60))))  severity failure; 
assert RAM1(61) = std_logic_vector(to_unsigned(230,8)) report  " TEST FALLITO (WORKING ZONE). Expected  230  found  " & integer'image(to_integer(unsigned(RAM1(61))))  severity failure; 


assert RAM2(28) = std_logic_vector(to_unsigned(64,8)) report  " TEST FALLITO (WORKING ZONE). Expected  64  found  " & integer'image(to_integer(unsigned(RAM2(28))))  severity failure; 
assert RAM2(29) = std_logic_vector(to_unsigned(148,8)) report  " TEST FALLITO (WORKING ZONE). Expected  148  found  " & integer'image(to_integer(unsigned(RAM2(29))))  severity failure; 
assert RAM2(30) = std_logic_vector(to_unsigned(212,8)) report  " TEST FALLITO (WORKING ZONE). Expected  212  found  " & integer'image(to_integer(unsigned(RAM2(30))))  severity failure; 
assert RAM2(31) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(31))))  severity failure; 
assert RAM2(32) = std_logic_vector(to_unsigned(202,8)) report  " TEST FALLITO (WORKING ZONE). Expected  202  found  " & integer'image(to_integer(unsigned(RAM2(32))))  severity failure; 
assert RAM2(33) = std_logic_vector(to_unsigned(50,8)) report  " TEST FALLITO (WORKING ZONE). Expected  50  found  " & integer'image(to_integer(unsigned(RAM2(33))))  severity failure; 
assert RAM2(34) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(34))))  severity failure; 
assert RAM2(35) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM2(35))))  severity failure; 
assert RAM2(36) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(36))))  severity failure; 
assert RAM2(37) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM2(37))))  severity failure; 
assert RAM2(38) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM2(38))))  severity failure; 
assert RAM2(39) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(39))))  severity failure; 
assert RAM2(40) = std_logic_vector(to_unsigned(224,8)) report  " TEST FALLITO (WORKING ZONE). Expected  224  found  " & integer'image(to_integer(unsigned(RAM2(40))))  severity failure; 
assert RAM2(41) = std_logic_vector(to_unsigned(54,8)) report  " TEST FALLITO (WORKING ZONE). Expected  54  found  " & integer'image(to_integer(unsigned(RAM2(41))))  severity failure; 
assert RAM2(42) = std_logic_vector(to_unsigned(230,8)) report  " TEST FALLITO (WORKING ZONE). Expected  230  found  " & integer'image(to_integer(unsigned(RAM2(42))))  severity failure; 
assert RAM2(43) = std_logic_vector(to_unsigned(72,8)) report  " TEST FALLITO (WORKING ZONE). Expected  72  found  " & integer'image(to_integer(unsigned(RAM2(43))))  severity failure; 
assert RAM2(44) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(44))))  severity failure; 
assert RAM2(45) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(45))))  severity failure; 
assert RAM2(46) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(46))))  severity failure; 
assert RAM2(47) = std_logic_vector(to_unsigned(220,8)) report  " TEST FALLITO (WORKING ZONE). Expected  220  found  " & integer'image(to_integer(unsigned(RAM2(47))))  severity failure; 
assert RAM2(48) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(48))))  severity failure; 
assert RAM2(49) = std_logic_vector(to_unsigned(100,8)) report  " TEST FALLITO (WORKING ZONE). Expected  100  found  " & integer'image(to_integer(unsigned(RAM2(49))))  severity failure; 
assert RAM2(50) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(50))))  severity failure; 
assert RAM2(51) = std_logic_vector(to_unsigned(32,8)) report  " TEST FALLITO (WORKING ZONE). Expected  32  found  " & integer'image(to_integer(unsigned(RAM2(51))))  severity failure; 
assert RAM2(52) = std_logic_vector(to_unsigned(134,8)) report  " TEST FALLITO (WORKING ZONE). Expected  134  found  " & integer'image(to_integer(unsigned(RAM2(52))))  severity failure; 
assert RAM2(53) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM2(53))))  severity failure; 


assert RAM3(47) = std_logic_vector(to_unsigned(4,8)) report  " TEST FALLITO (WORKING ZONE). Expected  4  found  " & integer'image(to_integer(unsigned(RAM3(47))))  severity failure; 
assert RAM3(48) = std_logic_vector(to_unsigned(144,8)) report  " TEST FALLITO (WORKING ZONE). Expected  144  found  " & integer'image(to_integer(unsigned(RAM3(48))))  severity failure; 
assert RAM3(49) = std_logic_vector(to_unsigned(220,8)) report  " TEST FALLITO (WORKING ZONE). Expected  220  found  " & integer'image(to_integer(unsigned(RAM3(49))))  severity failure; 
assert RAM3(50) = std_logic_vector(to_unsigned(94,8)) report  " TEST FALLITO (WORKING ZONE). Expected  94  found  " & integer'image(to_integer(unsigned(RAM3(50))))  severity failure; 
assert RAM3(51) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(51))))  severity failure; 
assert RAM3(52) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(52))))  severity failure; 
assert RAM3(53) = std_logic_vector(to_unsigned(56,8)) report  " TEST FALLITO (WORKING ZONE). Expected  56  found  " & integer'image(to_integer(unsigned(RAM3(53))))  severity failure; 
assert RAM3(54) = std_logic_vector(to_unsigned(34,8)) report  " TEST FALLITO (WORKING ZONE). Expected  34  found  " & integer'image(to_integer(unsigned(RAM3(54))))  severity failure; 
assert RAM3(55) = std_logic_vector(to_unsigned(22,8)) report  " TEST FALLITO (WORKING ZONE). Expected  22  found  " & integer'image(to_integer(unsigned(RAM3(55))))  severity failure; 
assert RAM3(56) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(56))))  severity failure; 
assert RAM3(57) = std_logic_vector(to_unsigned(252,8)) report  " TEST FALLITO (WORKING ZONE). Expected  252  found  " & integer'image(to_integer(unsigned(RAM3(57))))  severity failure; 
assert RAM3(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(58))))  severity failure; 
assert RAM3(59) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(59))))  severity failure; 
assert RAM3(60) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(60))))  severity failure; 
assert RAM3(61) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(61))))  severity failure; 
assert RAM3(62) = std_logic_vector(to_unsigned(162,8)) report  " TEST FALLITO (WORKING ZONE). Expected  162  found  " & integer'image(to_integer(unsigned(RAM3(62))))  severity failure; 
assert RAM3(63) = std_logic_vector(to_unsigned(38,8)) report  " TEST FALLITO (WORKING ZONE). Expected  38  found  " & integer'image(to_integer(unsigned(RAM3(63))))  severity failure; 
assert RAM3(64) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM3(64))))  severity failure; 
assert RAM3(65) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(65))))  severity failure; 
assert RAM3(66) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(66))))  severity failure; 
assert RAM3(67) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(67))))  severity failure; 
assert RAM3(68) = std_logic_vector(to_unsigned(196,8)) report  " TEST FALLITO (WORKING ZONE). Expected  196  found  " & integer'image(to_integer(unsigned(RAM3(68))))  severity failure; 
assert RAM3(69) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM3(69))))  severity failure; 
assert RAM3(70) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(70))))  severity failure; 
assert RAM3(71) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(71))))  severity failure; 
assert RAM3(72) = std_logic_vector(to_unsigned(50,8)) report  " TEST FALLITO (WORKING ZONE). Expected  50  found  " & integer'image(to_integer(unsigned(RAM3(72))))  severity failure; 
assert RAM3(73) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(73))))  severity failure; 
assert RAM3(74) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(74))))  severity failure; 
assert RAM3(75) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(75))))  severity failure; 
assert RAM3(76) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(76))))  severity failure; 
assert RAM3(77) = std_logic_vector(to_unsigned(60,8)) report  " TEST FALLITO (WORKING ZONE). Expected  60  found  " & integer'image(to_integer(unsigned(RAM3(77))))  severity failure; 
assert RAM3(78) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(78))))  severity failure; 
assert RAM3(79) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM3(79))))  severity failure; 
assert RAM3(80) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(80))))  severity failure; 
assert RAM3(81) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(81))))  severity failure; 
assert RAM3(82) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(82))))  severity failure; 
assert RAM3(83) = std_logic_vector(to_unsigned(246,8)) report  " TEST FALLITO (WORKING ZONE). Expected  246  found  " & integer'image(to_integer(unsigned(RAM3(83))))  severity failure; 
assert RAM3(84) = std_logic_vector(to_unsigned(20,8)) report  " TEST FALLITO (WORKING ZONE). Expected  20  found  " & integer'image(to_integer(unsigned(RAM3(84))))  severity failure; 
assert RAM3(85) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(85))))  severity failure; 
assert RAM3(86) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(86))))  severity failure; 
assert RAM3(87) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(87))))  severity failure; 
assert RAM3(88) = std_logic_vector(to_unsigned(250,8)) report  " TEST FALLITO (WORKING ZONE). Expected  250  found  " & integer'image(to_integer(unsigned(RAM3(88))))  severity failure; 
assert RAM3(89) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM3(89))))  severity failure; 
assert RAM3(90) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM3(90))))  severity failure; 
assert RAM3(91) = std_logic_vector(to_unsigned(218,8)) report  " TEST FALLITO (WORKING ZONE). Expected  218  found  " & integer'image(to_integer(unsigned(RAM3(91))))  severity failure; 


assert RAM4(93) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(93))))  severity failure; 
assert RAM4(94) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(94))))  severity failure; 
assert RAM4(95) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(95))))  severity failure; 
assert RAM4(96) = std_logic_vector(to_unsigned(100,8)) report  " TEST FALLITO (WORKING ZONE). Expected  100  found  " & integer'image(to_integer(unsigned(RAM4(96))))  severity failure; 
assert RAM4(97) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(97))))  severity failure; 
assert RAM4(98) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(98))))  severity failure; 
assert RAM4(99) = std_logic_vector(to_unsigned(170,8)) report  " TEST FALLITO (WORKING ZONE). Expected  170  found  " & integer'image(to_integer(unsigned(RAM4(99))))  severity failure; 
assert RAM4(100) = std_logic_vector(to_unsigned(162,8)) report  " TEST FALLITO (WORKING ZONE). Expected  162  found  " & integer'image(to_integer(unsigned(RAM4(100))))  severity failure; 
assert RAM4(101) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(101))))  severity failure; 
assert RAM4(102) = std_logic_vector(to_unsigned(230,8)) report  " TEST FALLITO (WORKING ZONE). Expected  230  found  " & integer'image(to_integer(unsigned(RAM4(102))))  severity failure; 
assert RAM4(103) = std_logic_vector(to_unsigned(50,8)) report  " TEST FALLITO (WORKING ZONE). Expected  50  found  " & integer'image(to_integer(unsigned(RAM4(103))))  severity failure; 
assert RAM4(104) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(104))))  severity failure; 
assert RAM4(105) = std_logic_vector(to_unsigned(74,8)) report  " TEST FALLITO (WORKING ZONE). Expected  74  found  " & integer'image(to_integer(unsigned(RAM4(105))))  severity failure; 
assert RAM4(106) = std_logic_vector(to_unsigned(34,8)) report  " TEST FALLITO (WORKING ZONE). Expected  34  found  " & integer'image(to_integer(unsigned(RAM4(106))))  severity failure; 
assert RAM4(107) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(107))))  severity failure; 
assert RAM4(108) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(108))))  severity failure; 
assert RAM4(109) = std_logic_vector(to_unsigned(174,8)) report  " TEST FALLITO (WORKING ZONE). Expected  174  found  " & integer'image(to_integer(unsigned(RAM4(109))))  severity failure; 
assert RAM4(110) = std_logic_vector(to_unsigned(158,8)) report  " TEST FALLITO (WORKING ZONE). Expected  158  found  " & integer'image(to_integer(unsigned(RAM4(110))))  severity failure; 
assert RAM4(111) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(111))))  severity failure; 
assert RAM4(112) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM4(112))))  severity failure; 
assert RAM4(113) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(113))))  severity failure; 
assert RAM4(114) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(114))))  severity failure; 
assert RAM4(115) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM4(115))))  severity failure; 
assert RAM4(116) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM4(116))))  severity failure; 
assert RAM4(117) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(117))))  severity failure; 
assert RAM4(118) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(118))))  severity failure; 
assert RAM4(119) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(119))))  severity failure; 
assert RAM4(120) = std_logic_vector(to_unsigned(216,8)) report  " TEST FALLITO (WORKING ZONE). Expected  216  found  " & integer'image(to_integer(unsigned(RAM4(120))))  severity failure; 
assert RAM4(121) = std_logic_vector(to_unsigned(106,8)) report  " TEST FALLITO (WORKING ZONE). Expected  106  found  " & integer'image(to_integer(unsigned(RAM4(121))))  severity failure; 
assert RAM4(122) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(122))))  severity failure; 
assert RAM4(123) = std_logic_vector(to_unsigned(236,8)) report  " TEST FALLITO (WORKING ZONE). Expected  236  found  " & integer'image(to_integer(unsigned(RAM4(123))))  severity failure; 
assert RAM4(124) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(124))))  severity failure; 
assert RAM4(125) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(125))))  severity failure; 
assert RAM4(126) = std_logic_vector(to_unsigned(16,8)) report  " TEST FALLITO (WORKING ZONE). Expected  16  found  " & integer'image(to_integer(unsigned(RAM4(126))))  severity failure; 
assert RAM4(127) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(127))))  severity failure; 
assert RAM4(128) = std_logic_vector(to_unsigned(142,8)) report  " TEST FALLITO (WORKING ZONE). Expected  142  found  " & integer'image(to_integer(unsigned(RAM4(128))))  severity failure; 
assert RAM4(129) = std_logic_vector(to_unsigned(2,8)) report  " TEST FALLITO (WORKING ZONE). Expected  2  found  " & integer'image(to_integer(unsigned(RAM4(129))))  severity failure; 
assert RAM4(130) = std_logic_vector(to_unsigned(142,8)) report  " TEST FALLITO (WORKING ZONE). Expected  142  found  " & integer'image(to_integer(unsigned(RAM4(130))))  severity failure; 
assert RAM4(131) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(131))))  severity failure; 
assert RAM4(132) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(132))))  severity failure; 
assert RAM4(133) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(133))))  severity failure; 
assert RAM4(134) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(134))))  severity failure; 
assert RAM4(135) = std_logic_vector(to_unsigned(110,8)) report  " TEST FALLITO (WORKING ZONE). Expected  110  found  " & integer'image(to_integer(unsigned(RAM4(135))))  severity failure; 
assert RAM4(136) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(136))))  severity failure; 
assert RAM4(137) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(137))))  severity failure; 
assert RAM4(138) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(138))))  severity failure; 
assert RAM4(139) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(139))))  severity failure; 
assert RAM4(140) = std_logic_vector(to_unsigned(52,8)) report  " TEST FALLITO (WORKING ZONE). Expected  52  found  " & integer'image(to_integer(unsigned(RAM4(140))))  severity failure; 
assert RAM4(141) = std_logic_vector(to_unsigned(126,8)) report  " TEST FALLITO (WORKING ZONE). Expected  126  found  " & integer'image(to_integer(unsigned(RAM4(141))))  severity failure; 
assert RAM4(142) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(142))))  severity failure; 
assert RAM4(143) = std_logic_vector(to_unsigned(182,8)) report  " TEST FALLITO (WORKING ZONE). Expected  182  found  " & integer'image(to_integer(unsigned(RAM4(143))))  severity failure; 
assert RAM4(144) = std_logic_vector(to_unsigned(28,8)) report  " TEST FALLITO (WORKING ZONE). Expected  28  found  " & integer'image(to_integer(unsigned(RAM4(144))))  severity failure; 
assert RAM4(145) = std_logic_vector(to_unsigned(204,8)) report  " TEST FALLITO (WORKING ZONE). Expected  204  found  " & integer'image(to_integer(unsigned(RAM4(145))))  severity failure; 
assert RAM4(146) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(146))))  severity failure; 
assert RAM4(147) = std_logic_vector(to_unsigned(222,8)) report  " TEST FALLITO (WORKING ZONE). Expected  222  found  " & integer'image(to_integer(unsigned(RAM4(147))))  severity failure; 
assert RAM4(148) = std_logic_vector(to_unsigned(60,8)) report  " TEST FALLITO (WORKING ZONE). Expected  60  found  " & integer'image(to_integer(unsigned(RAM4(148))))  severity failure; 
assert RAM4(149) = std_logic_vector(to_unsigned(186,8)) report  " TEST FALLITO (WORKING ZONE). Expected  186  found  " & integer'image(to_integer(unsigned(RAM4(149))))  severity failure; 
assert RAM4(150) = std_logic_vector(to_unsigned(104,8)) report  " TEST FALLITO (WORKING ZONE). Expected  104  found  " & integer'image(to_integer(unsigned(RAM4(150))))  severity failure; 
assert RAM4(151) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(151))))  severity failure; 
assert RAM4(152) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(152))))  severity failure; 
assert RAM4(153) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(153))))  severity failure; 
assert RAM4(154) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM4(154))))  severity failure; 
assert RAM4(155) = std_logic_vector(to_unsigned(164,8)) report  " TEST FALLITO (WORKING ZONE). Expected  164  found  " & integer'image(to_integer(unsigned(RAM4(155))))  severity failure; 
assert RAM4(156) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(156))))  severity failure; 
assert RAM4(157) = std_logic_vector(to_unsigned(18,8)) report  " TEST FALLITO (WORKING ZONE). Expected  18  found  " & integer'image(to_integer(unsigned(RAM4(157))))  severity failure; 
assert RAM4(158) = std_logic_vector(to_unsigned(138,8)) report  " TEST FALLITO (WORKING ZONE). Expected  138  found  " & integer'image(to_integer(unsigned(RAM4(158))))  severity failure; 
assert RAM4(159) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(159))))  severity failure; 
assert RAM4(160) = std_logic_vector(to_unsigned(20,8)) report  " TEST FALLITO (WORKING ZONE). Expected  20  found  " & integer'image(to_integer(unsigned(RAM4(160))))  severity failure; 
assert RAM4(161) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(161))))  severity failure; 
assert RAM4(162) = std_logic_vector(to_unsigned(202,8)) report  " TEST FALLITO (WORKING ZONE). Expected  202  found  " & integer'image(to_integer(unsigned(RAM4(162))))  severity failure; 
assert RAM4(163) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(163))))  severity failure; 
assert RAM4(164) = std_logic_vector(to_unsigned(142,8)) report  " TEST FALLITO (WORKING ZONE). Expected  142  found  " & integer'image(to_integer(unsigned(RAM4(164))))  severity failure; 
assert RAM4(165) = std_logic_vector(to_unsigned(46,8)) report  " TEST FALLITO (WORKING ZONE). Expected  46  found  " & integer'image(to_integer(unsigned(RAM4(165))))  severity failure; 
assert RAM4(166) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(166))))  severity failure; 
assert RAM4(167) = std_logic_vector(to_unsigned(76,8)) report  " TEST FALLITO (WORKING ZONE). Expected  76  found  " & integer'image(to_integer(unsigned(RAM4(167))))  severity failure; 
assert RAM4(168) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(168))))  severity failure; 
assert RAM4(169) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(169))))  severity failure; 
assert RAM4(170) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(170))))  severity failure; 
assert RAM4(171) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(171))))  severity failure; 
assert RAM4(172) = std_logic_vector(to_unsigned(34,8)) report  " TEST FALLITO (WORKING ZONE). Expected  34  found  " & integer'image(to_integer(unsigned(RAM4(172))))  severity failure; 
assert RAM4(173) = std_logic_vector(to_unsigned(222,8)) report  " TEST FALLITO (WORKING ZONE). Expected  222  found  " & integer'image(to_integer(unsigned(RAM4(173))))  severity failure; 
assert RAM4(174) = std_logic_vector(to_unsigned(160,8)) report  " TEST FALLITO (WORKING ZONE). Expected  160  found  " & integer'image(to_integer(unsigned(RAM4(174))))  severity failure; 
assert RAM4(175) = std_logic_vector(to_unsigned(64,8)) report  " TEST FALLITO (WORKING ZONE). Expected  64  found  " & integer'image(to_integer(unsigned(RAM4(175))))  severity failure; 
assert RAM4(176) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(176))))  severity failure; 
assert RAM4(177) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(177))))  severity failure; 
assert RAM4(178) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(178))))  severity failure; 
assert RAM4(179) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(179))))  severity failure; 
assert RAM4(180) = std_logic_vector(to_unsigned(144,8)) report  " TEST FALLITO (WORKING ZONE). Expected  144  found  " & integer'image(to_integer(unsigned(RAM4(180))))  severity failure; 
assert RAM4(181) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(181))))  severity failure; 
assert RAM4(182) = std_logic_vector(to_unsigned(250,8)) report  " TEST FALLITO (WORKING ZONE). Expected  250  found  " & integer'image(to_integer(unsigned(RAM4(182))))  severity failure; 
assert RAM4(183) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM4(183))))  severity failure; 


assert RAM5(22) = std_logic_vector(to_unsigned(84,8)) report  " TEST FALLITO (WORKING ZONE). Expected  84  found  " & integer'image(to_integer(unsigned(RAM5(22))))  severity failure; 
assert RAM5(23) = std_logic_vector(to_unsigned(82,8)) report  " TEST FALLITO (WORKING ZONE). Expected  82  found  " & integer'image(to_integer(unsigned(RAM5(23))))  severity failure; 
assert RAM5(24) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(24))))  severity failure; 
assert RAM5(25) = std_logic_vector(to_unsigned(222,8)) report  " TEST FALLITO (WORKING ZONE). Expected  222  found  " & integer'image(to_integer(unsigned(RAM5(25))))  severity failure; 
assert RAM5(26) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(26))))  severity failure; 
assert RAM5(27) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(27))))  severity failure; 
assert RAM5(28) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(28))))  severity failure; 
assert RAM5(29) = std_logic_vector(to_unsigned(180,8)) report  " TEST FALLITO (WORKING ZONE). Expected  180  found  " & integer'image(to_integer(unsigned(RAM5(29))))  severity failure; 
assert RAM5(30) = std_logic_vector(to_unsigned(116,8)) report  " TEST FALLITO (WORKING ZONE). Expected  116  found  " & integer'image(to_integer(unsigned(RAM5(30))))  severity failure; 
assert RAM5(31) = std_logic_vector(to_unsigned(134,8)) report  " TEST FALLITO (WORKING ZONE). Expected  134  found  " & integer'image(to_integer(unsigned(RAM5(31))))  severity failure; 
assert RAM5(32) = std_logic_vector(to_unsigned(226,8)) report  " TEST FALLITO (WORKING ZONE). Expected  226  found  " & integer'image(to_integer(unsigned(RAM5(32))))  severity failure; 
assert RAM5(33) = std_logic_vector(to_unsigned(56,8)) report  " TEST FALLITO (WORKING ZONE). Expected  56  found  " & integer'image(to_integer(unsigned(RAM5(33))))  severity failure; 
assert RAM5(34) = std_logic_vector(to_unsigned(210,8)) report  " TEST FALLITO (WORKING ZONE). Expected  210  found  " & integer'image(to_integer(unsigned(RAM5(34))))  severity failure; 
assert RAM5(35) = std_logic_vector(to_unsigned(152,8)) report  " TEST FALLITO (WORKING ZONE). Expected  152  found  " & integer'image(to_integer(unsigned(RAM5(35))))  severity failure; 
assert RAM5(36) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(36))))  severity failure; 
assert RAM5(37) = std_logic_vector(to_unsigned(156,8)) report  " TEST FALLITO (WORKING ZONE). Expected  156  found  " & integer'image(to_integer(unsigned(RAM5(37))))  severity failure; 
assert RAM5(38) = std_logic_vector(to_unsigned(130,8)) report  " TEST FALLITO (WORKING ZONE). Expected  130  found  " & integer'image(to_integer(unsigned(RAM5(38))))  severity failure; 
assert RAM5(39) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM5(39))))  severity failure; 
assert RAM5(40) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(40))))  severity failure; 
assert RAM5(41) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM5(41))))  severity failure; 


assert RAM6(35) = std_logic_vector(to_unsigned(244,8)) report  " TEST FALLITO (WORKING ZONE). Expected  244  found  " & integer'image(to_integer(unsigned(RAM6(35))))  severity failure; 
assert RAM6(36) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(36))))  severity failure; 
assert RAM6(37) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(37))))  severity failure; 
assert RAM6(38) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(38))))  severity failure; 
assert RAM6(39) = std_logic_vector(to_unsigned(226,8)) report  " TEST FALLITO (WORKING ZONE). Expected  226  found  " & integer'image(to_integer(unsigned(RAM6(39))))  severity failure; 
assert RAM6(40) = std_logic_vector(to_unsigned(2,8)) report  " TEST FALLITO (WORKING ZONE). Expected  2  found  " & integer'image(to_integer(unsigned(RAM6(40))))  severity failure; 
assert RAM6(41) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(41))))  severity failure; 
assert RAM6(42) = std_logic_vector(to_unsigned(50,8)) report  " TEST FALLITO (WORKING ZONE). Expected  50  found  " & integer'image(to_integer(unsigned(RAM6(42))))  severity failure; 
assert RAM6(43) = std_logic_vector(to_unsigned(254,8)) report  " TEST FALLITO (WORKING ZONE). Expected  254  found  " & integer'image(to_integer(unsigned(RAM6(43))))  severity failure; 
assert RAM6(44) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(44))))  severity failure; 
assert RAM6(45) = std_logic_vector(to_unsigned(138,8)) report  " TEST FALLITO (WORKING ZONE). Expected  138  found  " & integer'image(to_integer(unsigned(RAM6(45))))  severity failure; 
assert RAM6(46) = std_logic_vector(to_unsigned(12,8)) report  " TEST FALLITO (WORKING ZONE). Expected  12  found  " & integer'image(to_integer(unsigned(RAM6(46))))  severity failure; 
assert RAM6(47) = std_logic_vector(to_unsigned(122,8)) report  " TEST FALLITO (WORKING ZONE). Expected  122  found  " & integer'image(to_integer(unsigned(RAM6(47))))  severity failure; 
assert RAM6(48) = std_logic_vector(to_unsigned(124,8)) report  " TEST FALLITO (WORKING ZONE). Expected  124  found  " & integer'image(to_integer(unsigned(RAM6(48))))  severity failure; 
assert RAM6(49) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(49))))  severity failure; 
assert RAM6(50) = std_logic_vector(to_unsigned(120,8)) report  " TEST FALLITO (WORKING ZONE). Expected  120  found  " & integer'image(to_integer(unsigned(RAM6(50))))  severity failure; 
assert RAM6(51) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(51))))  severity failure; 
assert RAM6(52) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(52))))  severity failure; 
assert RAM6(53) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(53))))  severity failure; 
assert RAM6(54) = std_logic_vector(to_unsigned(32,8)) report  " TEST FALLITO (WORKING ZONE). Expected  32  found  " & integer'image(to_integer(unsigned(RAM6(54))))  severity failure; 
assert RAM6(55) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(55))))  severity failure; 
assert RAM6(56) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(56))))  severity failure; 
assert RAM6(57) = std_logic_vector(to_unsigned(190,8)) report  " TEST FALLITO (WORKING ZONE). Expected  190  found  " & integer'image(to_integer(unsigned(RAM6(57))))  severity failure; 
assert RAM6(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(58))))  severity failure; 
assert RAM6(59) = std_logic_vector(to_unsigned(128,8)) report  " TEST FALLITO (WORKING ZONE). Expected  128  found  " & integer'image(to_integer(unsigned(RAM6(59))))  severity failure; 
assert RAM6(60) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(60))))  severity failure; 
assert RAM6(61) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(61))))  severity failure; 
assert RAM6(62) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM6(62))))  severity failure; 
assert RAM6(63) = std_logic_vector(to_unsigned(110,8)) report  " TEST FALLITO (WORKING ZONE). Expected  110  found  " & integer'image(to_integer(unsigned(RAM6(63))))  severity failure; 
assert RAM6(64) = std_logic_vector(to_unsigned(26,8)) report  " TEST FALLITO (WORKING ZONE). Expected  26  found  " & integer'image(to_integer(unsigned(RAM6(64))))  severity failure; 
assert RAM6(65) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(65))))  severity failure; 
assert RAM6(66) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(66))))  severity failure; 
assert RAM6(67) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM6(67))))  severity failure; 


assert RAM7(58) = std_logic_vector(to_unsigned(118,8)) report  " TEST FALLITO (WORKING ZONE). Expected  118  found  " & integer'image(to_integer(unsigned(RAM7(58))))  severity failure; 
assert RAM7(59) = std_logic_vector(to_unsigned(84,8)) report  " TEST FALLITO (WORKING ZONE). Expected  84  found  " & integer'image(to_integer(unsigned(RAM7(59))))  severity failure; 
assert RAM7(60) = std_logic_vector(to_unsigned(74,8)) report  " TEST FALLITO (WORKING ZONE). Expected  74  found  " & integer'image(to_integer(unsigned(RAM7(60))))  severity failure; 
assert RAM7(61) = std_logic_vector(to_unsigned(178,8)) report  " TEST FALLITO (WORKING ZONE). Expected  178  found  " & integer'image(to_integer(unsigned(RAM7(61))))  severity failure; 
assert RAM7(62) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(62))))  severity failure; 
assert RAM7(63) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(63))))  severity failure; 
assert RAM7(64) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(64))))  severity failure; 
assert RAM7(65) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(65))))  severity failure; 
assert RAM7(66) = std_logic_vector(to_unsigned(110,8)) report  " TEST FALLITO (WORKING ZONE). Expected  110  found  " & integer'image(to_integer(unsigned(RAM7(66))))  severity failure; 
assert RAM7(67) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(67))))  severity failure; 
assert RAM7(68) = std_logic_vector(to_unsigned(174,8)) report  " TEST FALLITO (WORKING ZONE). Expected  174  found  " & integer'image(to_integer(unsigned(RAM7(68))))  severity failure; 
assert RAM7(69) = std_logic_vector(to_unsigned(242,8)) report  " TEST FALLITO (WORKING ZONE). Expected  242  found  " & integer'image(to_integer(unsigned(RAM7(69))))  severity failure; 
assert RAM7(70) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(70))))  severity failure; 
assert RAM7(71) = std_logic_vector(to_unsigned(98,8)) report  " TEST FALLITO (WORKING ZONE). Expected  98  found  " & integer'image(to_integer(unsigned(RAM7(71))))  severity failure; 
assert RAM7(72) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM7(72))))  severity failure; 
assert RAM7(73) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(73))))  severity failure; 
assert RAM7(74) = std_logic_vector(to_unsigned(84,8)) report  " TEST FALLITO (WORKING ZONE). Expected  84  found  " & integer'image(to_integer(unsigned(RAM7(74))))  severity failure; 
assert RAM7(75) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(75))))  severity failure; 
assert RAM7(76) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM7(76))))  severity failure; 
assert RAM7(77) = std_logic_vector(to_unsigned(44,8)) report  " TEST FALLITO (WORKING ZONE). Expected  44  found  " & integer'image(to_integer(unsigned(RAM7(77))))  severity failure; 
assert RAM7(78) = std_logic_vector(to_unsigned(114,8)) report  " TEST FALLITO (WORKING ZONE). Expected  114  found  " & integer'image(to_integer(unsigned(RAM7(78))))  severity failure; 
assert RAM7(79) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(79))))  severity failure; 
assert RAM7(80) = std_logic_vector(to_unsigned(10,8)) report  " TEST FALLITO (WORKING ZONE). Expected  10  found  " & integer'image(to_integer(unsigned(RAM7(80))))  severity failure; 
assert RAM7(81) = std_logic_vector(to_unsigned(124,8)) report  " TEST FALLITO (WORKING ZONE). Expected  124  found  " & integer'image(to_integer(unsigned(RAM7(81))))  severity failure; 
assert RAM7(82) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(82))))  severity failure; 
assert RAM7(83) = std_logic_vector(to_unsigned(46,8)) report  " TEST FALLITO (WORKING ZONE). Expected  46  found  " & integer'image(to_integer(unsigned(RAM7(83))))  severity failure; 
assert RAM7(84) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(84))))  severity failure; 
assert RAM7(85) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(85))))  severity failure; 
assert RAM7(86) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(86))))  severity failure; 
assert RAM7(87) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(87))))  severity failure; 
assert RAM7(88) = std_logic_vector(to_unsigned(66,8)) report  " TEST FALLITO (WORKING ZONE). Expected  66  found  " & integer'image(to_integer(unsigned(RAM7(88))))  severity failure; 
assert RAM7(89) = std_logic_vector(to_unsigned(46,8)) report  " TEST FALLITO (WORKING ZONE). Expected  46  found  " & integer'image(to_integer(unsigned(RAM7(89))))  severity failure; 
assert RAM7(90) = std_logic_vector(to_unsigned(76,8)) report  " TEST FALLITO (WORKING ZONE). Expected  76  found  " & integer'image(to_integer(unsigned(RAM7(90))))  severity failure; 
assert RAM7(91) = std_logic_vector(to_unsigned(140,8)) report  " TEST FALLITO (WORKING ZONE). Expected  140  found  " & integer'image(to_integer(unsigned(RAM7(91))))  severity failure; 
assert RAM7(92) = std_logic_vector(to_unsigned(224,8)) report  " TEST FALLITO (WORKING ZONE). Expected  224  found  " & integer'image(to_integer(unsigned(RAM7(92))))  severity failure; 
assert RAM7(93) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(93))))  severity failure; 
assert RAM7(94) = std_logic_vector(to_unsigned(118,8)) report  " TEST FALLITO (WORKING ZONE). Expected  118  found  " & integer'image(to_integer(unsigned(RAM7(94))))  severity failure; 
assert RAM7(95) = std_logic_vector(to_unsigned(40,8)) report  " TEST FALLITO (WORKING ZONE). Expected  40  found  " & integer'image(to_integer(unsigned(RAM7(95))))  severity failure; 
assert RAM7(96) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(96))))  severity failure; 
assert RAM7(97) = std_logic_vector(to_unsigned(230,8)) report  " TEST FALLITO (WORKING ZONE). Expected  230  found  " & integer'image(to_integer(unsigned(RAM7(97))))  severity failure; 
assert RAM7(98) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(98))))  severity failure; 
assert RAM7(99) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(99))))  severity failure; 
assert RAM7(100) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(100))))  severity failure; 
assert RAM7(101) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(101))))  severity failure; 
assert RAM7(102) = std_logic_vector(to_unsigned(46,8)) report  " TEST FALLITO (WORKING ZONE). Expected  46  found  " & integer'image(to_integer(unsigned(RAM7(102))))  severity failure; 
assert RAM7(103) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(103))))  severity failure; 
assert RAM7(104) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM7(104))))  severity failure; 
assert RAM7(105) = std_logic_vector(to_unsigned(130,8)) report  " TEST FALLITO (WORKING ZONE). Expected  130  found  " & integer'image(to_integer(unsigned(RAM7(105))))  severity failure; 
assert RAM7(106) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(106))))  severity failure; 
assert RAM7(107) = std_logic_vector(to_unsigned(58,8)) report  " TEST FALLITO (WORKING ZONE). Expected  58  found  " & integer'image(to_integer(unsigned(RAM7(107))))  severity failure; 
assert RAM7(108) = std_logic_vector(to_unsigned(174,8)) report  " TEST FALLITO (WORKING ZONE). Expected  174  found  " & integer'image(to_integer(unsigned(RAM7(108))))  severity failure; 
assert RAM7(109) = std_logic_vector(to_unsigned(52,8)) report  " TEST FALLITO (WORKING ZONE). Expected  52  found  " & integer'image(to_integer(unsigned(RAM7(109))))  severity failure; 
assert RAM7(110) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(110))))  severity failure; 
assert RAM7(111) = std_logic_vector(to_unsigned(184,8)) report  " TEST FALLITO (WORKING ZONE). Expected  184  found  " & integer'image(to_integer(unsigned(RAM7(111))))  severity failure; 
assert RAM7(112) = std_logic_vector(to_unsigned(178,8)) report  " TEST FALLITO (WORKING ZONE). Expected  178  found  " & integer'image(to_integer(unsigned(RAM7(112))))  severity failure; 
assert RAM7(113) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM7(113))))  severity failure; 


assert RAM8(32) = std_logic_vector(to_unsigned(108,8)) report  " TEST FALLITO (WORKING ZONE). Expected  108  found  " & integer'image(to_integer(unsigned(RAM8(32))))  severity failure; 
assert RAM8(33) = std_logic_vector(to_unsigned(124,8)) report  " TEST FALLITO (WORKING ZONE). Expected  124  found  " & integer'image(to_integer(unsigned(RAM8(33))))  severity failure; 
assert RAM8(34) = std_logic_vector(to_unsigned(56,8)) report  " TEST FALLITO (WORKING ZONE). Expected  56  found  " & integer'image(to_integer(unsigned(RAM8(34))))  severity failure; 
assert RAM8(35) = std_logic_vector(to_unsigned(176,8)) report  " TEST FALLITO (WORKING ZONE). Expected  176  found  " & integer'image(to_integer(unsigned(RAM8(35))))  severity failure; 
assert RAM8(36) = std_logic_vector(to_unsigned(172,8)) report  " TEST FALLITO (WORKING ZONE). Expected  172  found  " & integer'image(to_integer(unsigned(RAM8(36))))  severity failure; 
assert RAM8(37) = std_logic_vector(to_unsigned(134,8)) report  " TEST FALLITO (WORKING ZONE). Expected  134  found  " & integer'image(to_integer(unsigned(RAM8(37))))  severity failure; 
assert RAM8(38) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(38))))  severity failure; 
assert RAM8(39) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(39))))  severity failure; 
assert RAM8(40) = std_logic_vector(to_unsigned(48,8)) report  " TEST FALLITO (WORKING ZONE). Expected  48  found  " & integer'image(to_integer(unsigned(RAM8(40))))  severity failure; 
assert RAM8(41) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(41))))  severity failure; 
assert RAM8(42) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(42))))  severity failure; 
assert RAM8(43) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(43))))  severity failure; 
assert RAM8(44) = std_logic_vector(to_unsigned(154,8)) report  " TEST FALLITO (WORKING ZONE). Expected  154  found  " & integer'image(to_integer(unsigned(RAM8(44))))  severity failure; 
assert RAM8(45) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(45))))  severity failure; 
assert RAM8(46) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(46))))  severity failure; 
assert RAM8(47) = std_logic_vector(to_unsigned(114,8)) report  " TEST FALLITO (WORKING ZONE). Expected  114  found  " & integer'image(to_integer(unsigned(RAM8(47))))  severity failure; 
assert RAM8(48) = std_logic_vector(to_unsigned(172,8)) report  " TEST FALLITO (WORKING ZONE). Expected  172  found  " & integer'image(to_integer(unsigned(RAM8(48))))  severity failure; 
assert RAM8(49) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(49))))  severity failure; 
assert RAM8(50) = std_logic_vector(to_unsigned(74,8)) report  " TEST FALLITO (WORKING ZONE). Expected  74  found  " & integer'image(to_integer(unsigned(RAM8(50))))  severity failure; 
assert RAM8(51) = std_logic_vector(to_unsigned(232,8)) report  " TEST FALLITO (WORKING ZONE). Expected  232  found  " & integer'image(to_integer(unsigned(RAM8(51))))  severity failure; 
assert RAM8(52) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(52))))  severity failure; 
assert RAM8(53) = std_logic_vector(to_unsigned(12,8)) report  " TEST FALLITO (WORKING ZONE). Expected  12  found  " & integer'image(to_integer(unsigned(RAM8(53))))  severity failure; 
assert RAM8(54) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(54))))  severity failure; 
assert RAM8(55) = std_logic_vector(to_unsigned(122,8)) report  " TEST FALLITO (WORKING ZONE). Expected  122  found  " & integer'image(to_integer(unsigned(RAM8(55))))  severity failure; 
assert RAM8(56) = std_logic_vector(to_unsigned(66,8)) report  " TEST FALLITO (WORKING ZONE). Expected  66  found  " & integer'image(to_integer(unsigned(RAM8(56))))  severity failure; 
assert RAM8(57) = std_logic_vector(to_unsigned(174,8)) report  " TEST FALLITO (WORKING ZONE). Expected  174  found  " & integer'image(to_integer(unsigned(RAM8(57))))  severity failure; 
assert RAM8(58) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM8(58))))  severity failure; 
assert RAM8(59) = std_logic_vector(to_unsigned(244,8)) report  " TEST FALLITO (WORKING ZONE). Expected  244  found  " & integer'image(to_integer(unsigned(RAM8(59))))  severity failure; 
assert RAM8(60) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM8(60))))  severity failure; 
assert RAM8(61) = std_logic_vector(to_unsigned(26,8)) report  " TEST FALLITO (WORKING ZONE). Expected  26  found  " & integer'image(to_integer(unsigned(RAM8(61))))  severity failure; 


assert RAM9(20) = std_logic_vector(to_unsigned(202,8)) report  " TEST FALLITO (WORKING ZONE). Expected  202  found  " & integer'image(to_integer(unsigned(RAM9(20))))  severity failure; 
assert RAM9(21) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(21))))  severity failure; 
assert RAM9(22) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(22))))  severity failure; 
assert RAM9(23) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(23))))  severity failure; 
assert RAM9(24) = std_logic_vector(to_unsigned(108,8)) report  " TEST FALLITO (WORKING ZONE). Expected  108  found  " & integer'image(to_integer(unsigned(RAM9(24))))  severity failure; 
assert RAM9(25) = std_logic_vector(to_unsigned(212,8)) report  " TEST FALLITO (WORKING ZONE). Expected  212  found  " & integer'image(to_integer(unsigned(RAM9(25))))  severity failure; 
assert RAM9(26) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(26))))  severity failure; 
assert RAM9(27) = std_logic_vector(to_unsigned(192,8)) report  " TEST FALLITO (WORKING ZONE). Expected  192  found  " & integer'image(to_integer(unsigned(RAM9(27))))  severity failure; 
assert RAM9(28) = std_logic_vector(to_unsigned(172,8)) report  " TEST FALLITO (WORKING ZONE). Expected  172  found  " & integer'image(to_integer(unsigned(RAM9(28))))  severity failure; 
assert RAM9(29) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(29))))  severity failure; 
assert RAM9(30) = std_logic_vector(to_unsigned(50,8)) report  " TEST FALLITO (WORKING ZONE). Expected  50  found  " & integer'image(to_integer(unsigned(RAM9(30))))  severity failure; 
assert RAM9(31) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(31))))  severity failure; 
assert RAM9(32) = std_logic_vector(to_unsigned(242,8)) report  " TEST FALLITO (WORKING ZONE). Expected  242  found  " & integer'image(to_integer(unsigned(RAM9(32))))  severity failure; 
assert RAM9(33) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(33))))  severity failure; 
assert RAM9(34) = std_logic_vector(to_unsigned(0,8)) report  " TEST FALLITO (WORKING ZONE). Expected  0  found  " & integer'image(to_integer(unsigned(RAM9(34))))  severity failure; 
assert RAM9(35) = std_logic_vector(to_unsigned(255,8)) report  " TEST FALLITO (WORKING ZONE). Expected  255  found  " & integer'image(to_integer(unsigned(RAM9(35))))  severity failure; 
assert RAM9(36) = std_logic_vector(to_unsigned(220,8)) report  " TEST FALLITO (WORKING ZONE). Expected  220  found  " & integer'image(to_integer(unsigned(RAM9(36))))  severity failure; 
assert RAM9(37) = std_logic_vector(to_unsigned(112,8)) report  " TEST FALLITO (WORKING ZONE). Expected  112  found  " & integer'image(to_integer(unsigned(RAM9(37))))  severity failure; 



assert false report " Simulation Ended! TEST PASSATO " severity failure;

end process test;
end projecttb;