library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DIV is
    port (
        CLK    : in  std_logic;
        RST    : in  std_logic;
        STAV   : in  std_logic_vector(1 downto 0);

        H      : in  std_logic_vector(5 downto 0);
        M      : in  std_logic_vector(5 downto 0);
        S      : in  std_logic_vector(5 downto 0);
        O_F     : in  std_logic_vector(3 downto 0);

        digit0 : out std_logic_vector(3 downto 0);
        digit1 : out std_logic_vector(3 downto 0);
        digit2 : out std_logic_vector(3 downto 0);
        digit3 : out std_logic_vector(3 downto 0);
        digit4 : out std_logic_vector(3 downto 0);
        digit5 : out std_logic_vector(3 downto 0);
        digit6 : out std_logic_vector(3 downto 0);
        digit7 : out std_logic_vector(3 downto 0)
    );
end entity DIV;

architecture Behavioral of DIV is

    signal h_int : integer range 0 to 63;
    signal m_int : integer range 0 to 63;
    signal s_int : integer range 0 to 63;

    signal blink_cnt   : unsigned(24 downto 0) := (others => '0');
    signal blink_state : std_logic := '0';

    signal h_tens : std_logic_vector(3 downto 0);
    signal h_ones : std_logic_vector(3 downto 0);
    signal m_tens : std_logic_vector(3 downto 0);
    signal m_ones : std_logic_vector(3 downto 0);
    signal s_tens : std_logic_vector(3 downto 0);
    signal s_ones : std_logic_vector(3 downto 0);

begin

    h_int <= to_integer(unsigned(H));
    m_int <= to_integer(unsigned(M));
    s_int <= to_integer(unsigned(S));

    h_tens <= std_logic_vector(to_unsigned(h_int / 10, 4));
    h_ones <= std_logic_vector(to_unsigned(h_int mod 10, 4));

    m_tens <= std_logic_vector(to_unsigned(m_int / 10, 4));
    m_ones <= std_logic_vector(to_unsigned(m_int mod 10, 4));

    s_tens <= std_logic_vector(to_unsigned(s_int / 10, 4));
    s_ones <= std_logic_vector(to_unsigned(s_int mod 10, 4));

    process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                blink_cnt   <= (others => '0');
                blink_state <= '0';
            else
                if blink_cnt = 25_000_000 - 1 then
                    blink_cnt   <= (others => '0');
                    blink_state <= not blink_state;
                else
                    blink_cnt <= blink_cnt + 1;
                end if;
            end if;
        end if;
    end process;

    process(STAV, blink_state, h_tens, h_ones, m_tens, m_ones, s_tens, s_ones, O_F)
    begin
        digit0 <= h_tens;
        digit1 <= h_ones;
        digit2 <= m_tens;
        digit3 <= m_ones;
        digit4 <= s_tens;
        digit5 <= s_ones;
        digit6 <= "1010";
        digit7 <= O_F;

        case STAV is
            when "00" =>
                null;

            when "01" =>
                if blink_state = '0' then
                    digit0 <= "1100";
                    digit1 <= "1100";
                end if;

            when "10" =>
                if blink_state = '0' then
                    digit2 <= "1100";
                    digit3 <= "1100";
                end if;

            when "11" =>
                if blink_state = '0' then
                    digit4 <= "1100";
                    digit5 <= "1100";
                end if;

            when others =>
                null;
        end case;
    end process;

end architecture Behavioral;