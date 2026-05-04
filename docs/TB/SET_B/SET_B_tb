library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_SET_B is
-- Testbench nemá porty
end entity tb_SET_B;

architecture test of tb_SET_B is

    -- Signály pro propojení s UUT
    signal s_SW1        : std_logic := '0';
    signal s_SW2        : std_logic := '0';
    signal s_STAV_TIME  : std_logic_vector(1 downto 0) := "01"; -- Simulujeme stav 'Time'
    signal s_STAV_ALM   : std_logic_vector(1 downto 0) := "10"; -- Simulujeme stav 'Alarm'

    signal s_HH         : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(12, 6)); -- 12 hodin
    signal s_MM         : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(30, 6)); -- 30 minut
    signal s_SS         : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(45, 6)); -- 45 sekund

    signal s_HH_A       : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(06, 6)); -- 06 hodin (budík)
    signal s_MM_A       : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(15, 6)); -- 15 minut (budík)
    signal s_SS_A       : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(00, 6)); -- 00 sekund (budík)

    signal s_STAV       : std_logic_vector(1 downto 0);
    signal s_H          : std_logic_vector(5 downto 0);
    signal s_M          : std_logic_vector(5 downto 0);
    signal s_S          : std_logic_vector(5 downto 0);

begin

    -- Instance UUT
    uut: entity work.SET_B
        port map (
            SW1       => s_SW1,
            SW2       => s_SW2,
            STAV_TIME => s_STAV_TIME,
            STAV_ALM  => s_STAV_ALM,
            HH        => s_HH,
            MM        => s_MM,
            SS        => s_SS,
            HH_A      => s_HH_A,
            MM_A      => s_MM_A,
            SS_A      => s_SS_A,
            STAV      => s_STAV,
            H         => s_H,
            M         => s_M,
            S         => s_S
        );

    -- Stimulus proces
    p_stimulus : process
    begin
        report "Zahajeni simulace SET_B";

        -----------------------------------------------------------
        -- KOMBINAČNÍ TEST 1: SW = "00" (Defaultní čas)
        -----------------------------------------------------------
        s_SW1 <= '0'; s_SW2 <= '0';
        wait for 50 ns;
        -- Očekáváme: H=12, M=30, S=45, STAV=00

        -----------------------------------------------------------
        -- KOMBINAČNÍ TEST 2: SW = "10" (Režim ALARM)
        -----------------------------------------------------------
        s_SW1 <= '1'; s_SW2 <= '0';
        wait for 50 ns;
        -- Očekáváme: H=06, M=15, S=00, STAV=10 (STAV_ALM)

        -----------------------------------------------------------
        -- KOMBINAČNÍ TEST 3: SW = "01" (Režim TIME SETTING/HODINY)
        -----------------------------------------------------------
        s_SW1 <= '0'; s_SW2 <= '1';
        wait for 50 ns;
        -- Očekáváme: H=12, M=30, S=45 (podle kódu), STAV=01 (STAV_TIME)

        -----------------------------------------------------------
        -- KOMBINAČNÍ TEST 4: SW = "11" (Nedefinovaný režim)
        -----------------------------------------------------------
        s_SW1 <= '1'; s_SW2 <= '1';
        wait for 50 ns;
        -- Očekáváme: H=12 (else větev), STAV=00 (else větev)

        -----------------------------------------------------------
        -- DYNAMICKÝ TEST: Změna času za běhu v režimu Alarm
        -----------------------------------------------------------
        s_SW1 <= '1'; s_SW2 <= '0'; -- Zpět na alarm
        wait for 10 ns;
        s_HH_A <= std_logic_vector(to_unsigned(23, 6)); -- Změna budíku na 23h
        wait for 40 ns;
        -- Očekáváme: H se okamžitě změní na 23

        report "Simulace SET_B uspesne dokoncena";
        wait;
    end process;

end architecture test;
