
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SEL_ALM is
    port (
        CLK     : in  std_logic;
        RST     : in  std_logic;
        BTNU    : in  std_logic;
        BTND    : in  std_logic;
        BTNC    : in  std_logic;

        BTNU_H  : out std_logic;
        BTND_H  : out std_logic;
        BTNU_M  : out std_logic;
        BTND_M  : out std_logic;
        BTNU_S  : out std_logic;
        BTND_S  : out std_logic;
        STAV    : out std_logic_vector(1 downto 0)
    );
end entity SEL_ALM;

architecture Behavioral of SEL_ALM is

    type t_state is (STATE_H, STATE_M, STATE_S);
    signal state        : t_state := STATE_H;
    signal btnc_prev    : std_logic := '0';

begin

    p_state_reg : process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                state     <= STATE_H;
                btnc_prev <= '0';
            else
                btnc_prev <= BTNC;

                if (btnc_prev = '0' and BTNC = '1') then
                    case state is
                        when STATE_H =>
                            state <= STATE_M;

                        when STATE_M =>
                            state <= STATE_S;

                        when STATE_S =>
                            state <= STATE_H;
                    end case;
                end if;
            end if;
        end if;
    end process;

    p_output_logic : process(state, BTNU, BTND)
    begin
        -- defaultne všetko vypnuté
        BTNU_H <= '0';
        BTND_H <= '0';
        BTNU_M <= '0';
        BTND_M <= '0';
        BTNU_S <= '0';
        BTND_S <= '0';
        STAV   <= "00";

        case state is
            when STATE_H =>
                BTNU_H <= BTNU;
                BTND_H <= BTND;
                STAV   <= "01";

            when STATE_M =>
                BTNU_M <= BTNU;
                BTND_M <= BTND;
                STAV   <= "10";

            when STATE_S =>
                BTNU_S <= BTNU;
                BTND_S <= BTND;
                STAV   <= "11";
        end case;
    end process;

end architecture Behavioral;