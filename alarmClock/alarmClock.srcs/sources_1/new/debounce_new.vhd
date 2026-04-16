library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( 
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        -- Vstupy pro 3 tlačítka
        btns_in    : in  STD_LOGIC_VECTOR(2 downto 0); 
        -- Stavy tlačítek (drží log. 1, dokud je tlačítko stisknuté)
        btns_state : out STD_LOGIC_VECTOR(2 downto 0);
        -- Pulzy (log. 1 pouze na jeden takt při stisku)
        btns_press : out STD_LOGIC_VECTOR(2 downto 0)
    );
end debounce;

architecture Behavioral of debounce is
    ----------------------------------------------------------------
    -- Konstanty
    ----------------------------------------------------------------
    constant C_SHIFT_LEN : positive := 4;
    constant C_MAX       : positive := 200_000; -- 2 ms pro 100MHz hodiny

    ----------------------------------------------------------------
    -- Vnitřní signály (nyní pole pro 3 tlačítka)
    ----------------------------------------------------------------
    signal ce_sample : std_logic;
    
    -- Synchronizační registry (pro zamezení metastability)
    signal sync0     : std_logic_vector(2 downto 0);
    signal sync1     : std_logic_vector(2 downto 0);
    
    -- Typ pro pole posuvných registrů (každé tlačítko má svůj shift_reg)
    type t_shift_regs is array (0 to 2) of std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal shift_regs : t_shift_regs;

    signal debounced : std_logic_vector(2 downto 0);
    signal delayed   : std_logic_vector(2 downto 0);

    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

begin

    -- Instance generátoru vzorkovacího pulzu (společný pro všechna tlačítka)
    clock_0 : clk_en
        generic map ( G_MAX => C_MAX )
        port map (
            clk => clk,
            rst => rst,
            ce  => ce_sample
        );

    ----------------------------------------------------------------
    -- Synchronizátor + Debounce proces
    ----------------------------------------------------------------
    p_debounce : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sync0      <= (others => '0');
                sync1      <= (others => '0');
                debounced  <= (others => '0');
                delayed    <= (others => '0');
                for i in 0 to 2 loop
                    shift_regs(i) <= (others => '0');
                end loop;

            else
                -- Synchronizace vstupů (2-stupňový synchronizátor)
                sync1 <= sync0;
                sync0 <= btns_in;

                -- Vzorkování historie tlačítek
                if ce_sample = '1' then
                    for i in 0 to 2 loop
                        -- Posuvný registr pro každé tlačítko
                        shift_regs(i) <= shift_regs(i)(C_SHIFT_LEN-2 downto 0) & sync1(i);

                        -- Rozhodovací logika (Hystereze)
                        if shift_regs(i) = (shift_regs(i)'range => '1') then
                            debounced(i) <= '1';
                        elsif shift_regs(i) = (shift_regs(i)'range => '0') then
                            debounced(i) <= '0';
                        end if;
                    end loop;
                end if;

                -- Zpoždění pro detekci náběžné hrany
                delayed <= debounced;
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Výstupy
    ----------------------------------------------------------------
    btns_state <= debounced;
    
    -- Detekce náběžné hrany pro každé tlačítko zvlášť
    btns_press <= debounced and not(delayed);

end Behavioral;
