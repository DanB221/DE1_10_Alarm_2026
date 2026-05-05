library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity driver_tb is
-- Testbench nema porty
end entity driver_tb;

architecture sim of driver_tb is

    -- Signaly pro propojeni s UUT
    signal clk_tb       : std_logic := '0';
    signal rst_tb       : std_logic := '0';
    signal buzz_in_tb   : std_logic := '0';
    signal driv_buzz_tb : std_logic;

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz

begin

    -- Instance UUT
    UUT: entity work.driver
        port map (
            CLK       => clk_tb,
            RST       => rst_tb,
            buzz_in   => buzz_in_tb,
            driv_buzz => driv_buzz_tb
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
        -- 1. Inicializace a Reset
        rst_tb <= '1';
        buzz_in_tb <= '0';
        wait for 40 ns;
        rst_tb <= '0';
        wait for 40 ns;

        -- 2. Aktivace bzucaku
        report "Aktivuji buzz_in. Sledujte driv_buzz (ton 2kHz)." severity note;
        buzz_in_tb <= '1';
        
        -- Abychom videli ton (2 kHz = perioda 0.5 ms)
        -- Cekame 1 ms, abychom videli alespon dve periody tonu
        wait for 10 us; 

        -- 3. Vypnuti bzucaku uprostred cyklu
        buzz_in_tb <= '0';
        wait for 100 us;
        
        -- 4. Test prerusovaneho pipani (300 ms on / 300 ms off)
        -- POZOR: V simulaci 300 ms trva velmi dlouho. 
        -- Pokud chcete videt prepnuti phase_state, doporucuji v driver.vhd
        -- docasne zmenit konstantu C_300MS na mensi (napr. 30000).
        buzz_in_tb <= '1';
        
        -- Cekame na prepnuti faze (pokud jste zmensili konstantu)
        wait for 1 ms; 

        -- Konec simulace
        report "Simulace ukoncena. Overte frekvenci tonu na vystupu driv_buzz." severity note;
        wait;
    end process;

end architecture sim;
