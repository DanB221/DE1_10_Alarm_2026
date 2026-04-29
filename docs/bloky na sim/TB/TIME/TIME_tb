library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_TIME is
end tb_TIME;

architecture tb of tb_TIME is

    component CLOCK_TIME
        port (CLK    : in std_logic;
              RST    : in std_logic;
              clk_en : in std_logic;
              BTNU_H : in std_logic;
              BTND_H : in std_logic;
              BTNU_M : in std_logic;
              BTND_M : in std_logic;
              BTNU_S : in std_logic;
              BTND_S : in std_logic;
              HH     : out std_logic_vector (5 downto 0);
              MM     : out std_logic_vector (5 downto 0);
              SS     : out std_logic_vector (5 downto 0));
    end component;

    signal CLK    : std_logic;
    signal RST    : std_logic;
    signal clk_en : std_logic;
    signal BTNU_H : std_logic;
    signal BTND_H : std_logic;
    signal BTNU_M : std_logic;
    signal BTND_M : std_logic;
    signal BTNU_S : std_logic;
    signal BTND_S : std_logic;
    signal HH     : std_logic_vector (5 downto 0);
    signal MM     : std_logic_vector (5 downto 0);
    signal SS     : std_logic_vector (5 downto 0);

    constant TbPeriod : time := 10 ns; -- Změněno na 100 MHz pro standardní simulaci
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : CLOCK_TIME
    port map (CLK    => CLK,
              RST    => RST,
              clk_en => clk_en,
              BTNU_H => BTNU_H,
              BTND_H => BTND_H,
              BTNU_M => BTNU_M,
              BTND_M => BTND_M,
              BTNU_S => BTNU_S,
              BTND_S => BTND_S,
              HH     => HH,
              MM     => MM,
              SS     => SS);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    CLK <= TbClock;

    stimuli : process
    begin
        -----------------------------------------------------------
        -- TEST: Dlouhé čítání vteřin (Smyčka pro přetečení SS -> MM -> HH)
        -----------------------------------------------------------
        report "Zahajuji test pretekani (150 pulzu clk_en)...";
        
        -- Rychlé nastavení 59 minut pomocí tlačítka Up
        for i in 1 to 59 loop
            BTNU_M <= '1'; wait for TbPeriod;
            BTNU_M <= '0'; wait for TbPeriod;
        end loop;
        
        -- Rychlé nastavení 24 h pomocí tlačítka Up
        for i in 1 to 23 loop
            BTNU_H <= '1'; wait for TbPeriod;
            BTNU_H <= '0'; wait for TbPeriod;
        end loop;
        
                -- Rychlé nastavení 59 s omocí tlačítka Up
        for i in 1 to 59 loop
            BTNU_S<= '1'; wait for TbPeriod;
            BTNU_S<= '0'; wait for TbPeriod;
        end loop;
        
        BTND_M <= '1'; wait for TbPeriod;
            BTND_M <= '0'; wait for TbPeriod;
        
            
        	BTND_S<= '1'; wait for TbPeriod;
            BTND_S<= '0'; wait for TbPeriod;
        
        
        -- Teď stačí jeden clk_en a měly by se překlopit hodiny i minuty
        clk_en <= '1'; wait for TbPeriod;
        clk_en <= '0';
        
        -- Teď stačí jeden clk_en a měly by se překlopit hodiny i minuty
        clk_en <= '1'; wait for TbPeriod;
        clk_en <= '0';
        
        for i in 1 to 150 loop
            -- Aktivujeme vteřinový puls na jeden hodinový takt
            clk_en <= '1';
            wait for TbPeriod;
            clk_en <= '0';
            
            -- Mezera mezi pulzy, aby design stihl zpracovat hranu (pokud je potřeba)
            wait for 2 * TbPeriod; 
        end loop;

        report "Test pretekani dokoncen. Kontroluj zmenu MM a HH.";
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
