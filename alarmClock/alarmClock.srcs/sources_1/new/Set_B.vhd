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
    Port ( HOD_H : in STD_LOGIC_VECTOR (5 downto 0);
           MIN_H : in STD_LOGIC_VECTOR (5 downto 0);
           SEC_H : in STD_LOGIC_VECTOR (5 downto 0);
           HOD_A : in STD_LOGIC_VECTOR (5 downto 0);
           MIN_A : in STD_LOGIC_VECTOR (5 downto 0);
           SEC_A : in STD_LOGIC_VECTOR (5 downto 0);
           HOD   : out STD_LOGIC_VECTOR (5 downto 0);
           MIN   : out STD_LOGIC_VECTOR (5 downto 0);
           SEC   : out STD_LOGIC_VECTOR (5 downto 0);
           SW1   : in STD_LOGIC;
           SW2   : in STD_LOGIC;
           SEL_H : in STD_LOGIC_VECTOR (1 downto 0);
           SEL_A : in STD_LOGIC_VECTOR (1 downto 0));
end Set_B;

architecture Behavioral of Set_B is

begin

    HOD_A <= HOD when (SW1 = '1' and SW2 = '0') else '0';
    MIN_A <= MIN when (SW1 = '1' and SW2 = '0') else '0';
    SEC_A <= SEC when (SW1 = '1' and SW2 = '0') else '0';

    HOD_H <= HOD when (SW1 = '0' and SW2 = '1') else '0';
    MIN_H <= MIN when (SW1 = '0' and SW2 = '1') else '0';
    SEC_H <= SEC when (SW1 = '0' and SW2 = '1') else '0';

end Behavioral;
