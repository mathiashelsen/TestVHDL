library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CCD_Seq is 
    port(
	clk	: in std_logic;
	SH	: buffer std_logic;
	Ph1	: buffer std_logic;
	Ph2	: buffer std_logic;
	RS	: buffer std_logic;
	BT	: buffer std_logic;
	sample	: buffer std_logic;
	rst	: in std_logic;
    );
end prescaler;

architecture default of CDD_Seq is
    type stateType is ( CLEAR, READOUT );
    signal state    : stateType := CLEAR;
    signal ctr	    : std_logic_vector(31 downto 0);	
begin
    process(clk, rst) begin
	if( rst = '1' ) then
	    state <= CLEAR;
	elsif(clkIn'event and clkIn='1') then
	    case state is
		when CLEAR =>

		when READOUT =>
	    end case; 
	end if;
    end process;
end architecture; 
