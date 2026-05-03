library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alarm_top is
    port (
        CLK   : in  std_logic;
        RST   : in  std_logic;

        BTNU  : in  std_logic;
        BTND  : in  std_logic;
        BTNC  : in  std_logic;

        SW0   : in  std_logic;
        SW1   : in  std_logic;
        SW2   : in  std_logic;

        SEG   : out std_logic_vector(6 downto 0);
        AN    : out std_logic_vector(7 downto 0);
        LED   : out std_logic;
        BUZZ  : out std_logic
    );
end entity Alarm_top;

architecture Behavioral of Alarm_top is

    --------------------------------------------------------------------
    -- COMPONENTS
    --------------------------------------------------------------------

    component DEB is
        port (
            CLK    : in  std_logic;
            RST    : in  std_logic;
            BTNU   : in  std_logic;
            BTND   : in  std_logic;
            BTNC   : in  std_logic;
            BTNU_d : out std_logic;
            BTND_d : out std_logic;
            BTNC_d : out std_logic
        );
    end component;

    component SET_A is
        port (
            BTNU   : in  std_logic;
            BTND   : in  std_logic;
            BTNC   : in  std_logic;
            SW1    : in  std_logic;
            SW2    : in  std_logic;

            BTNC_C : out std_logic;

            BTNU_H : out std_logic;
            BTND_H : out std_logic;
            BTNC_H : out std_logic;

            BTNU_A : out std_logic;
            BTND_A : out std_logic;
            BTNC_A : out std_logic
        );
    end component;

    component SEL_TIME is
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
    end component;

    component SEL_ALM is
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
    end component;

    component TIME is
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
    end component;

    component ALARM is
        port (
            CLK    : in  std_logic;
            RST    : in  std_logic;

            BTNU_H : in  std_logic;
            BTND_H : in  std_logic;
            BTNU_M : in  std_logic;
            BTND_M : in  std_logic;
            BTNU_S : in  std_logic;
            BTND_S : in  std_logic;

            HH_A   : out std_logic_vector(5 downto 0);
            MM_A   : out std_logic_vector(5 downto 0);
            SS_A   : out std_logic_vector(5 downto 0)
        );
    end component;

    component clk_en is
        generic (
            G_MAX : positive
        );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component;

    component SET_B is
        port (
            SW1       : in  std_logic;
            SW2       : in  std_logic;
            STAV_TIME : in  std_logic_vector(1 downto 0);
            STAV_ALM  : in  std_logic_vector(1 downto 0);

            HH        : in  std_logic_vector(5 downto 0);
            MM        : in  std_logic_vector(5 downto 0);
            SS        : in  std_logic_vector(5 downto 0);

            HH_A      : in  std_logic_vector(5 downto 0);
            MM_A      : in  std_logic_vector(5 downto 0);
            SS_A      : in  std_logic_vector(5 downto 0);

            STAV      : out std_logic_vector(1 downto 0);
            H         : out std_logic_vector(5 downto 0);
            M         : out std_logic_vector(5 downto 0);
            S         : out std_logic_vector(5 downto 0)
        );
    end component;

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

    component DIV is
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
    end component;

    component SEL is
        port (
            CLK    : in  std_logic;
            RST    : in  std_logic;

            digit0 : in  std_logic_vector(3 downto 0);
            digit1 : in  std_logic_vector(3 downto 0);
            digit2 : in  std_logic_vector(3 downto 0);
            digit3 : in  std_logic_vector(3 downto 0);
            digit4 : in  std_logic_vector(3 downto 0);
            digit5 : in  std_logic_vector(3 downto 0);
            digit6 : in  std_logic_vector(3 downto 0);
            digit7 : in  std_logic_vector(3 downto 0);

            seg    : out std_logic_vector(3 downto 0);
            an_seg : out std_logic_vector(7 downto 0)
        );
    end component;

    component bin2seg is
        port (
            bin : in  std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;
    
    component driver is
    port (
        CLK       : in  std_logic;
        RST       : in  std_logic;
        buzz_in   : in  std_logic;
        driv_buzz : out std_logic
        );
    end component;

    --------------------------------------------------------------------
    -- INTERNAL SIGNALS
    --------------------------------------------------------------------

    -- debounced button pulses
    signal sig_BTNU_deb : std_logic;
    signal sig_BTND_deb : std_logic;
    signal sig_BTNC_deb : std_logic;

    -- SET_A outputs
    signal sig_COMP_C : std_logic;

    signal sig_SELH_U : std_logic;
    signal sig_SELH_D : std_logic;
    signal sig_SELH_C : std_logic;

    signal sig_SELA_U : std_logic;
    signal sig_SELA_D : std_logic;
    signal sig_SELA_C : std_logic;

    -- SEL_TIME outputs
    signal sig_TIME_UH : std_logic;
    signal sig_TIME_UD : std_logic;
    signal sig_TIME_UM : std_logic;
    signal sig_TIME_DM : std_logic;
    signal sig_TIME_US : std_logic;
    signal sig_TIME_DS : std_logic;
    signal sig_STAV_T : std_logic_vector(1 downto 0);

    -- SEL_ALM outputs
    signal sig_ALM_UH : std_logic;
    signal sig_ALM_UD : std_logic;
    signal sig_ALM_UM : std_logic;
    signal sig_ALM_DM : std_logic;
    signal sig_ALM_US : std_logic;
    signal sig_ALM_DS : std_logic;
    signal sig_STAV_A : std_logic_vector(1 downto 0);

    -- 1 second enable
    signal sig_clk_en : std_logic;

    -- TIME outputs
    signal sig_HH : std_logic_vector(5 downto 0);
    signal sig_MM : std_logic_vector(5 downto 0);
    signal sig_SS : std_logic_vector(5 downto 0);

    -- ALARM outputs
    signal sig_HH_A : std_logic_vector(5 downto 0);
    signal sig_MM_A : std_logic_vector(5 downto 0);
    signal sig_SS_A : std_logic_vector(5 downto 0);

    -- SET_B outputs
    signal sig_DIV_STAV : std_logic_vector(1 downto 0);
    signal sig_DIV_H    : std_logic_vector(5 downto 0);
    signal sig_DIV_M    : std_logic_vector(5 downto 0);
    signal sig_DIV_S    : std_logic_vector(5 downto 0);

    -- COMP output
    signal sig_DIV_O_F : std_logic_vector(3 downto 0);

    -- DIV outputs
    signal sig_digit0 : std_logic_vector(3 downto 0);
    signal sig_digit1 : std_logic_vector(3 downto 0);
    signal sig_digit2 : std_logic_vector(3 downto 0);
    signal sig_digit3 : std_logic_vector(3 downto 0);
    signal sig_digit4 : std_logic_vector(3 downto 0);
    signal sig_digit5 : std_logic_vector(3 downto 0);
    signal sig_digit6 : std_logic_vector(3 downto 0);
    signal sig_digit7 : std_logic_vector(3 downto 0);

    -- SEL outputs
    signal sig_b2s  : std_logic_vector(3 downto 0);

    -- driver outputs
    signal sig_driver   : std_logic;

begin

    --------------------------------------------------------------------
    -- DEB
    --------------------------------------------------------------------
    u_DEB : DEB
        port map (
            CLK    => CLK,
            RST    => RST,
            BTNU   => BTNU,
            BTND   => BTND,
            BTNC   => BTNC,
            BTNU_d => sig_BTNU_deb,
            BTND_d => sig_BTND_deb,
            BTNC_d => sig_BTNC_deb
        );

    --------------------------------------------------------------------
    -- SET_A
    --------------------------------------------------------------------
    u_SET_A : SET_A
        port map (
            BTNU   => sig_BTNU_deb,
            BTND   => sig_BTND_deb,
            BTNC   => sig_BTNC_deb,
            SW1    => SW1,
            SW2    => SW2,

            BTNC_C => sig_COMP_C,

            BTNU_H => sig_SELH_U,
            BTND_H => sig_SELH_D,
            BTNC_H => sig_SELH_C,

            BTNU_A => sig_SELA_U,
            BTND_A => sig_SELA_D,
            BTNC_A => sig_SELA_C
        );

    --------------------------------------------------------------------
    -- SEL_TIME
    --------------------------------------------------------------------
    u_SEL_TIME : SEL_TIME
        port map (
            CLK     => CLK,
            RST     => RST,
            BTNU    => sig_SELH_U,
            BTND    => sig_SELH_D,
            BTNC    => sig_SELH_C,

            BTNU_H  => sig_TIME_UH,
            BTND_H  => sig_TIME_UD,
            BTNU_M  => sig_TIME_UM,
            BTND_M  => sig_TIME_DM,
            BTNU_S  => sig_TIME_US,
            BTND_S  => sig_TIME_DS,
            STAV    => sig_STAV_T
        );

    --------------------------------------------------------------------
    -- SEL_ALM
    --------------------------------------------------------------------
    u_SEL_ALM : SEL_ALM
        port map (
            CLK     => CLK,
            RST     => RST,
            BTNU    => sig_SELA_U,
            BTND    => sig_SELA_D,
            BTNC    => sig_SELA_C,

            BTNU_H  => sig_ALM_UH,
            BTND_H  => sig_ALM_UD,
            BTNU_M  => sig_ALM_UM,
            BTND_M  => sig_ALM_DM,
            BTNU_S  => sig_ALM_US,
            BTND_S  => sig_ALM_DS,
            STAV    => sig_STAV_A
        );

    --------------------------------------------------------------------
    -- clk_en
    --------------------------------------------------------------------
    u_clk_en : clk_en
        generic map (
            G_MAX => 100_000_000
        )
        port map (
            clk => CLK,
            rst => RST,
            ce  => sig_clk_en
        );

    --------------------------------------------------------------------
    -- TIME
    --------------------------------------------------------------------
    u_TIME : TIME
        port map (
            CLK    => CLK,
            RST    => RST,
            clk_en => sig_clk_en,
            SW1    => SW1,
            SW2    => SW2,

            BTNU_H => sig_TIME_UH,
            BTND_H => sig_TIME_UD,
            BTNU_M => sig_TIME_UM,
            BTND_M => sig_TIME_DM,
            BTNU_S => sig_TIME_US,
            BTND_S => sig_TIME_DS,

            HH     => sig_HH,
            MM     => sig_MM,
            SS     => sig_SS
        );

    --------------------------------------------------------------------
    -- ALARM
    --------------------------------------------------------------------
    u_ALARM : ALARM
        port map (
            CLK    => CLK,
            RST    => RST,

            BTNU_H => sig_ALM_UH,
            BTND_H => sig_ALM_UD,
            BTNU_M => sig_ALM_UM,
            BTND_M => sig_ALM_DM,
            BTNU_S => sig_ALM_US,
            BTND_S => sig_ALM_DS,

            HH_A   => sig_HH_A,
            MM_A   => sig_MM_A,
            SS_A   => sig_SS_A
        );

    --------------------------------------------------------------------
    -- SET_B
    --------------------------------------------------------------------
    u_SET_B : SET_B
        port map (
            SW1       => SW1,
            SW2       => SW2,
            STAV_TIME => sig_STAV_T,
            STAV_ALM  => sig_STAV_A,

            HH        => sig_HH,
            MM        => sig_MM,
            SS        => sig_SS,

            HH_A      => sig_HH_A,
            MM_A      => sig_MM_A,
            SS_A      => sig_SS_A,

            STAV      => sig_DIV_STAV,
            H         => sig_DIV_H,
            M         => sig_DIV_M,
            S         => sig_DIV_S
        );

    --------------------------------------------------------------------
    -- COMP
    --------------------------------------------------------------------
    u_COMP : COMP
        port map (
            CLK  => CLK,
            RST  => RST,

            SW0  => SW0,
            BTNC => sig_COMP_C,

            HT   => sig_HH,
            MT   => sig_MM,
            ST   => sig_SS,

            HA   => sig_HH_A,
            MA   => sig_MM_A,
            SA   => sig_SS_A,

            STAV => sig_DIV_O_F,
            LED  => LED,
            BUZZ => sig_driver
        );

    --------------------------------------------------------------------
    -- DIV
    --------------------------------------------------------------------
    u_DIV : DIV
        port map (
            CLK    => CLK,
            RST    => RST,
            STAV   => sig_DIV_STAV,

            H      => sig_DIV_H,
            M      => sig_DIV_M,
            S      => sig_DIV_S,
            O_F     => sig_DIV_O_F,

            digit0 => sig_digit0,
            digit1 => sig_digit1,
            digit2 => sig_digit2,
            digit3 => sig_digit3,
            digit4 => sig_digit4,
            digit5 => sig_digit5,
            digit6 => sig_digit6,
            digit7 => sig_digit7
        );

    --------------------------------------------------------------------
    -- SEL
    --------------------------------------------------------------------
    u_SEL : SEL
        port map (
            CLK    => CLK,
            RST    => RST,

            digit0 => sig_digit0,
            digit1 => sig_digit1,
            digit2 => sig_digit2,
            digit3 => sig_digit3,
            digit4 => sig_digit4,
            digit5 => sig_digit5,
            digit6 => sig_digit6,
            digit7 => sig_digit7,

            seg    => sig_b2s,
            an_seg => AN
        );

    --------------------------------------------------------------------
    -- bin2seg
    --------------------------------------------------------------------
    u_bin2seg : bin2seg
        port map (
            bin => sig_b2s,
            seg => SEG
        );
        
    --------------------------------------------------------------------
    -- driver
    --------------------------------------------------------------------       
     u_driver : driver
        port map (
            CLK       => CLK,
            RST       => RST,
            buzz_in   => sig_driver,
            driv_buzz => BUZZ
        );

end architecture Behavioral;