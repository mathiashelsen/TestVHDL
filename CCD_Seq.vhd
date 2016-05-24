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
	rst	: in std_logic
    );
end CCD_Seq;

architecture default of CCD_Seq is
    type stateType is ( CLEAR, READOUT );
    signal state    : stateType := CLEAR;
    signal ctr	    : std_logic_vector(31 downto 0);	
begin
    process(clk, rst) begin
	if( rst = '1' ) then
	    state <= CLEAR;
	elsif(clk'event and clk='1') then
	    case state is
		when CLEAR =>
		    if( ctr(0) = '0' ) then
			Ph1 <= '1';
		    else
			Ph1 <= '0';
		    end if;

		    if( ctr(1) = '0' ) then
			Ph2 <= '1';
		    else
			Ph2 <= '0';
		    end if;
		    
		    if( ctr = X"0000_0010") then
			ctr <= X"0000_0000";
			state <= READOUT;
		    else
			ctr <= ctr + X"1";
		    end if;
		when READOUT =>
		    if( ctr(0) = '0' ) then
			Ph1 <= '1';
			Ph2 <= '0';
		    else
			Ph1 <= '0';
			Ph2 <= '1';
		    end if;
		    if( ctr = X"0000_0020" ) then
			ctr <= X"0000_0000";
			state <= CLEAR;
		    else
			ctr <= ctr + X"1";
		    end if;
	    end case; 
	end if;
    end process;
end architecture; 
