-- AdderSubtractor4bits.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (Adder/Subtractor - Structural style)
-- date: 09/27/2014
-- Description: Adder/Subtractor of 4 bits

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity AdderSubtractor4bits is
    port(
	      -- Assignments from DE1 board switches 
		SW : in std_logic_vector(9 downto 0);
				  
		-- Assignments to DE1 board LEDs
		LEDR : out std_logic_vector(9 downto 0)
        );
end AdderSubtractor4bits;

-- Architecture description
architecture Behavior of AdderSubtractor4bits is

    -- Equivalent to input signals of the 4-bit adder/subtractor unit 
    signal    a : std_logic_vector(3 downto 0);
    signal    b : std_logic_vector(3 downto 0);
    signal  sub : std_logic;
    
    -- Equivalent to output signals of the 4-bit adder/subtractor unit	 
    signal    s : std_logic_vector(3 downto 0);
    signal cout : std_logic;
    
    -- "Wires" sigbals to make easier internal wiring between components
    signal w1, w2, w3, w4, w5, w6, w7 : std_logic; 
    
    -- Declaration of use of the component XOR2inputs
    component XOR2inputs
        port(	
	         a, b : in std_logic; 
		      s : out std_logic
	     );
    end component;
	 
    -- Declaration of use of the component FullAdder
    component FullAdder
        port(
	         a, b, cin  :  in std_logic;
		      s, cout : out std_logic
		);
    end component;
	 
begin

    -- Connect the a inputs of the unit to some DE1's switches
    -- A value of 4-bit is assigned to the switches 7-4
    a(0) <= SW(4);
    a(1) <= SW(5);
    a(2) <= SW(6);
    a(3) <= SW(7);

    -- Connect the b inputs of the unit to some DE1's switches
    -- Another value of 4-bit is assigned to the switches 3-0	
    b(0) <= SW(0);   
    b(1) <= SW(1);
    b(2) <= SW(2);
    b(3) <= SW(3);
	 
    -- Connect the s outputs of the unit to the DE1's LEDs 3-0
    LEDR(0) <= s(0); 
    LEDR(1) <= s(1);
    LEDR(2) <= s(2);
    LEDR(3) <= s(3);
	 
    -- The choice for adder or subtractor is assigned to the switch 9 
    sub <= SW(9);
	 
    -- The respresetation of the carry out of the unit is assigned to the LED 9
    LEDR(9) <= cout;
	 
    -- Logic of a 4-bit Adder/Subtractor 
	 
    -- instantiation and wiring of the four full adder required
    fa4 : FullAdder port map(a(3), w1, w2, s(3), cout);    
    fa3 : FullAdder port map(a(2), w3, w4, s(2), w2);
    fa2 : FullAdder port map(a(1), w5, w6, s(1), w4);
    fa1 : FullAdder port map(a(0), w7, sub, s(0), w6);

    -- instantiation and wiring of the four xor logic gates required
    xor4 : XOR2inputs port map(b(3), sub, w1);
    xor3 : XOR2inputs port map(b(2), sub, w3);
    xor2 : XOR2inputs port map(b(1), sub, w5);
    xor1 : XOR2inputs port map(b(0), sub, w7);

end Behavior;
