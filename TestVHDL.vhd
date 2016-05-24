library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TestVHDL is
	port(
		CLOCK_50	: in std_logic;
		LEDG		: out std_logic_vector(9 downto 0)
	);
end TestVHDL;

architecture default of TestVHDL is
	signal outCtr	: std_logic_vector(9 downto 0);
	signal localClk : std_logic;
	component prescaler
		port( clkIn: in std_logic;
		    clkOut: out std_logic );
	end component;

	component CCD_Seq
		port( 
		    clk	: in std_logic;
		    SH	: buffer std_logic;
		    Ph1	: buffer std_logic;
		    Ph2	: buffer std_logic;
		    RS	: buffer std_logic;
		    BT	: buffer std_logic;
		    sample	: buffer std_logic;
		    rst	: in std_logic 
		    );
	end component;
begin
	-- LEDG <= outCtr;
	U0: prescaler port map( CLOCK_50, localClk );

	U1: CCD_Seq port map(
		clk => localClk, 
		SH => open, 
		Ph1 => LEDG(0), 
		Ph2 => LEDG(1), 
		RS => open,
		BT => open,
		sample => open,
		rst => '0');
	process(localClk)
	begin
		if(localClk'event and localClk='1') then
			outCtr <= outCtr + X"1";
		end if;
	end process;
end architecture;
	
