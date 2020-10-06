-- ADDSUBMod.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date:
-- Description: Adder/Subtractor of 4 bits

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity ADDSUBMod is
    port(
		      -- Input signals of the 4-bit adder/subtractor unit 
			     A : in std_logic_vector(3 downto 0);
			     B : in std_logic_vector(3 downto 0);
			   SUB : in std_logic;
			
			   -- Output signals of the 4-bit adder/subtractor unit	 
			      C : out std_logic_vector(3 downto 0);
			   COUT : out std_logic
    );
end ADDSUBMod;

-- Architecture description
architecture Behavior of ADDSUBMod is

	 -- "Wires" signals to make easier internal wiring between components
	 signal wa, wCOUTa, wb, wCOUTb, wc, wCOUTc, wd : std_logic; 
    
	 -- Declaration of use of the component FullAdder
    component FullAdder
	 port(
				A, B, CIN  :  in std_logic;
				   C, COUT : out std_logic
	 );
    end component;
	 
begin

	 -- Logic of a 4-bit Adder/Subtractor 
	 
	 -- Instantiation and wiring of the four Full Adders needed
    FAa : FullAdder port map (A(0), wa,    SUB, C(0), wCOUTa);
    FAb : FullAdder port map (A(1), wb, wCOUTa, C(1), wCOUTb);
    FAc : FullAdder port map (A(2), wc, wCOUTb, C(2), wCOUTc);
    FAd : FullAdder port map (A(3), wd, wCOUTc, C(3), COUT);
	 
	 wa <= ((not B(0)) and SUB) or (B(0) and (not SUB));
	 wb <= ((not B(1)) and SUB) or (B(1) and (not SUB));
	 wc <= ((not B(2)) and SUB) or (B(2) and (not SUB));
	 wd <= ((not B(3)) and SUB) or (B(3) and (not SUB));
	 
end Behavior;