-- DesignProject.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- date: 11/02/2012
-- Description: Design project assembly

-- Imports
library ieee;
use ieee.std_logic_1164.all;

-- Entity declaraton
entity DesignProject is
	port(
				CLK : in std_logic;
				 ST : in std_logic;
				 OP : in std_logic_vector(2 downto 0);
				 DA : in std_logic_vector(3 downto 0);
				 DB : in std_logic_vector(3 downto 0);
				 
				 DN : out std_logic;
			  DOUT : out std_logic_vector(4 downto 0)
	);
end DesignProject;

-- Architecture description
architecture Behavior of DesignProject is

	signal wEN : std_logic_vector(3 downto 0);

	-- Declaration of use of the component Controller
	component Controller
		port(
					CLK : in std_logic;
					 ST : in std_logic;
					 OP : in std_logic_vector(2 downto 0);
					 
					 EN : out std_logic_vector(3 downto 0);
					 DN : out std_logic			
		);
	end component;
	
	-- Declaration of use of the component DataPath
	component DataPath
		port(
			       CLK : in  std_logic;
                 EN : in  std_logic_vector(3 downto 0);
					  OP : in  std_logic_vector(2 downto 0);

				     DA : in  std_logic_vector(3 downto 0);
					  DB : in  std_logic_vector(3 downto 0);
					DOUT : out std_logic_vector(4 downto 0)		
		);
	end component;
		
begin

	-- Instantiation and wiring of the componets inside this design project
	CONTROLa  : Controller port map (CLK,  ST, OP, wEN, DN);
	DATAPATHa : DataPath   port map (CLK, wEN, OP,  DA, DB, DOUT);
	
end Behavior;
	