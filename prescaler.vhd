library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity prescaler is 
	port(
		clkIn: in std_logic;
		clkOut: buffer std_logic
	);
end prescaler;

architecture default of prescaler is
	signal ctr: std_logic_vector(31 downto 0);	
	signal rstVal : std_logic_vector(31 downto 0) := X"001D7840";
begin
		process(clkIn) begin
		
			if(clkIn'event and clkIn='1') then
				if( ctr=rstVal ) then
					ctr <= X"00000000";
					clkOut <= not clkOut;
				else
					ctr <= ctr + X"1";
				end if;
			end if;
		end process;
end architecture; 