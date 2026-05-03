library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity driver is
    port (
        CLK       : in  std_logic;
        RST       : in  std_logic;
        buzz_in   : in  std_logic;
        driv_buzz : out std_logic
    );
end entity driver;

architecture Behavioral of driver is

    -- 2 kHz tón pri 100 MHz clocku
    constant C_TONE_HALF : unsigned(15 downto 0) := to_unsigned(25_000 - 1, 16);

    -- 300 ms pri 100 MHz
    constant C_300MS : unsigned(24 downto 0) := to_unsigned(30_000_000 - 1, 25);

    signal tone_cnt    : unsigned(15 downto 0) := (others => '0');
    signal tone_sig    : std_logic := '0';

    signal phase_cnt   : unsigned(24 downto 0) := (others => '0');
    signal phase_state : std_logic := '0';  

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                tone_cnt    <= (others => '0');
                tone_sig    <= '0';
                phase_cnt   <= (others => '0');
                phase_state <= '0';

            else
                if buzz_in = '0' then
                    tone_cnt    <= (others => '0');
                    tone_sig    <= '0';
                    phase_cnt   <= (others => '0');
                    phase_state <= '0';

                else
                    -- prepínanie 300ms
                    if phase_cnt = C_300MS then
                        phase_cnt   <= (others => '0');
                        phase_state <= not phase_state;
                    else
                        phase_cnt <= phase_cnt + 1;
                    end if;

                    -- generátor tónu
                    if tone_cnt = C_TONE_HALF then
                        tone_cnt <= (others => '0');
                        tone_sig <= not tone_sig;
                    else
                        tone_cnt <= tone_cnt + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- počas phase_state='0' píska, počas '1' je ticho
    driv_buzz <= tone_sig when (buzz_in = '1' and phase_state = '0') else '0';

end architecture Behavioral;