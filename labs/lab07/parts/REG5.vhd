 
library ieee;
use ieee.std_logic_1164.all;

entity REG5 is
	port(
				CLK : in  std_logic;
				 LD : in  std_logic;
				  D : in  std_logic_vector(4 downto 0);
				  Q : out std_logic_vector(4 downto 0)
	);
end REG5;

architecture Behavior of REG5 is
begin

	process(CLK)
	begin
		if(CLK'event and CLK = '1') then
			if (LD = '1') then
				Q <= D;
			end if;
		end if;
	end process;

end Behavior;
	