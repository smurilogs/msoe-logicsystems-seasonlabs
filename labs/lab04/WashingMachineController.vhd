-- WashingMachineController.vhd
--
-- MSOE | EE 3900B 111, Fall 2014
-- Sergio Murilo Gonzaga Silva
-- Laboratory 5 - Design of Sequential Logic Systems
-- date: 10/18/2014
-- Description: This system was made to be used as a controller of an simplified washing machine. 
--		 The system is driven using a clock of 0.5Hz from a designed clock divider that  
--		 gets as input the 50 MHz clock crystal of the DE1 board. This washing machine   
-- 		 controller was designed to give to the user three options of water temperature: 
-- 		‘cold’, ‘warm’ and ‘cold’. These temperatures are made using mixtures of cold and 
--		 hot water (according to this lab requirements) from two different valves 
--		 activated by two different digital outputs of the FPGA. In addition, it is 
--		 possible to choose washing cycle between ‘delicate’ and ‘regular’, that are 
--		 determined by how many clock cycles the agitator would be activated. In the end 
--		 of the process, the spinner will keep in operation during fix number of clock 
--		 cycles.

-- Library used
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Entity declaration
entity WashingMachineController is
	port(
			  CLOCK_50 : in  std_logic;	
				    SW : in  std_logic_vector(9 downto 0);
			      LEDR : out std_logic_vector(9 downto 0)
	);
end WashingMachineController;

-- Architecture description
architecture Behavior of WashingMachineController is

	-- Signals equivalent to the controller input and outputs
	signal clockDE1, clockController, ST, TP1, TP0, AG : std_logic;
	signal valveCold, valveHot, agitator, spinner : std_logic;
	
	-- Declaration of a type 'state' for state transitions
	type state is (A, B, C, D, E, F, G, H, I);

	-- Signal to keep the current state of the system, initializes in A state
	signal currentState : state := A;
	
	-- Signal and constants to the frequency divisor manipulations
	constant   limit : integer := 100000000/2;
	signal   counter : integer range 0 to limit;
	
begin
	
	-- Connections between DE1 external interfaces with used signals

	clockDE1 <= CLOCK_50;

	ST  <= SW(3);
	TP1 <= SW(2);
	TP0 <= SW(1);
	AG  <= SW(0);
	
	LEDR(3) <= valveCold;
	LEDR(2) <= valveHot;
	LEDR(1) <= agitator;
	LEDR(0) <= spinner;
	
	-- For visualization of the controller clock
	LEDR(9) <= clockController;
 
       -- Process to divide the 50MHz input clock to get 0.5Hz to drive the controller
	process(clockDE1)
	begin
		if (clockDE1'event and clockDE1 = '1') then
			if (counter < limit) then
				counter <= counter + 1;
			else
				counter <= 1;
				clockController <= not clockController;
			end if;
		end if;
	end process;
	
	-- Process to manage the transitions between all the states designed for the system
	process(clockController)
	begin
		if (clockController'event and clockController = '1') then
			case currentState is
				when A =>
					if (ST = '0') then
						currentState <= A;
					else
						if (TP1 = '0') then
							currentState <= D;
		   				else
							currentState <= B;
			   			end if;
					end if;
				when B =>
					currentState <= C;
				when C =>
					currentState <= F;
				when D =>
					if (TP0 = '0') then
						currentState <= E;
					else
						currentState <= C;
					end if;
				when E =>
					currentState <= F;
				when F =>
					if (AG = '0') then
						currentState <= H;
					else
						currentState <= G;
					end if;
				when G =>
					currentState <= H;
				when H =>
					currentState <= I;
				when I =>
					currentState <= A;
			end case;
		end if;
	end process;

	-- Determines the cold water valve output based on the current state of the systems 
	valveCold <= '0' when (currentState = A) else
		         '0' when (currentState = B) else
		         '0' when (currentState = C) else
		         '1' when (currentState = D) else
		         '1' when (currentState = E) else 
		         '0' when (currentState = F) else
		         '0' when (currentState = G) else
		         '0' when (currentState = H) else
		         '0'; 
					 
	-- Determines the chot water valve output based on the current state of the systems	  
	valveHot <= '0' when (currentState = A) else
		        '1' when (currentState = B) else
		        '1' when (currentState = C) else
		        '0' when (currentState = D) else
		        '0' when (currentState = E) else 
		        '0' when (currentState = F) else
		        '0' when (currentState = G) else
		        '0' when (currentState = H) else
		        '0'; 

    -- Determines the agitator situation based on the current state of the systems			
    agitator <= '0' when (currentState = A) else
	            '0' when (currentState = B) else
		        '0' when (currentState = C) else
		        '0' when (currentState = D) else
		        '0' when (currentState = E) else 
		        '1' when (currentState = F) else
		        '1' when (currentState = G) else
		        '0' when (currentState = H) else
		        '0'; 

    -- Determines the spinner situation based on the current state of the systems
    spinner <= '0' when (currentState = A) else
	           '0' when (currentState = B) else
		       '0' when (currentState = C) else
		       '0' when (currentState = D) else
		       '0' when (currentState = E) else 
		       '0' when (currentState = F) else
		       '0' when (currentState = G) else
		       '1' when (currentState = H) else
		       '1'; 
end Behavior;
