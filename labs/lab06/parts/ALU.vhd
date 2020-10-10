-- ALU.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date: 11/01/2012
-- Description: ALU that operates 4 pair of bits. Operations: addition (S = "000"), subtraction (S = "001")
--  AND (S = "010"), OR (S = "011"), XOR (S = "100") and extra addition for double operations (S = "101") 

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity ALU is
	port(
			 -- Inputs and outputs needed to this ALU
			 S :  in std_logic_vector(2 downto 0);
			 A :  in std_logic_vector(3 downto 0);
			 B :  in std_logic_vector(3 downto 0);
			 C : out std_logic_vector(4 downto 0)
	);
end ALU;

-- Architecture description
architecture Behavior of ALU is

	-- Declaration of use of the component ADDSUBMod
	component ADDSUBMod
	port(
				  A : in std_logic_vector(3 downto 0);
				  B : in std_logic_vector(3 downto 0);
				SUB : in std_logic;
				
				   C : out std_logic_vector(3 downto 0);
				COUT : out std_logic		
	);
	end component;

	-- Declaration of use of the component ANDMod
	component ANDMod
	port(
				A : in std_logic_vector(3 downto 0);
				B : in std_logic_vector(3 downto 0);
				C: out std_logic_vector(3 downto 0)				
	);
	end component;

	-- Declaration of use of the component ORMod	
	component ORMod
	port(
				A : in std_logic_vector(3 downto 0);
				B : in std_logic_vector(3 downto 0);
				C: out std_logic_vector(3 downto 0)				
	);
	end component;

	-- Declaration of use of the component XORMod	
	component XORMod
	port(
				A : in  std_logic_vector(3 downto 0);
				B : in  std_logic_vector(3 downto 0);
				C : out std_logic_vector(3 downto 0)				
	);
	end component;

	-- Auxiliar "wires" to support the switching of operations
	signal waddsub : std_logic_vector(5 downto 0);
	signal    wand : std_logic_vector(3 downto 0);
	signal     wor : std_logic_vector(3 downto 0);
	signal    wxor : std_logic_vector(3 downto 0);
	
begin

	-- Instantiation and wiring of the modules of operations designed to this ALU
	ADDSUBa : ADDSUBMod port map (A, B, waddsub(4), waddsub(3 downto 0), waddsub(5));
	ANDMODa :    ANDMod port map (A, B, wand);
   ORMODa  :     ORMod port map (A, B, wor);
   XORMODa :    XORMod port map (A, B, wxor);

	-- Swithing to select what the module of addition and subtraction will do  
	with S select 	
	waddsub(4) <= '0' when ("000"),   -- If S = "000", addition
			        '1' when ("001"),   -- If S = "001", subtraction
					  '0' when ("101"),   -- If S = "101", extra addition
					  '0' when others;

	-- Swithing to select if it will be presented carry out bit from the adder/subtracror module or not
	with S select 	
	C(4) <= waddsub(5) when ("000"),
			  waddsub(5) when ("001"),
			  waddsub(5) when ("101"),
			         '0' when others;					  

	-- Swithing to select what module outputs will be used based on S selector					
	with S select 				  
	C(3 downto 0) <= waddsub(3 downto 0) when ("000"),
						  waddsub(3 downto 0) when ("001"),	                 
											  wand when ("010"),
                                    wor when ("011"),
                                   wxor when ("100"),
						  waddsub(3 downto 0) when ("101"),
											"0000" when others;
				  
end Behavior;
