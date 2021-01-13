library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incrementeur is
   Port ( in1 : in  STD_LOGIC_VECTOR (15 downto 0);
             o : out STD_LOGIC_VECTOR (15 downto 0));
end incrementeur;

architecture Arch of incrementeur is

begin
o <= std_logic_vector(unsigned(in1)+ 1);
end Arch;
