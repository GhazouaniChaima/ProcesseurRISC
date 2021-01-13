library ieee;
use ieee.std_logic_1164.all;

entity incrementeur_tb is
end incrementeur_tb;

architecture arch of incrementeur_tb is 

component incrementeur 
   Port ( in1 : in  STD_LOGIC_VECTOR (15 downto 0);
             o : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal tin1, too: std_logic_vector(15 downto 0);


begin
UUT: incrementeur port map(tin1,too);
	tin1<= "1011011110000000","1011011110011000" after 20 ns,"1011011110011001" after 40 ns;


end arch;