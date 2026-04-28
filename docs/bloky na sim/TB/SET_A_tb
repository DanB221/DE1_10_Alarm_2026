library ieee;
use ieee.std_logic_1164.all;

entity tb_SET_A is
-- Testbench nemá porty
end entity tb_SET_A;

architecture test of tb_SET_A is

    -- Signály pro propojení s UUT (Unit Under Test)
    signal s_BTNU   : std_logic := '0';
    signal s_BTND   : std_logic := '0';
    signal s_BTNC   : std_logic := '0';
    signal s_SW1    : std_logic := '0';
    signal s_SW2    : std_logic := '0';

    signal s_BTNC_C : std_logic;
    signal s_BTNU_H : std_logic;
    signal s_BTND_H : std_logic;
    signal s_BTNC_H : std_logic;
    signal s_BTNU_A : std_logic;
    signal s_BTND_A : std_logic;
    signal s_BTNC_A : std_logic;

begin

    -- Instance testovaného bloku
    uut: entity work.SET_A
        port map (
            BTNU   => s_BTNU,
            BTND   => s_BTND,
            BTNC   => s_BTNC,
            SW1    => s_SW1,
            SW2    => s_SW2,
            BTNC_C => s_BTNC_C,
            BTNU_H => s_BTNU_H,
            BTND_H => s_BTND_H,
            BTNC_H => s_BTNC_H,
            BTNU_A => s_BTNU_A,
            BTND_A => s_BTND_A,
            BTNC_A => s_BTNC_A
        );

    -- Stimulus proces: Testování všech kombinací SW s aktivací všech tlačítek
    p_stimulus : process
    begin
        -- Inicializace
        s_BTNU <= '0'; s_BTND <= '0'; s_BTNC <= '0';
        s_SW1  <= '0'; s_SW2  <= '0';
        wait for 40 ns;

        -----------------------------------------------------------
        -- 1. REŽIM C (00): Očekáváme aktivní jen BTNC_C
        -----------------------------------------------------------
        s_SW1 <= '0'; s_SW2 <= '0';
        wait for 10 ns;
        s_BTNU <= '1'; s_BTND <= '1'; s_BTNC <= '1'; -- Zmáčknout vše
        wait for 40 ns;
        s_BTNU <= '0'; s_BTND <= '0'; s_BTNC <= '0'; -- Pustit vše
        wait for 20 ns;

        -----------------------------------------------------------
        -- 2. REŽIM A (10): Očekáváme BTNU_A, BTND_A, BTNC_A
        -----------------------------------------------------------
        s_SW1 <= '1'; s_SW2 <= '0';
        wait for 10 ns;
        s_BTNU <= '1'; s_BTND <= '1'; s_BTNC <= '1';
        wait for 40 ns;
        s_BTNU <= '0'; s_BTND <= '0'; s_BTNC <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- 3. REŽIM H (01): Očekáváme BTNU_H, BTND_H, BTNC_H
        -----------------------------------------------------------
        s_SW1 <= '0'; s_SW2 <= '1';
        wait for 10 ns;
        s_BTNU <= '1'; s_BTND <= '1'; s_BTNC <= '1';
        wait for 40 ns;
        s_BTNU <= '0'; s_BTND <= '0'; s_BTNC <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- 4. REŽIM "Nic" (11): Všechny výstupy musí zůstat '0'
        -----------------------------------------------------------
        s_SW1 <= '1'; s_SW2 <= '1';
        wait for 10 ns;
        s_BTNU <= '1'; s_BTND <= '1'; s_BTNC <= '1';
        wait for 40 ns;
        s_BTNU <= '0'; s_BTND <= '0'; s_BTNC <= '0';
        wait for 20 ns;

        report "Kompletni test vsech kombinaci dokoncen";
        wait;
    end process;

end architecture test;
