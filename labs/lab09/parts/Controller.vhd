-- Controller.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date: 11/02/2012
-- Description: Controller assembly

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity Controller is
	port(
				-- Inputs and outputs needed to this Controller
				CLK : in std_logic;
				 ST : in std_logic;
				 OP : in std_logic_vector(2 downto 0);
				 
				 EN : out std_logic_vector(3 downto 0);
				 DN : out std_logic
	);
end Controller;

-- Architecture description
architecture Behavior of Controller is

	-- Declaration of the type state
	type state is (A, B, C, D, E);
	
	-- Signal to save the current state
	signal currentState : state := A;
	
begin

	-- Process to manage transactions between  all states designed for this system
	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
			case (currentState) is
				when A =>
					if (ST = '0') then
						currentState <= A;
					else
						currentState <= B;						
					end if;
				when B =>
					if (OP(2) = '1') then
						if (OP(0) = '1') then
							currentState <= C;
						else
							currentState <= D;
						end if;
					else
						currentState <= D;
					end if;
				when C =>
					currentState <= E;
				when D =>
					currentState <= E;
				when E =>
					currentState <= A;
			end case;
		end if;
	end process;

	-- Determines the enable signal to the DataPath based on the current state of the system
	EN <= "0000" when (currentState = A) else
		  "0010" when (currentState = B) else
		  "0100" when (currentState = C) else
		  "0101" when (currentState = D) else	
		  "1000";

	-- Determines when signal DONE will be shown based on the current state of the system
	DN <= '1' when (currentState = A) else
		  '0';
			
end Behavior;
	