-- XOR2inputs.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (Adder/Subtractor - Structural style)
-- date: 09/27/2014
-- Description: XOR of 2 inputs

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity XOR2inputs is
    port(
	         -- The two inputs needed to create the intended device
	         a, b : in std_logic;
				
		    -- The output signal from the created device
	          s : out std_logic
	   );
end XOR2inputs;

-- Architecture description
architecture Behavior of XOR2inputs is
begin

    -- Logic of a XOR logic gate of 2 inputs
    s <= ((not a) and b) or (a and (not b));

end Behavior;
