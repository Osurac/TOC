----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 20:39:57
-- Design Name: 
-- Module Name: Multiplier - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
   Port (
      X  :  in std_logic_vector(3 downto 0);
      Y  :  in std_logic_vector(3 downto 0);
      Z  :  out std_logic_vector(7 downto 0)
   );
end Multiplier;

architecture Behavioral of Multiplier is

   signal s_X : unsigned(3 downto 0);
   signal s_Y : unsigned(3 downto 0);
   
   signal s_Z : unsigned(7 downto 0);
   
begin
             
   s_X <= unsigned(X);
   s_Y <= unsigned(Y);
   
   s_Z <= (s_X * s_Y);
   
   Z <= std_logic_vector(s_Z);


end Behavioral;
