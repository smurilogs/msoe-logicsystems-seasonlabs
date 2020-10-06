
library ieee;
use ieee.std_logic_1164.all;

entity MUX is
	port(
				S : in  std_logic;
				A : in  std_logic_vector(3 downto 0);
				B : in  std_logic_vector(3 downto 0);
				C : out std_logic_vector(3 downto 0)				
	);
end MUX;

architecture Behavior of MUX is
begin
	
	with S select
	C <= A when '0',
		  B when others;
				  
end Behavior;
	