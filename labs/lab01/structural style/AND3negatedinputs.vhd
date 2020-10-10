-- AND3negatedinputs.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (F function – Structural)
-- date: 09/27/2014
-- Description: AND with 3 negated inputs

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity AND3negatedinputs is
    port(
	      -- The three inputs needed to create the intended device
            a, b, c :  in std_logic;
				
		 -- The output signal from the created device
                  s : out std_logic
        );
end AND3negatedinputs;

-- Architecture description
architecture Behavior of AND3negatedinputs is
begin

    -- Logic of an AND logic gate of 3 inputs
    s <= (((not a) and (not b)) and (not c));

end Behavior;
