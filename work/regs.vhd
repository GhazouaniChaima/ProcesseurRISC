-------------------------------------------------------------------------------
-- 16-bit instruction register
--
-- Ports:
--   - clk [in]  : clock signal
--   - ce  [in]  : clock enable signal
--   - rst [in]  : reset signal
--
--   - instr [in]  : instruction word from memory
--   - cond  [out] : condition
--   - op    [out] : opcode
--   - updt  [out] : update flag
--   - imm   [out] : immediate flag
--   - val   [out] : register number / immediate value
--
--         __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __
-- Bit #  |15|14|13|12|11|10| 9| 8| 7| 6| 5| 4| 3| 2| 1| 0|
--        |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|
--
--        |-----------|-----------|--|--|-----------------|
--          Condition     Opcode    |  |  Register / Value
--                          Update -'  '- Immediate
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity instr_reg is
  port ( clk : in  std_logic;
         ce  : in  std_logic; --instr_ce
         rst : in  std_logic; --reset

         instr : in  std_logic_vector(15 downto 0); --ram_dout

				--Mot d’instruction: cond.op.updt.imm.val
         cond  : out std_logic_vector(3 downto 0);
         op    : out std_logic_vector(3 downto 0);
         updt  : out std_logic;
         imm   : out std_logic;
         val   : out std_logic_vector(5 downto 0) );

end instr_reg;

architecture arch of instr_reg is

begin
process(clk,rst,ce)
begin
	if (rst ='1') then
		cond<="0000";
		op<="0000";
		updt<='0';
		imm<='0';
		val<="000000";
	elsif (clk'event and clk='1') and (ce='1') then
		
			cond <= instr(15 downto 12);
			op <= instr(11 downto 8);
			updt <= instr(7);
			imm <= instr(6);
			val <= instr(5 downto 0);
		
	end if;
end process ;

end arch;







-------------------------------------------------------------------------------
-- 4-bit status register
--
-- Ports:
--   - clk [in]  : clock signal
--   - ce  [in]  : clock enable signal
--   - rst [in]  : reset signal
--
--   - i [in]  : status flags from ALU
--   - o [out] : latched status flags
--
--         __ __ __ __
-- Bit #  | 3| 2| 1| 0|
--        |__|__|__|__|
--          Z  N  C  V
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity status_reg is
  port ( clk : in  std_logic;
         ce  : in  std_logic;--status_ce
         rst : in  std_logic;--reset

         i : in  std_logic_vector(3 downto 0);
         o : out std_logic_vector(3 downto 0) );
end status_reg;

architecture arch of status_reg is
signal st : std_logic_vector(3 downto 0);
begin
process(clk ,rst,ce)
begin 
	if rst = '1' then
	   o<="0000";
	end if ;
	if clk'event and clk = '1' then
		if (ce ='1') then 
			o<=i;
		end if ;
	end if ;
end process ;

end arch;


-------------------------------------------------------------------------------
-- 64 x 16 bits register file
--
-- Ports:
--   - clk [in]  : clock signal
--   - rst [in]  : reset signal
--
--   - acc_out [out] : accumulator value
--   - acc_ce  [in]  : accumulator clock enable signal
--
--   - pc_out [out] : program counter value
--   - pc_ce  [in]  : program counter clock enable signal
--   - rpc_ce [in]  : return program counter clock enable signal
--
--   - rx_num [in]  : register number
--   - rx_out [out] : register value
--   - rx_ce  [in]  : register clock enable signal
--
--   - din [in]  : input value
--
--        ________________
--   R0  |________________| Accumulator (Acc)
--   R1  |________________|
--   R2  |________________|
--          .    .    .
--        ________________
--   R61 |________________|
--   R62 |________________| Return program counter (RPC)
--   R63 |________________| Program counter (PC)
--
-- The PC has to be reset to 0xA000 to account for the video memory sitting
-- on addresses from 0x0000 to 0x9FFF.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity reg_file is
  port ( clk : in  std_logic;
         rst : in  std_logic;
         acc_out : out std_logic_vector(15 downto 0);
         acc_ce  : in  std_logic;
         pc_out : out std_logic_vector(15 downto 0);
         pc_ce  : in  std_logic;
         rpc_ce : in  std_logic;
         rx_num : in  std_logic_vector(5 downto 0);
         rx_out : out std_logic_vector(15 downto 0);
         rx_ce  : in  std_logic;
         din : in  std_logic_vector(15 downto 0) );
end reg_file;

architecture arch of reg_file is
type banc_reg is array (63 downto 0) of std_logic_vector (0 to 15);
signal reg : banc_reg;
signal i: integer;
signal s:std_logic_vector(5 downto 0):=(others=>'0');
begin
s<=rx_num;
process (clk,rst)
begin 
	if (rst='1') then 
			boucle:FOR  i in 0 to 62 loop
       reg(i) <= "0000000000000000";
			end loop boucle;	
      reg(63) <= "1010000000000000";	  
	elsif (rising_edge(clk))then
   		if (rx_ce='1' )then
//ecriture
      reg(to_integer(unsigned(s)))<=din;
       end if;		
		if ( acc_ce='1')then
    				reg(0) <= din;
    end if;
		if (rpc_ce='1'  )then
					reg(62)<= din;
    end if;
		if ( pc_ce='1'  )then
		     	reg(63)<= din;
     end if;
end if;

end process;

rx_out<=reg(to_integer(unsigned(s)));
acc_out<=reg(0);
pc_out<=reg(63);
end arch;