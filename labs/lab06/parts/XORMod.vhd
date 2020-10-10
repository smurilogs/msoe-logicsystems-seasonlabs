-- XORMod.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date:
-- Description: Module that uses four XOR logic gates to operate four pair of bits

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity XORMod is
	port(
	        -- The inputs and outputs needed
			  A : in  std_logic_vector(3 downto 0);
			  B : in  std_logic_vector(3 downto 0);
           C : out std_logic_vector(3 downto 0)
	);
end XORMod;

-- Architecture description
architecture Behavior of XORMod is
begin

	C <= ((not A) and B) or (A and (not B));
	
end Behavior;
