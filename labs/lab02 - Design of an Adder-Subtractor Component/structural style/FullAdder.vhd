-- FullAdder.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (Adder/Subtractor - Structural style)
-- date: 09/27/2014
-- Description: FullAdder

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity FullAdder is
    port(
	       -- The two inputs needed to create the intended device
             a, b, cin  :  in std_logic;
				
		  -- The output signal from the created device            
	    	  s, cout : out std_logic
        );
end FullAdder;

-- Architecture description
architecture Behavior of FullAdder is

    -- "Wires" to make easier internal wiring between components
    signal w1, w2, w3 : std_logic;
    
    -- Declaration of use of the component OR2inputs
    component  OR2inputs 
	 port(
	         a, b : in std_logic; 
		      s : out std_logic
	     );
	 end component;
	 
    -- Declaration of use of the component AND2inputs
    component AND2inputs 
        port(
	         a, b : in std_logic; 
		      s : out std_logic
	     );
	  end component;
	 
    -- Declaration of use of the component XOR2inputs
    component XOR2inputs 
	     port(
		          a, b : in std_logic;
					    s : out std_logic
				);
    end component;

begin

    -- Logic of a FullAdder based on the instantiations of other components
    xor1 : XOR2inputs port map (a, b, w1);
    xor2 : XOR2inputs port map (w1, cin, s);
    and1 : AND2inputs port map (cin, w1, w2);
    and2 : AND2inputs port map (a, b, w3);
    or1 :   OR2inputs port map (w2, w3, cout);

end Behavior;
