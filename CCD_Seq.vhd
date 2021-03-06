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
    signal pixCtr   : std_logic_vector(11 downto 0);
begin
    Ph2 <= not Ph1;
    process(clk, rst) begin
	if( rst = '1' ) then
	    state <= CLEAR;
	elsif(clk'event and clk='1') then
	    case state is
		when CLEAR =>
		    case ctr is
			when X"0000_0000" =>
			    BT	<= '1';
			    RS	<= '0';
			    SH	<= '0';
			    Ph1 <= '1';
			when X"0000_0002" =>
			    SH	<= '1';
			when X"0000_002A" =>
			    SH	<= '0';
			when others =>
			    null;
		    end case;

		    if( ctr = X"0000_0066") then
			ctr <= X"0000_0000";
			state <= READOUT;
		    else
			ctr <= ctr + X"1";
		    end if;
		when READOUT =>
		    case ctr is
			when X"0000_0000" =>
			    BT <= '1';
			    RS <= '0';
			when X"0000_0009" =>
			    BT <= '0';
			when X"0000_000B" =>
			    RS <= '1';
			when X"0000_000D" =>
			    BT <= '1';
			when X"0000_000F" =>
			    RS <= '0';
			when X"0000_0010" =>
			    Ph1 <= not Ph1;
			when X"0000_0012" =>
			    sample <= '1';
			when X"0000_0013" =>
			    sample <= '0';
			when others =>
			    null;
		    end case;

		    if( ctr = X"0000_0013") then
			ctr <= X"0000_0000";
			if( pixCtr = X"82D" ) then
			    pixCtr <= X"000";
			    state <= CLEAR;
			else
			    pixCtr <= pixCtr + X"1";
			end if;
		    else
			ctr <= ctr + X"1";
		    end if;

	    end case; 
	end if;
    end process;
end architecture; 
