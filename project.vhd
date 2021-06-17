LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY project_reti_logiche IS
	PORT (
		i_clk : IN STD_LOGIC;
		i_rst : IN STD_LOGIC;
		i_start : IN STD_LOGIC;
		i_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		o_done : OUT STD_LOGIC;
		o_en : OUT STD_LOGIC;
		o_we : OUT STD_LOGIC;
		o_data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END project_reti_logiche;

ARCHITECTURE Behavioral OF project_reti_logiche IS
	TYPE state_type IS (IDLE, ASK_CONST, WAIT_RAM, GET_CONST, ASK_CURR,
		GET_CURR, CALC, WRITE_OUT, DONE, MULT, WAIT_MULT);

	SIGNAL state_reg, state_next : state_type;
	SIGNAL o_done_next, o_en_next, o_we_next : STD_LOGIC := '0';
	SIGNAL o_data_next : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL o_address_next : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL got_col_reg, got_col_next : BOOLEAN := false;
	SIGNAL got_row_reg, got_row_next : BOOLEAN := false;
	SIGNAL done_mm_reg, done_mm_next : BOOLEAN := false;
	SIGNAL row_reg, row_next : INTEGER RANGE 0 TO 128 := 0;
	SIGNAL col_reg, col_next : INTEGER RANGE 0 TO 128 := 0;
	SIGNAL max_reg, max_next : INTEGER RANGE 0 TO 255 := 0;
	SIGNAL min_reg, min_next : INTEGER RANGE 0 TO 255 := 255;
	SIGNAL pixel_reg, pixel_next : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL address_reg, address_next : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000001";

	SIGNAL index_reg, index_next : INTEGER RANGE 0 TO 16384 := 0;
	SIGNAL i_reg, i_next : INTEGER RANGE 0 TO 128 := 1;

BEGIN
	PROCESS (i_clk, i_rst)
	BEGIN
		IF (i_rst = '1') THEN
			state_reg <= IDLE;
			got_col_reg <= false;
			got_row_reg <= false;
			done_mm_reg <= false;
			row_reg <= 0;
			col_reg <= 0;
			max_reg <= 0;
			min_reg <= 255;
			pixel_reg <= "00000000";
			address_reg <= "0000000000000001";

			index_reg <= 0;
			i_reg <= 1;
		ELSIF (rising_edge(i_clk)) THEN
			o_done <= o_done_next;
			o_en <= o_en_next;
			o_we <= o_we_next;
			o_data <= o_data_next;
			o_address <= o_address_next;
			state_reg <= state_next;
			got_col_reg <= got_col_next;
			got_row_reg <= got_row_next;
			done_mm_reg <= done_mm_next;
			row_reg <= row_next;
			col_reg <= col_next;
			max_reg <= max_next;
			min_reg <= min_next;
			pixel_reg <= pixel_next;
			address_reg <= address_next;

			index_reg <= index_next;
			i_reg <= i_next;
		END IF;
	END PROCESS;

	PROCESS (state_reg, i_data, i_start, got_col_reg, got_row_reg, done_mm_reg, row_reg, col_reg, max_reg, min_reg, pixel_reg, address_reg, index_reg, i_reg)
		VARIABLE delta : INTEGER RANGE 0 TO 255 := 0;
		VARIABLE shift : INTEGER RANGE 0 TO 8 := 0;
		VARIABLE intermediate : unsigned(15 DOWNTO 0) := "0000000000000000";

	BEGIN
		o_done_next <= '0';
		o_en_next <= '0';
		o_we_next <= '0';
		o_data_next <= "00000000";
		o_address_next <= "0000000000000001";

		state_next <= state_reg;
		got_col_next <= got_col_reg;
		got_row_next <= got_row_reg;
		done_mm_next <= done_mm_reg;
		row_next <= row_reg;
		col_next <= col_reg;
		max_next <= max_reg;
		min_next <= min_reg;
		pixel_next <= pixel_reg;
		address_next <= address_reg;

		index_next <= index_reg;
		i_next <= i_reg;

		CASE state_reg IS
			WHEN IDLE =>
				IF (i_start = '1') THEN
					state_next <= ASK_CONST;
				END IF;

			WHEN ASK_CONST =>
				o_en_next <= '1';
				o_we_next <= '0';
				IF (NOT got_col_reg) THEN
					o_address_next <= "0000000000000000";
				ELSIF (NOT got_row_reg) THEN
					o_address_next <= "0000000000000001";
				END IF;
				state_next <= WAIT_RAM;

			WHEN WAIT_RAM =>
				IF (got_col_reg AND got_row_reg) THEN
					state_next <= GET_CURR;
				ELSE
					state_next <= GET_CONST;
				END IF;

			WHEN GET_CONST =>
				IF (NOT got_col_reg) THEN
					col_next <= conv_integer(i_data);
					got_col_next <= true;
					state_next <= ASK_CONST;
				ELSE
					row_next <= conv_integer(i_data);
					got_row_next <= true;
					state_next <= MULT;
				END IF;

			WHEN MULT =>
				IF (col_reg = 0 OR row_reg = 0) THEN
					o_done_next <= '1';
					state_next <= DONE;
				ELSE
					index_next <= index_reg + col_reg;
					i_next <= i_reg + 1;
					state_next <= WAIT_MULT;
				END IF;

			WHEN WAIT_MULT =>
				IF (i_reg = row_reg + 1) THEN
					state_next <= ASK_CURR;
				ELSE
					state_next <= MULT;
				END IF;
			WHEN ASK_CURR =>
				o_address_next <= address_reg + "0000000000000001";
				address_next <= address_reg + "0000000000000001";
				o_en_next <= '1';
				o_we_next <= '0';
				state_next <= WAIT_RAM;

			WHEN GET_CURR =>
				pixel_next <= i_data;
				state_next <= CALC;

			WHEN CALC =>
				IF (NOT done_mm_reg) THEN
					IF (conv_integer(pixel_reg) > max_reg) THEN
						max_next <= conv_integer(pixel_reg);
					END IF;
					IF (conv_integer(pixel_reg) < min_reg) THEN
						min_next <= conv_integer(pixel_reg);
					END IF;
					IF (address_reg = STD_LOGIC_VECTOR(to_unsigned(index_reg, 16)) + "0000000000000001") THEN
						done_mm_next <= true;
						o_address_next <= "0000000000000001";
						address_next <= "0000000000000001";
					END IF;
					state_next <= ASK_CURR;
				ELSE
					delta := max_reg - min_reg;
					CASE delta IS
						WHEN 0 =>
							shift := 8;
						WHEN 1 TO 2 =>
							shift := 7;
						WHEN 3 TO 6 =>
							shift := 6;
						WHEN 7 TO 14 =>
							shift := 5;
						WHEN 15 TO 30 =>
							shift := 4;
						WHEN 31 TO 62 =>
							shift := 3;
						WHEN 63 TO 126 =>
							shift := 2;
						WHEN 127 TO 254 =>
							shift := 1;
						WHEN OTHERS =>
							shift := 0;
					END CASE;
					intermediate := shift_left(to_unsigned((conv_integer(pixel_reg) - min_reg), 16), shift);
					IF (to_integer(intermediate) > 255) THEN
						o_data_next <= STD_LOGIC_VECTOR(to_unsigned(255, 8));
					ELSE
						o_data_next <= STD_LOGIC_VECTOR(to_unsigned(to_integer(intermediate), 8));
					END IF;
					o_en_next <= '1';
					o_we_next <= '1';
					o_address_next <= address_reg + STD_LOGIC_VECTOR(to_unsigned(index_reg, 16));
					state_next <= WRITE_OUT;
				END IF;

			WHEN WRITE_OUT =>
				IF (address_reg = STD_LOGIC_VECTOR(to_unsigned(index_reg, 16)) + "0000000000000001") THEN
					state_next <= DONE;
					o_done_next <= '1';
				ELSE
					state_next <= ASK_CURR;
				END IF;

			WHEN DONE =>
				IF (i_start = '0') THEN
					state_next <= IDLE;
					got_col_next <= false;
					got_row_next <= false;
					done_mm_next <= false;
					row_next <= 0;
					col_next <= 0;
					max_next <= 0;
					min_next <= 255;
					pixel_next <= "00000000";
					address_next <= "0000000000000001";

					index_next <= 0;
					i_next <= 1;
				END IF;

		END CASE;
	END PROCESS;
END Behavioral;