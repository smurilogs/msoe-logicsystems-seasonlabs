-- FSTruthTable.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (F function - Truth Table)
-- date: 09/27/2014
-- Description: Function F in truth table method

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity FTruthTable is
port(
        -- Assignments from DE1 board switches 
	   SW : in std_logic_vector(9 downto 0);
				  
	   -- Assignments to DE1 board LEDs
	   LEDR : out std_logic_vector(9 downto 0)
    );
end FTruthTable;

-- Architecture description
architecture Behavior of FTruthTable is

-- Equivalent to the four inputs of the F function
signal abcd : std_logic_vector(3 downto 0);

-- Equivalent to the unique output of the F function
signal    f : std_logic;

begin

-- Connect the DE1'S switches 3-0 to the 4 inputs of F function 
abcd(0) <= SW(0);
abcd(1) <= SW(1);
abcd(2) <= SW(2);
abcd(3) <= SW(3);
	 
-- Connects the output of F function to the DE1's LED 0
 LEDR(0) <= f;
	 
-- Logic based on the truth table derived for F function
    f <= '1' when (abcd = "0000") else
         '1' when (abcd = "0001") else
         '1' when (abcd = "0010") else
         '0' when (abcd = "0011") else
         '1' when (abcd = "0100") else
         '0' when (abcd = "0101") else
         '0' when (abcd = "0110") else
         '0' when (abcd = "0111") else
         '1' when (abcd = "1000") else
         '0' when (abcd = "1001") else
         '0' when (abcd = "1010") else
         '0' when (abcd = "1011") else
         '0' when (abcd = "1100") else
         '0' when (abcd = "1101") else
         '0' when (abcd = "1110") else
         '0';
	 
end Behavior;
