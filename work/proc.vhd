-------------------------------------------------------------------------------
-- Top-level processor component
--
-- Ports:
--   - clk [in]  : clock signal
--   - rst [in]  : reset signal
--
--   - ram_addr [out] : memory address
--   - ram_din  [out] : data input to memory
--   - ram_dout [in]  : data output from memory
--   - ram_we   [out] : write enable signal for memory
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity proc is
  port ( clk : in  std_logic;
         rst : in  std_logic;
         
         ram_addr : out std_logic_vector(15 downto 0);
         ram_din  : out std_logic_vector(15 downto 0);
         ram_dout : in  std_logic_vector(15 downto 0);
         ram_we   : out std_logic );
end proc;

architecture arch of proc is

  component control 
    port ( clk : in  std_logic;
           rst : in  std_logic;

           status     : in  std_logic_vector(3 downto 0);
           instr_cond : in  std_logic_vector(3 downto 0);
           instr_op   : in  std_logic_vector(3 downto 0);
           instr_updt : in  std_logic;

           instr_ce  : out std_logic;
           status_ce : out std_logic;
           acc_ce    : out std_logic;
           pc_ce     : out std_logic;
           rpc_ce    : out std_logic;
           rx_ce     : out std_logic;

           ram_we : out std_logic;

           sel_ram_addr : out std_logic;
           sel_op1      : out std_logic;
           sel_rf_din   : out std_logic_vector(1 downto 0) );
  end component;


 component alu 

    port ( op : in  std_logic_vector(3 downto 0);
           i1 : in  std_logic_vector(15 downto 0);
           i2 : in  std_logic_vector(15 downto 0);
           o  : out std_logic_vector(15 downto 0);
           st : out std_logic_vector(3 downto 0) );
  end component;  


    
	component status_reg 
   port ( clk : in  std_logic;
          ce  : in  std_logic;
          rst : in  std_logic;

          i : in  std_logic_vector(3 downto 0);
          o : out std_logic_vector(3 downto 0) );
  end component;
  

    component instr_reg 
   port ( clk : in  std_logic;
          ce  : in  std_logic;
          rst : in  std_logic;

          instr : in  std_logic_vector(15 downto 0);
          cond  : out std_logic_vector(3 downto 0);
          op    : out std_logic_vector(3 downto 0);
          updt  : out std_logic;
          imm   : out std_logic;
          val   : out std_logic_vector(5 downto 0) );
  end component;

 
  component reg_file
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
  end component;


  
component mux2v1 
        port (In0, In1: in std_logic_vector (15 downto 0);
	   Sel: in std_logic;
                   Z: out std_logic_vector (15 downto 0));
end component;


 component mux3v1 -------
      Port ( in1 : in  std_logic_vector (15 downto 0);
           	in2 : in  std_logic_vector (15 downto 0);
			  		in3 : in  std_logic_vector (15 downto 0);
					sel :in std_logic_vector(1 downto 0);
           o : out std_logic_vector (15 downto 0));
 end component;


 component incrementeur -------
      Port ( in1 : in  STD_LOGIC_VECTOR (15 downto 0);
             o : out STD_LOGIC_VECTOR (15 downto 0));
 end component;

component reg 
port (clk :in std_logic ;
		rst:in std_logic ;
 		i:in std_logic_vector(15 downto 0);
	  ou :out std_logic_vector(15 downto 0));
end component;

signal stat,icond,iop,oia :std_logic_vector(3 downto 0);
signal iupdt,iimm,i_ce,stat_ce,a_ce,p_ce,rp_ce,r_ce,sel_ram,sel_op :std_logic;
signal sel_rf :std_logic_vector(1 downto 0);
signal op1,op2,res,acc,pc,rx,dreg,o1,o2,incresult,vall2,inc :std_logic_vector(15 downto 0);
signal vall:std_logic_vector(5 downto 0);

begin

CU: control port map (clk,rst,stat,icond,iop,iupdt,i_ce,stat_ce,a_ce,p_ce,rp_ce,r_ce,ram_we,sel_ram,sel_op,sel_rf);
--clk, rst, status ,instr_cond, instr_op, instr_updt ,instr_ce, status_ce, acc_ce , pc_ce ,rpc_ce,rx_ce ,ram_we,sel_ram_addr,sel_op1 ,sel_rf_din

RS: status_reg port map(clk,stat_ce,rst,oia,stat);
-- clk ,ce ,rst,i,o

        
RI:instr_reg port map(clk,i_ce,rst,ram_dout,icond,iop,iupdt,iimm,vall); 
---clk , ce ,rst,instr ,cond ,op ,updt ,imm ,val 

BR:reg_file port map(clk,rst,acc,a_ce,pc,p_ce,rp_ce,vall,rx,r_ce,dreg);
--clk,rst,acc_out ,acc_ce ,pc_out ,pc_ce ,  rpc_ce , rx_num ,rx_out ,rx_ce ,din 

vall2<= "0000000000"&vall ;
M1:mux2v1 port map (rx,vall2,iimm,o2); -----
--IN0,In1,Sel,Z
 
OP2R: reg port map (clk,rst,o2,op2); ------
--clk ,	rst,	i,ou 

M2:mux2v1 port map (acc,pc,sel_op,o1);--o1=>ram_din); ------
--IN0,In1,Sel,Z

OP1R: reg port map (clk,rst,o1,op1); -----
--clk ,rst,i,ou 

AALU: alu port map (iop,op1,op2,res,oia);  
--op ,i1,i2 , o ,st

INCR: incrementeur port map (pc,inc); -----

RRES: reg port map (clk,rst,res,incresult); -------

M3:mux3v1 port map (inc,incresult,ram_dout,sel_rf,dreg); ------
--in1 ,in2,in3 ,sel ,o

M4:mux2v1 port map(pc,op2,sel_ram,ram_addr);












end arch;
