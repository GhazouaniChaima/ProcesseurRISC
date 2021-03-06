library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu_test is
end alu_test;

architecture arch6 of alu_test is
  signal done   : boolean := false;
  signal passed : boolean := true;
  signal ok     : boolean := true;

  component alu 
    port ( op : in  std_logic_vector(3 downto 0);
           i1 : in  std_logic_vector(15 downto 0);
           i2 : in  std_logic_vector(15 downto 0);
           o  : out std_logic_vector(15 downto 0);
           st : out std_logic_vector(3 downto 0) );
  end component;

  signal op : std_logic_vector(3 downto 0);
  signal i1 : std_logic_vector(15 downto 0);
  signal i2 : std_logic_vector(15 downto 0);
  signal o  : std_logic_vector(15 downto 0);
  signal st : std_logic_vector(3 downto 0);
begin

  alu_0 : alu
    port map ( op => op,
               i1 => i1,
               i2 => i2,
               o  => o,
               st => st );

  -----------------------------------------------------------------------------
  -- Input stimuli
  -----------------------------------------------------------------------------

  process
  begin
    -- AND zncv ---------------------------------------------------------- 0 ns
    op <= "0000";
    i1 <= "1111101011111010";
    i2 <= "0101111101011111";
    wait for 10 ns;
    -- AND zNcv --------------------------------------------------------- 10 ns
    op <= "0000";
    i1 <= "1111010111110101";
    i2 <= "1010111110101111";
    wait for 10 ns;
    -- AND Zncv --------------------------------------------------------- 20 ns
    op <= "0000";
    i1 <= "1010010110100101";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -- OR zncv ---------------------------------------------------------- 30 ns
    op <= "0001";
    i1 <= "0000101000001010";
    i2 <= "0101000001010000";
    wait for 10 ns;
    -- OR zNcv ---------------------------------------------------------- 40 ns
    op <= "0001";
    i1 <= "0000010100000101";
    i2 <= "1010000010100000";
    wait for 10 ns;
    -- OR Zncv ---------------------------------------------------------- 50 ns
    op <= "0001";
    i1 <= "0000000000000000";
    i2 <= "0000000000000000";
    wait for 10 ns;
    -- XOR zncv --------------------------------------------------------- 60 ns
    op <= "0010";
    i1 <= "1111010100000101";
    i2 <= "1010111110100000";
    wait for 10 ns;
    -- XOR zNcv --------------------------------------------------------- 70 ns
    op <= "0010";
    i1 <= "1111101000001010";
    i2 <= "0101111101010000";
    wait for 10 ns;
    -- XOR Zncv --------------------------------------------------------- 80 ns
    op <= "0010";
    i1 <= "0101101001011010";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -- NOT zncv --------------------------------------------------------- 90 ns
    op <= "0011";
    i1 <= "1101111010101101";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- NOT zNcv -------------------------------------------------------- 100 ns
    op <= "0011";
    i1 <= "1101111010101101";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -- NOT Zncv -------------------------------------------------------- 110 ns
    op <= "0011";
    i1 <= "1101111010101101";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- ADD PP zncv ----------------------------------------------------- 120 ns
    op <= "0100";
    i1 <= "0010010110100110";
    i2 <= "0100101001011010";
    wait for 10 ns;
    -- ADD PP zNcV ----------------------------------------------------- 130 ns
    op <= "0100";
    i1 <= "0111111111111111";
    i2 <= "0000000000000001";
    wait for 10 ns;
    -- ADD PP Zncv ----------------------------------------------------- 140 ns
    op <= "0100";
    i1 <= "0000000000000000";
    i2 <= "0000000000000000";
    wait for 10 ns;
    -- ADD PN znCv ----------------------------------------------------- 150 ns
    op <= "0100";
    i1 <= "0111111111111111";
    i2 <= "1101101001011011";
    wait for 10 ns;
    -- ADD PN zNcv ----------------------------------------------------- 160 ns
    op <= "0100";
    i1 <= "0001001011010010";
    i2 <= "1001001011010011";
    wait for 10 ns;
    -- ADD PN ZnCv ----------------------------------------------------- 170 ns
    op <= "0100";
    i1 <= "0111111111111111";
    i2 <= "1000000000000001";
    wait for 10 ns;
    -- ADD NP znCv ----------------------------------------------------- 180 ns
    op <= "0100";
    i1 <= "1101101001011011";
    i2 <= "0111111111111111";
    wait for 10 ns;
    -- ADD NP zNcv ----------------------------------------------------- 190 ns
    op <= "0100";
    i1 <= "1001001011010011";
    i2 <= "0001001011010010";
    wait for 10 ns;
    -- ADD NP ZnCv ----------------------------------------------------- 200 ns
    op <= "0100";
    i1 <= "1000000000000001";
    i2 <= "0111111111111111";
    wait for 10 ns;
    -- ADD NN zNCv ----------------------------------------------------- 210 ns
    op <= "0100";
    i1 <= "1010010110100101";
    i2 <= "1101101001011011";
    wait for 10 ns;
    -- ADD NN znCV ----------------------------------------------------- 220 ns
    op <= "0100";
    i1 <= "1000000000000000";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- SUB PP znCv ----------------------------------------------------- 230 ns
    op <= "0101";
    i1 <= "0111010110100101";
    i2 <= "0001101101001011";
    wait for 10 ns;
    -- SUB PP zNcv ----------------------------------------------------- 240 ns
    op <= "0101";
    i1 <= "0010010110100100";
    i2 <= "0111111111111111";
    wait for 10 ns;
    -- SUB PP ZnCv ----------------------------------------------------- 250 ns
    op <= "0101";
    i1 <= "0101101001011010";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -- SUB PN zncv ----------------------------------------------------- 260 ns
    op <= "0101";
    i1 <= "0010010110100100";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- SUB PN zNcV ----------------------------------------------------- 270 ns
    op <= "0101";
    i1 <= "0111111111111111";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- SUB NP zNCv ----------------------------------------------------- 280 ns
    op <= "0101";
    i1 <= "1010010110100101";
    i2 <= "0000111100001111";
    wait for 10 ns;
    -- SUB NP znCV ----------------------------------------------------- 290 ns
    op <= "0101";
    i1 <= "1000000000000000";
    i2 <= "0000000000000001";
    wait for 10 ns;
    -- SUB NN zNcv ----------------------------------------------------- 300 ns
    op <= "0101";
    i1 <= "1000000000000000";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- SUB NN znCv ----------------------------------------------------- 310 ns
    op <= "0101";
    i1 <= "1101101001011010";
    i2 <= "1000000000000000";
    wait for 10 ns;
    -- SUB NN ZnCv ----------------------------------------------------- 320 ns
    op <= "0101";
    i1 <= "1010010110100101";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- LSL P zncv ------------------------------------------------------ 330 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "0000000000000100";
    wait for 10 ns;
    -- LSL P zNcV ------------------------------------------------------ 340 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "0000000000001000";
    wait for 10 ns;
    -- LSL P znCv ------------------------------------------------------ 350 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "0000000000001100";
    wait for 10 ns;
    -- LSL P ZnCv ------------------------------------------------------ 360 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "0000000000010000";
    wait for 10 ns;
    -- LSL N zncv ------------------------------------------------------ 370 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "1111111111111100";
    wait for 10 ns;
    -- LSL N zncV ------------------------------------------------------ 380 ns
    op <= "0110";
    i1 <= "1010010100000000";
    i2 <= "1111111111111100";
    wait for 10 ns;
    -- LSL N Zncv ------------------------------------------------------ 390 ns
    op <= "0110";
    i1 <= "0000000010100101";
    i2 <= "1111111111111000";
    wait for 10 ns;
    -- LSR P zncv ------------------------------------------------------ 400 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "0000000000000100";
    wait for 10 ns;
    -- LSR P zncV ------------------------------------------------------ 410 ns
    op <= "0111";
    i1 <= "1010010100000000";
    i2 <= "0000000000000100";
    wait for 10 ns;
    -- LSR P Zncv ------------------------------------------------------ 420 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "0000000000001000";
    wait for 10 ns;
    -- LSR N zncv ------------------------------------------------------ 430 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "1111111111111100";
    wait for 10 ns;
    -- LSR N zNcV ------------------------------------------------------ 440 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "1111111111111000";
    wait for 10 ns;
    -- LSR N znCv ------------------------------------------------------ 450 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "1111111111110100";
    wait for 10 ns;
    -- LSR N ZnCv ------------------------------------------------------ 460 ns
    op <= "0111";
    i1 <= "0000000010100101";
    i2 <= "1111111111110000";
    wait for 10 ns;
    -- MTA zncv -------------------------------------------------------- 470 ns
    op <= "1010";
    i1 <= "1111111111111111";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -- MTA zNcv -------------------------------------------------------- 480 ns
    op <= "1010";
    i1 <= "1111111111111111";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- MTA Zncv -------------------------------------------------------- 490 ns
    op <= "1010";
    i1 <= "1111111111111111";
    i2 <= "0000000000000000";
    wait for 10 ns;
    -- MTR zncv -------------------------------------------------------- 500 ns
    op <= "1011";
    i1 <= "0101101001011010";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- MTR zNcv -------------------------------------------------------- 510 ns
    op <= "1011";
    i1 <= "1010010110100101";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- MTR Zncv -------------------------------------------------------- 520 ns
    op <= "1011";
    i1 <= "0000000000000000";
    i2 <= "1111111111111111";
    wait for 10 ns;
    -- JRP P ----------------------------------------------------------- 530 ns
    op <= "1100";
    i1 <= "0010010110100110";
    i2 <= "0100101001011010";
    wait for 10 ns;
    -- JRP N ----------------------------------------------------------- 540 ns
    op <= "1100";
    i1 <= "0111111111111111";
    i2 <= "1101101001011011";
    wait for 10 ns;
    -- JRN P ----------------------------------------------------------- 550 ns
    op <= "1101";
    i1 <= "0111010110100101";
    i2 <= "0001101101001011";
    wait for 10 ns;
    -- JRN N ----------------------------------------------------------- 560 ns
    op <= "1101";
    i1 <= "0010010110100100";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- JPR ------------------------------------------------------------- 570 ns
    op <= "1110";
    i1 <= "1111111111111111";
    i2 <= "1010010110100101";
    wait for 10 ns;
    -- CAL ------------------------------------------------------------- 580 ns
    op <= "1111";
    i1 <= "1111111111111111";
    i2 <= "0101101001011010";
    wait for 10 ns;
    -------------------------------------------------------------------- 590 ns
    op <= "UUUU";
    i1 <= "UUUUUUUUUUUUUUUU";
    i2 <= "UUUUUUUUUUUUUUUU";
    wait;
  end process;

  -----------------------------------------------------------------------------
  -- Output verification
  -----------------------------------------------------------------------------

  process
  begin
    wait for 1 ns;
    -- AND zncv ---------------------------------------------------------- 1 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0000");
    wait for 10 ns;
    -- AND zNcv --------------------------------------------------------- 11 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- AND Zncv --------------------------------------------------------- 21 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- OR zncv ---------------------------------------------------------- 31 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0000");
    wait for 10 ns;
    -- OR zNcv ---------------------------------------------------------- 41 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- OR Zncv ---------------------------------------------------------- 51 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- XOR zncv --------------------------------------------------------- 61 ns
    ok <= (o  = "0101101010100101") and
          (st =  "0000");
    wait for 10 ns;
    -- XOR zNcv --------------------------------------------------------- 71 ns
    ok <= (o  = "1010010101011010") and
          (st =  "0100");
    wait for 10 ns;
    -- XOR Zncv --------------------------------------------------------- 81 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- NOT zncv --------------------------------------------------------- 91 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0000");
    wait for 10 ns;
    -- NOT zNcv -------------------------------------------------------- 101 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- NOT Zncv -------------------------------------------------------- 111 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- ADD PP zncv ----------------------------------------------------- 121 ns
    ok <= (o  = "0111000000000000") and
          (st =  "0000");
    wait for 10 ns;
    -- ADD PP zNcV ----------------------------------------------------- 131 ns
    ok <= (o  = "1000000000000000") and
          (st =  "0101");
    wait for 10 ns;
    -- ADD PP Zncv ----------------------------------------------------- 141 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- ADD PN znCv ----------------------------------------------------- 151 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0010");
    wait for 10 ns;
    -- ADD PN zNcv ----------------------------------------------------- 161 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- ADD PN ZnCv ----------------------------------------------------- 171 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- ADD NP znCv ----------------------------------------------------- 181 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0010");
    wait for 10 ns;
    -- ADD NP zNcv ----------------------------------------------------- 191 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- ADD NP ZnCv ----------------------------------------------------- 201 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- ADD NN zNCv ----------------------------------------------------- 211 ns
    ok <= (o  = "1000000000000000") and
          (st =  "0110");
    wait for 10 ns;
    -- ADD NN znCV ----------------------------------------------------- 221 ns
    ok <= (o  = "0111111111111111") and
          (st =  "0011");
    wait for 10 ns;
    -- SUB PP znCv ----------------------------------------------------- 231 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0010");
    wait for 10 ns;
    -- SUB PP zNcv ----------------------------------------------------- 241 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- SUB PP ZnCv ----------------------------------------------------- 251 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- SUB PN zncv ----------------------------------------------------- 261 ns
    ok <= (o  = "0111111111111111") and
          (st =  "0000");
    wait for 10 ns;
    -- SUB PN zNcV ----------------------------------------------------- 271 ns
    ok <= (o  = "1000000000000000") and
          (st =  "0101");
    wait for 10 ns;
    -- SUB NP zNCv ----------------------------------------------------- 281 ns
    ok <= (o  = "1001011010010110") and
          (st =  "0110");
    wait for 10 ns;
    -- SUB NP znCV ----------------------------------------------------- 291 ns
    ok <= (o  = "0111111111111111") and
          (st =  "0011");
    wait for 10 ns;
    -- SUB NN zNcv ----------------------------------------------------- 301 ns
    ok <= (o  = "1101101001011011") and
          (st =  "0100");
    wait for 10 ns;
    -- SUB NN znCv ----------------------------------------------------- 311 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0010");
    wait for 10 ns;
    -- SUB NN ZnCv ----------------------------------------------------- 321 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- LSL P zncv ------------------------------------------------------ 331 ns
    ok <= (o  = "0000101001010000") and
          (st =  "0000");
    wait for 10 ns;
    -- LSL P zNcV ------------------------------------------------------ 341 ns
    ok <= (o  = "1010010100000000") and
          (st =  "0101");
    wait for 10 ns;
    -- LSL P znCv ------------------------------------------------------ 351 ns
    ok <= (o  = "0101000000000000") and
          (st =  "0010");
    wait for 10 ns;
    -- LSL P ZnCv ------------------------------------------------------ 361 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- LSL N zncv ------------------------------------------------------ 371 ns
    ok <= (o  = "0000000000001010") and
          (st =  "0000");
    wait for 10 ns;
    -- LSL N zncV ------------------------------------------------------ 381 ns
    ok <= (o  = "0000101001010000") and
          (st =  "0001");
    wait for 10 ns;
    -- LSL N Zncv ------------------------------------------------------ 391 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- LSR P zncv ------------------------------------------------------ 401 ns
    ok <= (o  = "0000000000001010") and
          (st =  "0000");
    wait for 10 ns;
    -- LSR P zncV ------------------------------------------------------ 411 ns
    ok <= (o  = "0000101001010000") and
          (st =  "0001");
    wait for 10 ns;
    -- LSR P Zncv ------------------------------------------------------ 421 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- LSR N zncv ------------------------------------------------------ 431 ns
    ok <= (o  = "0000101001010000") and
          (st =  "0000");
    wait for 10 ns;
    -- LSR N zNcV ------------------------------------------------------ 441 ns
    ok <= (o  = "1010010100000000") and
          (st =  "0101");
    wait for 10 ns;
    -- LSR N znCv ------------------------------------------------------ 451 ns
    ok <= (o  = "0101000000000000") and
          (st =  "0010");
    wait for 10 ns;
    -- LSR N ZnCv ------------------------------------------------------ 461 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1010");
    wait for 10 ns;
    -- MTA zncv -------------------------------------------------------- 471 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0000");
    wait for 10 ns;
    -- MTA zncv -------------------------------------------------------- 481 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- MTA zncv -------------------------------------------------------- 491 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- MTR zncv -------------------------------------------------------- 501 ns
    ok <= (o  = "0101101001011010") and
          (st =  "0000");
    wait for 10 ns;
    -- MTR zncv -------------------------------------------------------- 511 ns
    ok <= (o  = "1010010110100101") and
          (st =  "0100");
    wait for 10 ns;
    -- MTR zncv -------------------------------------------------------- 521 ns
    ok <= (o  = "0000000000000000") and
          (st =  "1000");
    wait for 10 ns;
    -- JRP P ----------------------------------------------------------- 531 ns
    ok <= (o  = "0111000000000000");
    wait for 10 ns;
    -- JRP N ----------------------------------------------------------- 541 ns
    ok <= (o  = "0101101001011010");
    wait for 10 ns;
    -- JRN P ----------------------------------------------------------- 551 ns
    ok <= (o  = "0101101001011010");
    wait for 10 ns;
    -- JRN N ----------------------------------------------------------- 561 ns
    ok <= (o  = "0111111111111111");
    wait for 10 ns;
    -- JPR ------------------------------------------------------------- 571 ns
    ok <= (o  = "1010010110100101");
    wait for 10 ns;
    -- CAL ------------------------------------------------------------- 581 ns
    ok <= (o  = "0101101001011010");
    wait for 10 ns;
    -------------------------------------------------------------------- 591 ns
    -- ok   <= true;
    done <= true;
    wait;
  end process;

  --passed <= passed and ok;
   passed <= done and ok;
end arch6;
