library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALARM_tb is

end entity ALARM_tb;

architecture sim of ALARM_tb is


    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '0';
    signal btnu_h_tb : std_logic := '0';
    signal btnd_h_tb : std_logic := '0';
    signal btnu_m_tb : std_logic := '0';
    signal btnd_m_tb : std_logic := '0';
    signal btnu_s_tb : std_logic := '0';
    signal btnd_s_tb : std_logic := '0';

    signal hh_a_tb   : std_logic_vector(5 downto 0);
    signal mm_a_tb   : std_logic_vector(5 downto 0);
    signal ss_a_tb   : std_logic_vector(5 downto 0);


    constant CLK_PERIOD : time := 10 ns;

begin


    UUT: entity work.ALARM
        port map (
            CLK    => clk_tb,
            RST    => rst_tb,
            BTNU_H => btnu_h_tb,
            BTND_H => btnd_h_tb,
            BTNU_M => btnu_m_tb,
            BTND_M => btnd_m_tb,
            BTNU_S => btnu_s_tb,
            BTND_S => btnd_s_tb,
            HH_A   => hh_a_tb,
            MM_A   => mm_a_tb,
            SS_A   => ss_a_tb
        );


    clk_process : process
    begin
        while now < 1000 ns loop 
            clk_tb <= '0';
            wait for CLK_PERIOD/2;
            clk_tb <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;

 
    stim_proc: process
    begin

        rst_tb <= '1';
        wait for CLK_PERIOD * 2;
        rst_tb <= '0';
        wait for CLK_PERIOD;


        btnu_h_tb <= '1'; 
        wait for CLK_PERIOD;
        btnu_h_tb <= '0';
        wait for CLK_PERIOD;
        
        btnu_h_tb <= '1'; 
        wait for CLK_PERIOD;
        btnu_h_tb <= '0';
        wait for CLK_PERIOD;


        btnd_m_tb <= '1';
        wait for CLK_PERIOD;
        btnd_m_tb <= '0';
        wait for CLK_PERIOD;


        btnu_s_tb <= '1';
        wait for CLK_PERIOD * 2; 
        btnu_s_tb <= '0';
        wait for CLK_PERIOD;

  
  
        btnu_h_tb <= '1';
        btnd_h_tb <= '1';
        wait for CLK_PERIOD;
        btnu_h_tb <= '0';
        btnd_h_tb <= '0';


        wait for CLK_PERIOD * 5;
        
        report "Simulace dokoncena. Zkontrolujte prubehy v diagramu." severity note;
        wait;
    end process;

end architecture sim;
