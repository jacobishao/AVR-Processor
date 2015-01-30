----------------------------------------------------------------------------
--
--  Atmel AVR Register Array Test Bench
--
--  Revision History:
--      01/25/15    Peter Cuy       initial version
--
----------------------------------------------------------------------------
-- bring in the necessary packages
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;       --contains conversion functions

library opcodes;
use opcodes.opcodes.all;

library ALUCommands;
use ALUCommands.ALUCommands.all;

entity REG_TEST_TB is
end REG_TEST_TB;

architecture TB_ARCHITECTURE of REG_TEST_TB is 
    component REG_TEST
        port (
            IR       :  in  opcode_word;                        -- Instruction Register
            RegIn    :  in  std_logic_vector(7 downto 0);       -- input register bus
            clock    :  in  std_logic;                          -- system clock
            RegAOut  :  out std_logic_vector(7 downto 0);       -- register bus A out
            RegBOut  :  out std_logic_vector(7 downto 0)  
        );
    end component;
    
    signal IR           :   opcode_word;                        -- Instruction Register
    signal RegIn        :   std_logic_vector(7 downto 0);       -- input register bus
    signal clock        :   std_logic;                          -- system clock
    signal RegAOut      :   std_logic_vector(7 downto 0);       -- register bus A out
    signal RegBOut      :   std_logic_vector(7 downto 0);
    
    signal  END_SIM     :  BOOLEAN := FALSE;                   -- end simulation flag

begin
    UUT : REG_TEST
        port map(
            IR      =>  IR     , 
            RegIn   =>  RegIn  , 
            clock   =>  clock  , 
            RegAOut =>  RegAOut, 
            RegBOut =>  RegBOut 
        );
    
    -- Main testing procedure
    process
    begin
        
        -- Testing: CPC
        IR <= "0000011000111110";
        wait for 10 ns;
        assert(RegAOut = "00000000");
        assert(RegBOut = "00000000");
        RegIn <= "10000100";
        wait for 10 ns;


        -- Testing: ADC
        IR <= "0001111011000110";
        wait for 10 ns;
        assert(RegAOut = "00000000");
        assert(RegBOut = "00000000");
        RegIn <= "10101110";
        wait for 10 ns;
        
        END_SIM <= TRUE;    --end of stimulus events
        wait;               --wait for the simulation to end
    end process;
    
    -- Clock process definitions
    CLOCK_CLK : process
    begin
        -- this process generates a 20 ns period, 50% duty cycle clock
        -- only generate clock if still simulating
        if end_sim = false then
            clock <= '0';
            wait for 10 ns;
        else
            wait;
        end if;
  
        if end_sim = false then
            clock <= '1';
            wait for 10 ns;
        else
            wait;
        end if;
   end process;
end TB_ARCHITECTURE;





