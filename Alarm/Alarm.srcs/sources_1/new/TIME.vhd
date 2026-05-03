library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TIME is
    port (
        CLK    : in  std_logic;
        RST    : in  std_logic;
        clk_en : in  std_logic;
        SW1    : in  std_logic;
        SW2    : in  std_logic;

        BTNU_H : in  std_logic;
        BTND_H : in  std_logic;
        BTNU_M : in  std_logic;
        BTND_M : in  std_logic;
        BTNU_S : in  std_logic;
        BTND_S : in  std_logic;

        HH     : out std_logic_vector(5 downto 0);
        MM     : out std_logic_vector(5 downto 0);
        SS     : out std_logic_vector(5 downto 0)
    );
end entity TIME;

architecture Behavioral of TIME is

    signal hh_reg : unsigned(5 downto 0) := (others => '0');
    signal mm_reg : unsigned(5 downto 0) := (others => '0');
    signal ss_reg : unsigned(5 downto 0) := (others => '0');

begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                hh_reg <= (others => '0');
                mm_reg <= (others => '0');
                ss_reg <= (others => '0');

            -- Ručné nastavovanie hodín
            elsif (SW2 = '1' and SW1 = '0' and BTNU_H = '1') then
                if hh_reg = 23 then
                    hh_reg <= (others => '0');
                else
                    hh_reg <= hh_reg + 1;
                end if;

            elsif (SW2 = '1' and SW1 = '0' and BTND_H = '1') then
                if hh_reg = 0 then
                    hh_reg <= to_unsigned(23, 6);
                else
                    hh_reg <= hh_reg - 1;
                end if;

            -- Ručné nastavovanie minút
            elsif (SW2 = '1' and SW1 = '0' and BTNU_M = '1') then
                if mm_reg = 59 then
                    mm_reg <= (others => '0');
                else
                    mm_reg <= mm_reg + 1;
                end if;

            elsif (SW2 = '1' and SW1 = '0' and BTND_M = '1') then
                if mm_reg = 0 then
                    mm_reg <= to_unsigned(59, 6);
                else
                    mm_reg <= mm_reg - 1;
                end if;

            -- Ručné nastavovanie sekúnd
            elsif (SW2 = '1' and SW1 = '0' and BTNU_S = '1') then
                if ss_reg = 59 then
                    ss_reg <= (others => '0');
                else
                    ss_reg <= ss_reg + 1;
                end if;

            elsif (SW2 = '1' and SW1 = '0' and BTND_S = '1') then
                if ss_reg = 0 then
                    ss_reg <= to_unsigned(59, 6);
                else
                    ss_reg <= ss_reg - 1;
                end if;

            -- Normálny chod hodín
            elsif (clk_en = '1' and not (SW2 = '1' and SW1 = '0')) then
                if ss_reg = 59 then
                    ss_reg <= (others => '0');

                    if mm_reg = 59 then
                        mm_reg <= (others => '0');

                        if hh_reg = 23 then
                            hh_reg <= (others => '0');
                        else
                            hh_reg <= hh_reg + 1;
                        end if;

                    else
                        mm_reg <= mm_reg + 1;
                    end if;

                else
                    ss_reg <= ss_reg + 1;
                end if;
            end if;
        end if;
    end process;

    HH <= std_logic_vector(hh_reg);
    MM <= std_logic_vector(mm_reg);
    SS <= std_logic_vector(ss_reg);

end architecture Behavioral;