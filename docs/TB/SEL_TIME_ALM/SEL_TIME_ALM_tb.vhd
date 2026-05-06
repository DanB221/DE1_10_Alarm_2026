library ieee;
use ieee.std_logic_1164.all;

entity tb_SEL_TIME is
end entity tb_SEL_TIME;

architecture tb of tb_SEL_TIME is

    -- Signály pro propojení s UUT
    signal s_CLK    : std_logic := '0';
    signal s_RST    : std_logic := '0';
    signal s_BTNU   : std_logic := '0';
    signal s_BTND   : std_logic := '0';
    signal s_BTNC   : std_logic := '0';

    signal s_BTNU_H : std_logic;
    signal s_BTND_H : std_logic;
    signal s_BTNU_M : std_logic;
    signal s_BTND_M : std_logic;
    signal s_BTNU_S : std_logic;
    signal s_BTND_S : std_logic;
    signal s_STAV   : std_logic_vector(1 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instance testovaného bloku
    uut: entity work.SEL_TIME
        port map (
            CLK    => s_CLK,
            RST    => s_RST,
            BTNU   => s_BTNU,
            BTND   => s_BTND,
            BTNC   => s_BTNC,
            BTNU_H => s_BTNU_H,
            BTND_H => s_BTND_H,
            BTNU_M => s_BTNU_M,
            BTND_M => s_BTND_M,
            BTNU_S => s_BTNU_S,
            BTND_S => s_BTND_S,
            STAV   => s_STAV
        );

    -- Generátor hodin
    s_CLK <= not s_CLK after CLK_PERIOD / 2;

    -- Stimulus proces
    p_stimulus : process
    begin
        -- 1. Reset
        s_RST <= '1';
        wait for 25 ns;
        s_RST <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- STAV_H (Default po resetu, STAV="01")
        -----------------------------------------------------------
        report "Testovani stavu HODINY";
        s_BTNU <= '1'; wait for 20 ns; -- Mělo by aktivovat BTNU_H
        s_BTNU <= '0';
        s_BTND <= '1'; wait for 20 ns; -- Mělo by aktivovat BTND_H
        s_BTND <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- Přepnutí na STAV_M (STAV="10")
        -----------------------------------------------------------
        report "Prepinam na MINUTY";
        s_BTNC <= '1'; wait for 20 ns; -- Náběžná hrana
        s_BTNC <= '0'; wait for 20 ns;
        
        s_BTNU <= '1'; wait for 20 ns; -- Mělo by aktivovat BTNU_M
        s_BTNU <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- Přepnutí na STAV_S (STAV="11")
        -----------------------------------------------------------
        report "Prepinam na SEKUNDY";
        s_BTNC <= '1'; wait for 20 ns;
        s_BTNC <= '0'; wait for 20 ns;
        
        s_BTND <= '1'; wait for 20 ns; -- Mělo by aktivovat BTND_S
        s_BTND <= '0';
        wait for 20 ns;

        -----------------------------------------------------------
        -- Přepnutí zpět na STAV_H (cyklus)
        -----------------------------------------------------------
        report "Prepinam zpet na HODINY";
        s_BTNC <= '1'; wait for 20 ns;
        s_BTNC <= '0'; wait for 20 ns;
        
        -- Ověření, že jsme zpět v H
        if s_STAV = "01" then
            report "Navrat do stavu H uspesny.";
        end if;

        -----------------------------------------------------------
        -- Test resetu uprostřed práce
        -----------------------------------------------------------
        s_BTNC <= '1'; wait for 20 ns; -- Jsme v M
        s_BTNC <= '0';
        s_RST  <= '1'; wait for 20 ns;
        s_RST  <= '0'; -- Po resetu musíme být v H (STAV="01")

        wait for 50 ns;
        report "Simulace SEL_TIME dokoncena.";
        wait;
    end process;

end architecture tb;
