library ieee;
use ieee.std_logic_1164.all;

entity mux2v1_tb is
end mux2v1_tb;

architecture arch of mux2v1_tb is 
component mux2v1 
 port (	
	In0: in std_logic_vector(15 downto 0);
	In1: in std_logic_vector(15 downto 0);
	Sel: in std_logic;
	Z: out std_logic_vector(15 downto 0));
end component;

signal tIn0,tIn1,tZ: std_logic_vector(15 downto 0);
signal tSel: std_logic;

begin
UUT: mux2v1 port map(tIn0,tIn1,tSel,tZ);
	tIn0<= "1011011110000000";
	tIn1 <= "1011010110010011";
	
process 
begin
	tSel<= '1';
	wait for 20 ns;
	tSel<= '0';
	wait for 40 ns;
end process;

end arch;