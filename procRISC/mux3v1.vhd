library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 entity mux3v1 is
      Port ( in1 : in  std_logic_vector (15 downto 0);
           	in2 : in  std_logic_vector (15 downto 0);
			  		in3 : in  std_logic_vector (15 downto 0);
					sel : in std_logic_vector(1 downto 0);
           o : out std_logic_vector (15 downto 0));
 end mux3v1;


architecture arch of mux3v1 is
begin

	

	o<=in1 when sel ="10"
	else in2 when sel="00"
	else in3  when sel="01"
	else "0000000000000000";
	
	
end arch;


