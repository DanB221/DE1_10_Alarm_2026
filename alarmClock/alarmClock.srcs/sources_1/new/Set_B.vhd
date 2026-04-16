----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2026 02:25:05 PM
-- Design Name: 
-- Module Name: Set_B - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Set_B is
    Port ( HH        : in STD_LOGIC_VECTOR (5 downto 0);
           MM        : in STD_LOGIC_VECTOR (5 downto 0);
           SS        : in STD_LOGIC_VECTOR (5 downto 0);
           HH_A      : in STD_LOGIC_VECTOR (5 downto 0);
           MM_A      : in STD_LOGIC_VECTOR (5 downto 0);
           SS_A      : in STD_LOGIC_VECTOR (5 downto 0);
           SW1       : in STD_LOGIC;
           SW2       : in STD_LOGIC;
           STAV_TIME : in STD_LOGIC_VECTOR (1 downto 0);
           STAV_ALM  : in STD_LOGIC_VECTOR (1 downto 0));
           H         : out STD_LOGIC_VECTOR (5 downto 0);
           M         : out STD_LOGIC_VECTOR (5 downto 0);
           S         : out STD_LOGIC_VECTOR (5 downto 0);
end Set_B;

architecture Behavioral of Set_B is

begin

    H <= HH_A when (SW1 = '1' and SW2 = '0') else '0';
    M <= MM_A when (SW1 = '1' and SW2 = '0') else '0';
    S <= SS_A when (SW1 = '1' and SW2 = '0') else '0';

    H <= HH when (SW1 = '0' and SW2 = '1') else '0';
    M <= MM when (SW1 = '0' and SW2 = '1') else '0';
    S <= SS when (SW1 = '0' and SW2 = '1') else '0';

end Behavioral;
