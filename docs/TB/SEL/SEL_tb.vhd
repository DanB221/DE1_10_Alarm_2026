library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SEL_tb is
-- Testbench nema porty
end entity SEL_tb;

architecture sim of SEL_tb is

    -- Signaly pro propojeni s UUT
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    
    -- Vstupni digity (nastavime ruzne hodnoty pro kontrolu)
    signal d0_tb : std_logic_vector(3 downto 0) := "0000"; -- 0
    signal d1_tb : std_logic_vector(3 downto 0) := "0001"; -- 1
    signal d2_tb : std_logic_vector(3 downto 0) := "0010"; -- 2
    signal d3_tb : std_logic_vector(3 downto 0) := "0011"; -- 3
    signal d4_tb : std_logic_vector(3 downto 0) := "0100"; -- 4
    signal d5_tb : std_logic_vector(3 downto 0) := "0101"; -- 5
    signal d6_tb : std_logic_vector(3 downto 0) := "0110"; -- 6
    signal d7_tb : std_logic_vector(3 downto 0) := "0111"; -- 7

    -- Vystupy
    signal seg_tb    : std_logic_vector(3 downto 0);
    signal an_seg_tb : std_logic_vector(7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instance UUT
    UUT: entity work.SEL
        port map (
            CLK    => clk_tb,
            RST    => rst_tb,
            digit0 => d0_tb,
            digit1 => d1_tb,
            digit2 => d2_tb,
            digit3 => d3_tb,
            digit4 => d4_tb,
            digit5 => d5_tb,
            digit6 => d6_tb,
            digit7 => d7_tb,
            seg    => seg_tb,
            an_seg => an_seg_tb
        );

    -- Generator hodin
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
        wait for 20 ns;
        rst_tb <= '0';
        wait for 20 ns;

        -- 2. Sledovani prepinani digitů
        -- POZOR: V realnem kodu se digit prepne jednou za 100 000 taktu.
        -- Pro potreby simulace doporucuji v souboru SEL.vhd docasne prepsat:
        -- if refresh_cnt = 10 - 1 then
        
        report "Zacinam sledovat prepinani anod a segmentu..." severity note;
        
        -- Pockame na par cyklu refresh_cnt (pokud je limit maly)
        -- Pokud limit v SEL.vhd nezmenite, musite zde pockat miliony ns:
        -- wait for 10 ms; 
        
        wait for CLK_PERIOD * 100; -- Zakladni kontrola stability

        -- 3. Zmena vstupnich dat za behu
        -- Overime, ze kdyz se zmeni vstup, projevi se to na vystupu 'seg' 
        -- az v momentě, kdy je aktivni dana anoda.
        d0_tb <= "1111"; -- F
        d7_tb <= "1010"; -- A
        
        wait for CLK_PERIOD * 100;

        report "Simulace ukoncena. Zkontrolujte, zda anody rotuji (01111111 -> 10111111 atd.)." severity note;
        wait;
    end process;

end architecture sim;
