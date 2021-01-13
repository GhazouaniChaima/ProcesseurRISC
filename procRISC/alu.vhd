-- Arithmetic logic unit
--
-- Ports:
--   - op [in]  : 4-bit instruction opcode
--   - i1 [in]  : operand 1
--   - i2 [in]  : operand 2
--   - o  [out] : result
--   - st [out] : 4-bit status flags
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is
  port ( op : in  std_logic_vector(3 downto 0);
         i1 : in  std_logic_vector(15 downto 0);
         i2 : in  std_logic_vector(15 downto 0);
         o  : out std_logic_vector(15 downto 0);
         st : out std_logic_vector(3 downto 0));
end alu;

architecture arch of alu is
signal result:std_logic_vector(16 downto 0);
signal Z,N,C,V:std_logic;
signal in1,in2:std_logic_vector(14 downto 0);
signal num,sgn1,sgn2:std_logic_vector(15 downto 0);
begin
process(op,i1,i2)
begin
case op is
when "0000" =>result <='0'&i1 and '0'&i2; -- and 
when "0001" =>result <='0'&i1 or '0'&i2; -- or 
when "0010" =>result <='0'&i1 xor '0'&i2; -- xor 
when "0011" =>result <='0'&(not i2) ; -- not 
when "0100" =>result <=('0'&i1)+('0'&i2); -- add 
when "0101" =>result <= std_logic_vector( signed('0'&i1(15 downto 0))- signed ('0'&i2(15 downto 0))); -- sub
when "0110" =>result <=std_logic_vector(shift_left( signed('0'&i1),to_integer(signed('0'&i2))));  --lsl 
when "0111" => result<=std_logic_vector(shift_right( signed('0'&i1),to_integer(signed('0'&i2)))); --lsr 
when "1000" => result <= ('0'&i2); --LDA 
when "1001" => result <= ('0'&i1); --STA 
when "1010" =>result <= '0'&i2; --MTA
when "1011" =>result <= '0'&i1; --MTR
when "1100" =>result(15 downto 0) <=i1+i2 ; --JRP
when "1101" =>result (15 downto 0)<=i1-i2; --JRN
when "1110" =>result (15 downto 0)<=i2; --JPR
when "1111" =>result (15 downto 0)<=i2; --CAL
when others => null;
end case;
end process;

o <= result(15 downto 0);
Z <='1' when (result(15 downto 0) ="0000000000000000") else '0'; --Zero 
N <= '1' when(result(15)='1') else '0';
C <=  not result(16) when (op="0101") --sub
else
      result(16); --carry out

in1 <= i1(14 downto 0);
in2 <= i2(14 downto 0);
num <=('0'&in1) + ('0'&in2); --16 bit mte3 resultat de l'addition (cin)

V <= C xor num(15) when (op="0100")else 
     (i1(15)and (not i2(15)) and (not result(15))) or ((not i1(15))and i2(15)and result(15)) when (op="0101") 
		else
     result(15) when (op="0110")else
     '0';

st<= Z&N&C&V; 
end arch;

