library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity COMP_tb is
end entity COMP_tb;

architecture Behavioral of COMP_tb is

    component COMP is
        port (
            CLK  : in  std_logic;
            RST  : in  std_logic;
            SW0  : in  std_logic;
            BTNC : in  std_logic;
            HT   : in  std_logic_vector(5 downto 0);
            MT   : in  std_logic_vector(5 downto 0);
            ST   : in  std_logic_vector(5 downto 0);
            HA   : in  std_logic_vector(5 downto 0);
            MA   : in  std_logic_vector(5 downto 0);
            SA   : in  std_logic_vector(5 downto 0);
            STAV : out std_logic_vector(3 downto 0);
            LED  : out std_logic;
            BUZZ : out std_logic
        );
    end component;

    signal CLK  : std_logic := '0';
    signal RST  : std_logic := '0';
    signal SW0  : std_logic := '0';
    signal BTNC : std_logic := '0';

    signal HT   : std_logic_vector(5 downto 0) := (others => '0');
    signal MT   : std_logic_vector(5 downto 0) := (others => '0');
    signal ST   : std_logic_vector(5 downto 0) := (others => '0');

    signal HA   : std_logic_vector(5 downto 0) := (others => '0');
    signal MA   : std_logic_vector(5 downto 0) := (others => '0');
    signal SA   : std_logic_vector(5 downto 0) := (others => '0');

    signal STAV : std_logic_vector(3 downto 0);
    signal LED  : std_logic;
    signal BUZZ : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut : COMP
        port map (
            CLK  => CLK,
            RST  => RST,
            SW0  => SW0,
            BTNC => BTNC,
            HT   => HT,
            MT   => MT,
            ST   => ST,
            HA   => HA,
            MA   => MA,
            SA   => SA,
            STAV => STAV,
            LED  => LED,
            BUZZ => BUZZ
        );

    p_clk : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    p_stimulus : process
    begin
        -- reset
        RST <= '1';
        SW0 <= '0';
        BTNC <= '0';

        HT <= std_logic_vector(to_unsigned(10, 6));
        MT <= std_logic_vector(to_unsigned(20, 6));
        ST <= std_logic_vector(to_unsigned(30, 6));

        HA <= std_logic_vector(to_unsigned(6, 6));
        MA <= std_logic_vector(to_unsigned(15, 6));
        SA <= std_logic_vector(to_unsigned(45, 6));

        wait for 50 ns;
        RST <= '0';

        -- alarm enabled, no match
        wait for 50 ns;
        SW0 <= '1';

        HT <= std_logic_vector(to_unsigned(7, 6));
        MT <= std_logic_vector(to_unsigned(15, 6));
        ST <= std_logic_vector(to_unsigned(45, 6));

        wait for 100 ns;

        -- match
        HT <= std_logic_vector(to_unsigned(6, 6));
        MT <= std_logic_vector(to_unsigned(15, 6));
        ST <= std_logic_vector(to_unsigned(45, 6));

        wait for 100 ns;

        -- snooze
        BTNC <= '1';
        wait for CLK_PERIOD;
        BTNC <= '0';

        wait for 100 ns;

        -- switch off
        SW0 <= '0';
        wait for 1 us;

        -- switch on again
        SW0 <= '1';
        wait for 100 ns;

        wait;
    end process;

end architecture Behavioral;
