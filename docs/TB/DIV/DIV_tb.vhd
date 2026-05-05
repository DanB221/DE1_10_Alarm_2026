library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DIV_tb is
-- Testbench nema porty
end entity DIV_tb;

architecture sim of DIV_tb is

    -- Signaly pro propojeni s UUT
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    signal stav_tb   : std_logic_vector(1 downto 0) := "00";
    signal h_tb      : std_logic_vector(5 downto 0) := (others => '0');
    signal m_tb      : std_logic_vector(5 downto 0) := (others => '0');
    signal s_tb      : std_logic_vector(5 downto 0) := (others => '0');
    signal o_f_tb    : std_logic_vector(3 downto 0) := "0000";

    signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instance UUT
    UUT: entity work.DIV
        port map (
            CLK    => clk_tb,
            RST    => rst_tb,
            STAV   => stav_tb,
            H      => h_tb,
            M      => m_tb,
            S      => s_tb,
            O_F    => o_f_tb,
            digit0 => d0,
            digit1 => d1,
            digit2 => d2,
            digit3 => d3,
            digit4 => d4,
            digit5 => d5,
            digit6 => d6,
            digit7 => d7
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

        -- 2. Test rozkladu cislic (Cas 23:59:08, O_F = 4)
        h_tb   <= std_logic_vector(to_unsigned(23, 6));
        m_tb   <= std_logic_vector(to_unsigned(59, 6));
        s_tb   <= std_logic_vector(to_unsigned(8, 6));
        o_f_tb <= "0100"; -- Hodnota 4 na poslednim digit-u
        stav_tb <= "00";  -- Bez blikani
        wait for 40 ns;

        -- 3. Test blikani HODIN (STAV 01)
        -- Poznamka: V realne simulaci byste museli pockat 25 milionu taktu.
        -- Pro test doporucuji v kodu DIV docasne zmensit blink_cnt limit.
        stav_tb <= "01";
        report "Testovani blikani hodin (STAV 01)" severity note;
        wait for 100 ns;

        -- 4. Test blikani MINUT (STAV 10)
        stav_tb <= "10";
        report "Testovani blikani minut (STAV 10)" severity note;
        wait for 100 ns;

        -- 5. Test blikani SEKUND (STAV 11)
        stav_tb <= "11";
        report "Testovani blikani sekund (STAV 11)" severity note;
        wait for 100 ns;

        -- 6. Zmena casu za behu
        h_tb <= std_logic_vector(to_unsigned(12, 6));
        m_tb <= std_logic_vector(to_unsigned(34, 6));
        wait for 40 ns;

        -- Ukonceni
        report "Simulace hotova. Pro overeni blikani upravte konstantu v DIV." severity note;
        wait;
    end process;

end architecture sim;
