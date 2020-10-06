-- AdderSubtractor4bits.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 3 (Adder/Subtractor - Behavioral style)
-- date: 09/27/2014
-- Description: Adder/Subtractor of 4 bits

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity AdderSubtractorUnit4bits is
    port(
		-- Assignments from DE1 board switches 
	       SW : in std_logic_vector(9 downto 0);

	       -- Assignments to DE1 board LEDs
		LEDR : out std_logic_vector(9 downto 0)
        );
end AdderSubtractorUnit4bits;

-- Architecture description
architecture Behavior of AdderSubtractorUnit4bits is

    -- Equivalent to input signals of the 4-bit adder/subtractor unit 
	 signal a, b : std_logic_vector(3 downto 0);
	 signal	sub : std_logic;

    -- Equivalent to output signals of the 4-bit adder/subtractor unit
	 signal    s : std_logic_vector(3 downto 0);
	 signal cout : std_logic;	
	 
	 -- Signals used for internal manipulations
	 signal x : std_logic_vector(3 downto 0);
	 signal c : std_logic_vector(3 downto 0);

begin
 
    -- Connect the s outputs of the unit to the DE1's LEDs
    LEDR(0) <=  s(0);
    LEDR(1) <=  s(1);
    LEDR(2) <=  s(2);
    LEDR(3) <=  s(3);

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
	 
    -- The choice for adder or subtractor is assigned to the switch 9
    sub <= SW(9);

    -- The representation of the carry out of the unit is assigned to the LED 9
    LEDR(9) <= cout; 
	 
    -- Logic to design fulladders and xor gates needed to design a 4-bit 
    -- adder/subtractor
	 
    cout <= c(0);
	 
    x(0) <= (((not b(0)) and sub) or (b(0) and (not sub)));
    s(0) <= (((not (((not a(0)) and x(0)) or (a(0) and (not x(0))))) and sub) or ((((not a(0)) and x(0)) or (a(0) and (not x(0)))) and (not sub)));
    c(0) <= (a(0) and x(0)) or (sub and (((not a(0)) and x(0)) or (a(0) and (not x(0)))));

    x(1) <= (((not b(1)) and sub) or (b(1) and (not sub)));
    s(1) <= (((not (((not a(1)) and x(1)) or (a(1) and (not x(1))))) and c(0)) or ((((not a(1)) and x(1)) or (a(1) and (not x(1)))) and (not c(0))));
    c(1) <= (a(1) and x(1)) or (c(0) and (((not a(1)) and x(1)) or (a(1) and (not x(1)))));

    x(2) <= (((not b(2)) and sub) or (b(2) and (not sub)));
    s(2) <= (((not (((not a(2)) and x(2)) or (a(2) and (not x(2))))) and c(1)) or ((((not a(2)) and x(2)) or (a(2) and (not x(2)))) and (not c(1))));
    c(2) <= (a(2) and x(2)) or (c(1) and (((not a(2)) and x(2)) or (a(2) and (not x(2)))));

    x(3) <= (((not b(3)) and sub) or (b(3) and (not sub)));
    s(3) <= (((not (((not a(3)) and x(3)) or (a(3) and (not x(3))))) and c(2)) or ((((not a(3)) and x(3)) or (a(3) and (not x(3)))) and (not c(2))));
    c(3) <= (a(3) and x(3)) or (c(2) and (((not a(3)) and x(3)) or (a(3) and (not x(3)))));
	 
end Behavior;
