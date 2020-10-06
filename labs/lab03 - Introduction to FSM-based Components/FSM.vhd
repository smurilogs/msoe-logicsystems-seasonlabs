-- FSM
-- with 50MHZ to 1Hz
-- debounce switch to start
-- HTran for lecture and lab_w4 practice only
-- modified - KWidder, 9/27/14 for DE1, etc.
-- tested – Sergio Murilo Gonzaga Silva, 10/12/2014 – DE1 Board test
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
entity moore_fsm_1 is
port
(
	CLOCK_50 : in STD_LOGIC;	
	      SW : in STD_LOGIC_VECTOR(9 downto 0);  -- raw switch input to start state transition
	    LEDR : out STD_LOGIC_VECTOR(9 downto 0)  -- LEDs for output indication
);
end moore_fsm_1;

--------------------------
architecture description OF moore_fsm_1 is
--
	constant	max   : 	INTEGER:= 500000;
	constant	half  : 	INTEGER:= max/2;
	constant	max1  : 	INTEGER:= 100;
	constant	half1 : 	INTEGER:= max1/2;
--
	signal q : STD_LOGIC_VECTOR(2 downto 0);-- system state
	signal z : STD_LOGIC_VECTOR(1 downto 0); -- system output
--
	signal 	count, count1 : INTEGER RANGE 0 to max;
	signal	clk_one, clk_onehund: STD_LOGIC;        -- slow clocks 
	signal  d_sw : STD_LOGIC;                       -- de-bounced switch to start state transition
	signal 	shift_pb : STD_LOGIC_VECTOR(3 downto 0);
--
	type  state_name is (s0,s1,s2,s3,s4,s5,s6,s7);
	signal state : state_name;
--
begin
-- frequency divider from 50 MHz to 100 HZ (from viewing display)
	process (CLOCK_50)
	begin
		if (CLOCK_50'event and CLOCK_50 = '1') then
            if (count < max) then
                count <= count+1;
            else
                count <= 0;
            end if;
            if (count <= half) then
                clk_onehund <= '0';
            else
                clk_onehund <= '1';
            end if;
		end if;
	end process; 

-- frequency divider from 100 HZ to 1 HZ (for viewing display)
	process (clk_onehund)
	begin
		if (clk_onehund'event and clk_onehund = '1') then
            if (count1 < max1) then
                count1 <= count1+1;
            else
                count1 <= 0;
            end if;
            if (count1 <= half1) then
                clk_one <= '0';
            else
                clk_one <= '1';
            end if;
		end if;
	end process; 

------------------------

-- debounce switch
	process (clk_onehund)
	begin
		if (clk_onehund'event and clk_onehund ='1') then
			shift_pb(2 downto 0) <= shift_pb(3 downto 1);
			         shift_pb(3) <= NOT SW(0);
		end if;

        --check to see if the switch still l bounce
		if shift_pb(3 downto 0) ="0000" then
			d_sw <= '1';
		else
			d_sw <= '0';
		end if;
    end process;
    
------------------------

-- model of FSM
-- state transition
	process (clk_one, d_sw)
	begin
		if (d_sw='1') then
			state <= s0;
		elsif (clk_one'event and clk_one ='1') then
			case state is
				when s0 => state <= s1;
				when s1 => state <= s2;
				when s2 => state <= s3;
				when s3 => state <= s4;
				when s4 => state <= s5;
				when s5 => state <= s6;
				when s6 => state <= s7;
				when s7 => state <= s0;
			end case;
		end if;
	end process;
--
-- output
	with state select
		z<= "00" when s0,
			"01" when s1,
			"10" when s2,
			"11" when s3,
			"10" when s4,
			"01" when s5,
			"00" when s6,
			"11" when s7;
--
-- display state assignment for verification and debug
	with state select
		q<= "000" when s0,
			"001" when s1,
			"010" when s2,
			"011" when s3,
			"100" when s4,
			"101" when s5,
			"110" when s6,
			"111" when s7;	
			
	LEDR(9 downto 7) <= q; -- state output indication
	LEDR(1 downto 0) <= z; -- output indication
end description;
