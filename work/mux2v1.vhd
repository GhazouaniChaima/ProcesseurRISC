library ieee;
use ieee.std_logic_1164.all;

entity mux2v1 is
        port (In0, In1: in std_logic_vector (15 downto 0);
	   Sel: in std_logic;
                   Z: out std_logic_vector (15 downto 0));
end mux2v1;
architecture Arch of mux2v1 is
begin
Z <= In0 when Sel ='0' else
     In1 when Sel ='1' else
       "0000000000000000" ;
end Arch;
