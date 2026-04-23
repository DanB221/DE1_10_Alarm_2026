library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_en is
    generic (
        G_MAX : positive := 100000000);
        
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : out STD_LOGIC);
end clk_en;

architecture behavioral of clk_en is

    signal sig_cnt : integer range 0 to G_MAX-1;

begin

    process (clk) is
    begin
        if rising_edge(clk) then  -- Synchronous process
            if rst = '1' then     -- High-active reset
                ce      <= '0';   -- Reset output
                sig_cnt <= 0;     -- Reset internal counter

            elsif sig_cnt = G_MAX-1 then
                sig_cnt <= 0;
                ce      <= '1';

            else
                ce      <= '0';
                sig_cnt <= sig_cnt +1;

            end if;  
        end if;      
    end process;

end architecture behavioral;
