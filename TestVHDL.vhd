library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TestVHDL is
	port(
		CLOCK_50	: in std_logic;
		GPIO0_D	: out std_logic_vector(6 downto 0)
	);
end TestVHDL;

architecture default of TestVHDL is
	signal localClk : std_logic;
	signal sh			: std_logic;
	signal ph1			: std_logic;
	signal ph2			: std_logic;
	signal bt			: std_logic;
	signal rs			: std_logic;
	signal sample		: std_logic;
	
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
	
	component mainPLL
		port(
			inclk0	: in std_logic;
			c0			: out std_logic
		);
	end component;
begin
	-- LEDG <= outCtr;
	GPIO0_D(0) <= not sh;
	GPIO0_D(1) <= not ph1;
	GPIO0_D(2) <= not ph2;
	GPIO0_D(3) <= not rs;
	GPIO0_D(4) <= not bt;
	GPIO0_D(5) <= sample;
	GPIO0_D(6) <= localClk;
	
	U0: mainPLL port map( CLOCK_50, localClk );

	U1: CCD_Seq port map(
		clk => localClk, 
		SH => sh, 
		Ph1 => ph1, 
		Ph2 => ph2, 
		RS => rs,
		BT => bt,
		sample => sample,
		rst => '0');
end architecture;
	
