library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end reg_tb;

architecture arch of reg_tb is 
	component reg 
		port (	clk : in  std_logic;
         	rst : in  std_logic;
				i : in std_logic_vector(15 downto 0);
         	ou: out std_logic_vector(15 downto 0));
	end component;

signal ti,tou: std_logic_vector(15 downto 0);
signal clk,rst: std_logic;
begin
	UUT: reg port map(clk,rst,ti,tou);
	ti<= "1011011110000000";
	
rst<= '1','0' after 20 ns;
	process 
	begin
		clk<= '0','1' after 10 ns;
	wait for 20 ns;
	end process;
	
end arch;