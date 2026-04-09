----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2026 01:48:24 PM
-- Design Name: 
-- Module Name: Set_A - Behavioral
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

entity Set_A is
    Port ( BTNU   : in STD_LOGIC;
           BTND   : in STD_LOGIC;
           BTNC   : in STD_LOGIC;
           SW1    : in STD_LOGIC;
           SW2    : in STD_LOGIC;
           BTNU_H : out STD_LOGIC;
           BTND_H : out STD_LOGIC;
           BTNC_H : out STD_LOGIC;
           BTNU_A : out STD_LOGIC;
           BTND_A : out STD_LOGIC;
           BTNC_A : out STD_LOGIC;
           BTNC_C : out STD_LOGIC);
end Set_A;

architecture Behavioral of Set_A is

begin

    BTNU_A <= BTNU when (SW1 = '1' and SW2 = '0') else '0';
    BTND_A <= BTND when (SW1 = '1' and SW2 = '0') else '0';
    BTNC_A <= BTNC when (SW1 = '1' and SW2 = '0') else '0';

    BTNU_H <= BTNU when (SW1 = '0' and SW2 = '1') else '0';
    BTND_H <= BTND when (SW1 = '0' and SW2 = '1') else '0';
    BTNC_H <= BTNC when (SW1 = '0' and SW2 = '1') else '0';

    BTNC_C <= BTNC when (SW1 = '0' and SW2 = '0') else '0';

end Behavioral;
