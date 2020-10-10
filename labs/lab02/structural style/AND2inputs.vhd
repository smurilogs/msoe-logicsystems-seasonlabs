-- AND2inputs.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (Adder/Subtractor - Structural style)
-- date: 09/27/2014
-- Description: AND of 2 inputs

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity AND2inputs is
    port(
	         -- The two inputs needed to create the intended device
	         a, b : in std_logic;
				
		    -- The output signal from the created device	         
		    s : out std_logic
	  );
end AND2inputs;

-- Architecture description
architecture Behavior of AND2inputs is
begin

    -- Logic of an AND logic gate of 2 inputs
    s <= a and b;

end Behavior;
