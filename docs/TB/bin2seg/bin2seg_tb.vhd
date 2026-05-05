library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin2seg_tb is
-- Testbench nema porty
end entity bin2seg_tb;

architecture sim of bin2seg_tb is

    -- Signaly pro propojeni s UUT
    signal bin_tb : std_logic_vector(3 downto 0) := "0000";
    signal seg_tb : std_logic_vector(6 downto 0);

begin

    -- Instance UUT (Unit Under Test)
    UUT: entity work.bin2seg
        port map (
            bin => bin_tb,
            seg => seg_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Report pro zacatek testu
        report "Zahajeni testu dekoderu bin2seg" severity note;

        -- Projdeme vsechny mozne kombinace 0 az 15 (hex 0 az F)
        for i in 0 to 15 loop
            bin_tb <= std_logic_vector(to_unsigned(i, 4));
            wait for 20 ns;
            
            -- Volitelna kontrola v konzoli (pro vybrane hodnoty)
            if i = 0 then
                assert seg_tb = "0000001" report "Chyba pro cislici 0" severity error;
            elsif i = 15 then
                assert seg_tb = "0111000" report "Chyba pro pismeno F" severity error;
            end if;
        end loop;

        -- Test specialnich znaku z Vaseho kodu
        -- "1010" by melo byt 'o'
        bin_tb <= "1010";
        wait for 20 ns;
        
        -- "1011" by melo byt 'n'
        bin_tb <= "1011";
        wait for 20 ns;

        -- Navrat k nule
        bin_tb <= "0000";
        wait for 20 ns;

        report "Test dokoncen. Prohlednete si prubehy v simulaci." severity note;
        wait;
    end process;

end architecture sim;
