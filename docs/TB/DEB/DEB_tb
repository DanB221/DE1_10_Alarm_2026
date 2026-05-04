library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_DEB is
-- Testbench nemá porty
end tb_DEB;

architecture test of tb_DEB is

    -- Konštanty pre simuláciu
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
    
    -- Signály pre prepojenie s komponentom
    signal s_clk     : std_logic := '0';
    signal s_rst     : std_logic := '1'; -- Začíname v resete
    signal s_BTNU    : std_logic := '0';
    signal s_BTND    : std_logic := '0';
    signal s_BTNC    : std_logic := '0';
    signal s_BTNU_d  : std_logic;
    signal s_BTND_d  : std_logic;
    signal s_BTNC_d  : std_logic;

begin

    -- Inštancia testovaného bloku (UUT)
    uut: entity work.DEB
        generic map (
            C_MAX => 4 -- EXTRÉMNE DÔLEŽITÉ: Pre simuláciu nastavujeme malý čítač
        )
        port map (
            CLK    => s_clk,
            RST    => s_rst,
            BTNU   => s_BTNU,
            BTND   => s_BTND,
            BTNC   => s_BTNC,
            BTNU_d => s_BTNU_d,
            BTND_d => s_BTND_d,
            BTNC_d => s_BTNC_d
        );

    -- Generátor hodín (100 MHz)
    s_clk <= not s_clk after CLK_PERIOD / 2;

    -- Stimulus proces
    p_stimulus : process
    begin
        -- 1. Reset fáza
        s_rst <= '1';
        wait for 45 ns;
        s_rst <= '0';
        wait for 20 ns;

        ------------------------------------------------------------
        -- SCENÁR 1: BTNU - Rýchle zákmity (Debouncer ich musí ignorovať)
        ------------------------------------------------------------
        -- Stláčame BTNU, ale signál kmitá príliš rýchlo
        s_BTNU <= '1'; wait for 20 ns; 
        s_BTNU <= '0'; wait for 20 ns;
        s_BTNU <= '1'; wait for 30 ns;
        s_BTNU <= '0'; wait for 50 ns;
        -- Výsledok: s_BTNU_d by mal zostať na '0'
        
        ------------------------------------------------------------
        -- SCENÁR 2: BTND - Platné stlačenie a uvoľnenie
        ------------------------------------------------------------
        -- Stlačenie (signál držíme dlho)
        s_BTND <= '1'; 
        wait for 300 ns; -- Dosť času na naplnenie shift registra (4 * C_MAX taktov)
        
        -- Uvoľnenie
        s_BTND <= '0';
        wait for 200 ns;

        ------------------------------------------------------------
        -- SCENÁR 3: BTNC - Súbežné stlačenie s BTNU
        ------------------------------------------------------------
        s_BTNU <= '1';
        s_BTNC <= '1';
        wait for 400 ns;
        s_BTNU <= '0';
        s_BTNC <= '0';

        ------------------------------------------------------------
        -- SCENÁR 4: Reset počas stlačenia
        ------------------------------------------------------------
        s_BTND <= '1';
        wait for 200 ns;
        s_rst  <= '1'; -- Aktivujeme reset uprostred práce
        wait for 100 ns;
        s_rst  <= '0';
        s_BTND <= '0';

        wait for 200 ns;
        report "Simulacia uspesne dokoncena";
        wait;
    end process;

end architecture;
