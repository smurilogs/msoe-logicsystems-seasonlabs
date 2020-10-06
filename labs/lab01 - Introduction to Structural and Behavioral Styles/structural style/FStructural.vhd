-- FStructural.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (F function - Structural)
-- date: 09/27/2014
-- Description: Function F in structural style

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity FStructural is
    port(
	         -- Assignments from DE1 board switches 
		    SW : in std_logic_vector(9 downto 0);
			   
		    -- Assignments to DE1 board LEDs
		    LEDR : out std_logic_vector(9 downto 0)
	  );
end FStructural;

-- Architecture description
architecture Behavior of FStructural is

    -- The four inputs an the output required by the F function
    signal  a, b, c, d, f : std_logic; 
	 
    -- "Wires" make easier internal wiring between components
    signal w1, w2, w3, w4 : std_logic;
    
    -- Declaration of use of the component AND3inputs
    component AND3negatedinputs is
	     port(
	             a, b, c : in std_logic; 
                        s : out std_logic
	         );
    end component;



    -- Declaration of use of the component OR4inputs
    component OR4inputs is
	     port(
	             a, b, c, d : in std_logic;
	                      s : out std_logic	
	         );
    end component;
	 
begin
    
    -- Connect the DE1'S switches 3-0 to the 4 inputs of F function
    d <= SW(0);
    c <= SW(1);
    b <= SW(2);
    a <= SW(3);
	 
    -- Connects the output of F function to the DE1's LED 0
    LEDR(0) <= f;

    -- Implement the logic of the F function	 
    and1 : AND3negatedinputs port map(a, c, d, w1);
    and2 : AND3negatedinputs port map(b, c, d, w2);
    and3 : AND3negatedinputs port map(a, b, c, w3);
    and4 : AND3negatedinputs port map(a, b, d, w4);
     or1 : OR4inputs port map(w1, w2, w3, w4, f);

end Behavior;
