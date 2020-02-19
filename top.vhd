library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
 port (Clock_50 : in std_logic;
	Reset : in std_logic;
	SW : in std_logic_vector(3 downto 0);
	LEDR : out std_logic_vector (9 downto 0);
	HEX0 : out std_logic_vector (6 downto 0);
	HEX1 : out std_logic_vector (6 downto 0);
	HEX2 : out std_logic_vector (6 downto 0);
	HEX3 : out std_logic_vector (6 downto 0);
	HEX4 : out std_logic_vector (6 downto 0);
	HEX5 : out std_logic_vector (6 downto 0);
	GPIO_1:out std_logic_vector (9 downto 0));

end entity;

		
			
architecture top_arch of top is

signal cnt_n : std_logic_vector(37 downto 0); 
signal cnt	: std_logic_vector(37 downto 0);
signal Clock_div : std_logic;



component dflipflop
	port(
	
	Clock_In : in std_logic;
	Reset_In	:		in std_logic;
	D_In		: 		in std_logic;
	Q_Out		: out std_logic;
	Qn_Out	: out std_logic);
	
end component; 

component char_decoder
	port (BIN_IN : in std_logic_vector (3 downto 0);
			HEX_OUT : out std_logic_vector (6 downto 0));
end component;	

component walkingOne
	port (
	Clock_In : in std_logic;
	Reset_In : in std_logic;
	SW_In		: in std_logic; --We just care what switch(0) is
	LEDR_Out	: out std_logic_vector(9 downto 0);
	GPIO_Out	: out std_logic_vector(9 downto 0)
	);
end component;

	begin
Clock_div <= cnt(21);
			
	d0: dflipflop port map(Clock_In => Clock_50, Reset_In => Reset, D_In => cnt_n(0), Q_Out => cnt(0), Qn_Out => cnt_n(0));
	
genDflipflop: for i in 1 to 37 generate
	begin
	
	d: dflipflop port map(Clock_In => cnt_n(i-1), Reset_In => Reset, D_In => cnt_n(i), Q_Out => cnt(i), Qn_Out => cnt_n(i));
end generate;


	c0: char_decoder port map(BIN_IN => cnt(37) & cnt(36) & cnt(35) & cnt(34), HEX_OUT => HEX5);
	c1: char_decoder port map(BIN_IN => cnt(33) & cnt(32) & cnt(31) & cnt(30), HEX_OUT => HEX4);
	c2: char_decoder port map(BIN_IN => cnt(29) & cnt(28) & cnt(27) & cnt(26), HEX_OUT => HEX3);
	c3: char_decoder port map(BIN_IN => cnt(25) & cnt(24) & cnt(23) & cnt(22), HEX_OUT => HEX2);
	c4: char_decoder port map(BIN_IN => cnt(21) & cnt(20) & cnt(19) & cnt(18), HEX_OUT => HEX1);
	c5: char_decoder port map(BIN_IN => cnt(17) & cnt(16) & cnt(15) & cnt(14), HEX_OUT => HEX0);	
	
	walk: walkingOne port map(Clock_In => Clock_div, Reset_In => Reset, SW_In => SW(0), LEDR_Out => LEDR, GPIO_Out => GPIO_1);

end architecture; 