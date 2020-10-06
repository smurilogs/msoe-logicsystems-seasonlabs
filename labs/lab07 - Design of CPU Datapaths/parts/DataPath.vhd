-- DataPath.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date: 11/02/2012
-- Description: DataPath assembly 

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity DataPath is
	port(
			-- Inputs and outputs needed to this DataPath
			CLK : in  std_logic;
			 EN : in  std_logic_vector(3 downto 0);
			 OP : in  std_logic_vector(2 downto 0);

			  DA : in  std_logic_vector(3 downto 0);
			  DB : in  std_logic_vector(3 downto 0);
	    	DOUT : out std_logic_vector(4 downto 0)
	);
end DataPath;

-- Architecture description
architecture Behavior of DataPath is

	-- Auxiliar "wires" to support needed connections between instances
	signal  wMUXC : std_logic_vector(3 downto 0);
	signal wREGAQ : std_logic_vector(3 downto 0);
	signal wREGBQ : std_logic_vector(3 downto 0);
	signal  wALUC : std_logic_vector(4 downto 0);
	
	-- Declaration of use of the component MUX
	component MUX
		port(
				S : in  std_logic;
				A : in  std_logic_vector(3 downto 0);
				B : in  std_logic_vector(3 downto 0);
				C : out std_logic_vector(3 downto 0)		
		);
	end component;

	-- Declaration of use of the component REG4
	component REG4
		port(
			   CLK : in  std_logic;
				LD : in  std_logic;
				 D : in  std_logic_vector(3 downto 0);
				 Q : out std_logic_vector(3 downto 0)
		);
	end component;

	-- Declaration of use of the component REG5	
	component REG5
		port(
			    CLK : in  std_logic;
				 LD : in  std_logic;
				  D : in  std_logic_vector(4 downto 0);
				  Q : out std_logic_vector(4 downto 0)
		);
	end component;	
	
	-- Declaration of use of the component ALU
	component ALU
		port(
				S :  in std_logic_vector(2 downto 0);
				A :  in std_logic_vector(3 downto 0);
				B :  in std_logic_vector(3 downto 0);
				C : out std_logic_vector(4 downto 0)	
		);
	end component;
	
begin
	
	-- Instantiation and wiring of the componets inside this DataPath
	MUXa : MUX  port map (EN(0), DA, DB, wMUXC);
	REGa : REG4 port map (CLK, EN(1), wMUXC, wREGAQ);
	REGb : REG4 port map (CLK, EN(2), wMUXC, wREGBQ);
	ALUa : ALU  port map (OP, wREGAQ, wREGBQ, wALUC);
	REGc : REG5 port map (CLK, EN(3), wALUC, DOUT);
	
end Behavior;

	
	