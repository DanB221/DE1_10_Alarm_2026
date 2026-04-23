library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEB is
    generic (
        C_MAX : positive := 200_000 
    );
    Port ( 
        CLK        : in  STD_LOGIC;
        RST        : in  STD_LOGIC;
        BTNU       : in  STD_LOGIC;
        BTND       : in  STD_LOGIC;
        BTNC       : in  STD_LOGIC;
        BTNU_d     : out STD_LOGIC;
        BTND_d     : out STD_LOGIC;
        BTNC_d     : out STD_LOGIC
    );
end DEB;

architecture Behavioral of DEB is
    constant C_SHIFT_LEN : positive := 4;

    -- Pridaná inicializácia signálov pre simuláciu (stavy '0')
    signal ce_sample : std_logic := '0';
    signal btns_in   : std_logic_vector(2 downto 0) := (others => '0');
    signal sync0     : std_logic_vector(2 downto 0) := (others => '0');
    signal sync1     : std_logic_vector(2 downto 0) := (others => '0');
    
    type shift_reg_array is array (0 to 2) of std_logic_vector(C_SHIFT_LEN-1 downto 0);
    -- Inicializácia polí na nuly
    signal shift_reg : shift_reg_array := (others => (others => '0'));
    
    signal debounced : std_logic_vector(2 downto 0) := (others => '0');
    signal delayed   : std_logic_vector(2 downto 0) := (others => '0');

    component clk_en is
        generic ( G_MAX : positive );
        port (
            CLK : in  std_logic;
            RST : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

begin
    -- Správne poradie bitov (U=2, D=1, C=0)
    btns_in <= BTNU & BTND & BTNC;

    clock_0 : clk_en
        generic map ( G_MAX => C_MAX )
        port map (
            CLK => CLK,
            RST => RST,
            ce  => ce_sample -- Skontrolujte v simulácii, či tento signál kmitá!
        );

    p_debounce : process(CLK)
    begin
        if rising_edge(CLK) then
            if RST = '1' then
                sync0     <= (others => '0');
                sync1     <= (others => '0');
                debounced <= (others => '0');
                delayed   <= (others => '0');
                for i in 0 to 2 loop
                    shift_reg(i) <= (others => '0');
                end loop;
            else
                -- Synchronizácia prebieha každý takt hodín
                sync0 <= btns_in;
                sync1 <= sync0;

                -- Debouncing prebieha len pri impulze z clk_en
                if ce_sample = '1' then
                    for i in 0 to 2 loop
                        -- Posuvný register
                        shift_reg(i) <= shift_reg(i)(C_SHIFT_LEN-2 downto 0) & sync1(i);
                        
                        -- Stabilizácia výstupu
                        if shift_reg(i) = "1111" then -- Ak sú všetky 4 bity '1'
                            debounced(i) <= '1';
                        elsif shift_reg(i) = "0000" then -- Ak sú všetky 4 bity '0'
                            debounced(i) <= '0';
                        end if;
                    end loop;
                end if;
                
                -- delayed musí byť mimo podmienky ce_sample, 
                -- aby sme detekovali hranu voči CLK
                delayed <= debounced;
            end if;
        end if;
    end process;

    -- Generovanie impulzu (trvá 1 takt CLK)
    BTNU_d <= debounced(2) and not(delayed(2));
    BTND_d <= debounced(1) and not(delayed(1));
    BTNC_d <= debounced(0) and not(delayed(0));

end Behavioral;