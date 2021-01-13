library ieee;
use ieee.std_logic_1164.all;

entity mux3v1_tb is
end mux3v1_tb;

architecture arch of mux3v1_tb is 
component mux3v1 
 port (	
	in1: in std_logic_vector(15 downto 0);
	in2: in std_logic_vector(15 downto 0);
	in3: in std_logic_vector(15 downto 0);
	sel: in std_logic_vector(1 downto 0);
	o: out std_logic_vector(15 downto 0));
end component;

signal tIn1,tIn2,tIn3,too: std_logic_vector(15 downto 0);
signal tSel: std_logic_vector(1 downto 0);

begin
UUT: mux3v1 port map(tIn1,tIn2,tIn3,tSel,too);
	tIn1<= "1011011110000000";
	tIn2 <= "1011010110010011";
	tIn3 <= "1011010110010000";

process 
begin
	tSel<= "10";
	wait for 20 ns;
	tSel<= "00";
	wait for 40 ns;
	tSel<="01";
	wait for 60 ns;
end process;

end arch;