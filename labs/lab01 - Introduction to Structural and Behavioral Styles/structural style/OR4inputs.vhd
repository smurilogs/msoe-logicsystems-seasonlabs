-- OR4inputs.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (F function – Structural)
-- date: 09/27/2014
-- Description: OR with 4 inputs

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity OR4inputs is
    port(
            -- Four inputs needed to create the intended device
		 a, b, c, d :  in std_logic;
				
		-- The output signal from the created device
           s : out std_logic
        );
end OR4inputs;

-- Architecture description
architecture Behavior of OR4inputs is
begin

    -- Logic of an OR logic gate of 4 inputs
    s <= ((a or b) or (c or d));

end Behavior;
