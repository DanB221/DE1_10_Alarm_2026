library ieee;
use ieee.std_logic_1164.all;

entity clk_en_tb is
-- Testbench nemá porty
end entity clk_en_tb;

architecture sim of clk_en_tb is

    -- Signály pro propojení
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal ce_tb  : std_logic;

    -- Definice periody (100 MHz)
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instance UUT s malým G_MAX pro simulaci
    UUT: entity work.clk_en
        generic map (
            G_MAX => 5  -- Impuls přijde po každých 5 taktech
        )
        port map (
            clk => clk_tb,
            rst => rst_tb,
            ce  => ce_tb
        );

    -- Generátor hodin
    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- 1. Reset
        rst_tb <= '1';
        wait for CLK_PERIOD * 2;
        rst_tb <= '0';
        wait for CLK_PERIOD;

        -- 2. Sledování výstupů
        -- Čekáme, až ce skočí do log. 1
        wait until ce_tb = '1';
        report "CE impuls detekovan v poradku." severity note;
        
        -- Počkáme na další impuls, abychom viděli periodicitu
        wait until ce_tb = '1';
        report "Druhy CE impuls detekovan. Delicka funguje." severity note;

        -- 3. Test resetu za běhu
        wait for CLK_PERIOD * 2;
        rst_tb <= '1';
        wait for CLK_PERIOD;
        rst_tb <= '0';

        wait for CLK_PERIOD * 10;
        
        report "Simulace ukoncena." severity note;
        wait;
    end process;

end architecture sim;
