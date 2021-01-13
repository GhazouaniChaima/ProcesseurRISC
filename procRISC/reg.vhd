library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg is
port (clk :in std_logic ;
		rst:in std_logic ;
 		i:in std_logic_vector(15 downto 0);
	  ou :out std_logic_vector(15 downto 0));
end reg;

architecture arch of reg is
begin

process(clk,rst)
	begin
		if rst='1' then 
			ou<= "0000000000000000";
		elsif (rising_edge(clk))then 
			ou<=i;
		end if ;
	end process ;

end arch ;