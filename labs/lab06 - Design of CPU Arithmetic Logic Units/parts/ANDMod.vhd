-- ANDMod.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date:
-- Description: Module that uses four AND logic gates to operate four pair of bits

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity ANDMod is
	port(
	        -- The inputs and outputs needed
			  A : in  std_logic_vector(3 downto 0);
			  B : in  std_logic_vector(3 downto 0);
           C : out std_logic_vector(3 downto 0)
	);
end ANDMod;

-- Architecture description
architecture Behavior of ANDMod is
begin

	C <= A and B;
	
end Behavior;

