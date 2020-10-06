-- FullAdder.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date:
-- Description: FullAdder

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity FullAdder is
    port(
	        -- The three inputs needed
            A, B, CIN  :  in std_logic;
				
			-- The output signal from the created device            
	    	   C, COUT : out std_logic
    );
end FullAdder;

-- Architecture description
architecture Behavior of FullAdder is

    -- "Wires" sigbals to make easier internal wiring
	 signal w1, w2, w3 : std_logic;

begin

	w1 <= ((not A) and B) or (A and (not B));
	 C <= ((not w1) and CIN) or (w1 and (not CIN));
	
	w2 <= w1 and CIN;
	w3 <= A and B;

	COUT <= w2 or w3; 

end Behavior;