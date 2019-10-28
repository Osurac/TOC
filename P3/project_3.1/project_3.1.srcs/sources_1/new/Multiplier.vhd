----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 20:16:01
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

   signal s_X : std_logic_vector(3 downto 0);
   signal s_Y : std_logic_vector(3 downto 0);
   
   signal in1_adder : unsigned(7 downto 0);
   signal in2_adder : unsigned(7 downto 0);
   
   signal in3_adder : unsigned(7 downto 0);
   signal in4_adder : unsigned(7 downto 0);
   
   signal s_Z : std_logic_vector(7 downto 0);
   
begin
   
   s_X <= X;
   s_Y <= Y;
   Z <= s_Z;
   
      in1_adder <= (0 => (s_X(0) and s_Y(0)), 
                     1 => (s_X(1) and s_Y(0)),
                     2 => (s_X(2) and s_Y(0)),
                     3 => (s_X(3) and s_Y(0)),
                     others => '0');
      
      in2_adder <= (1 => (s_X(0) and s_Y(1)), 
                     2 => (s_X(1) and s_Y(1)),
                     3 => (s_X(2) and s_Y(1)),
                     4 => (s_X(3) and s_Y(1)),
                     others => '0');
      
      in3_adder <= (2 => (s_X(0) and s_Y(2)), 
                     3 => (s_X(1) and s_Y(2)),
                     4 => (s_X(2) and s_Y(2)),
                     5 => (s_X(3) and s_Y(2)),
                     others => '0');
      
      in4_adder <= (3 => (s_X(0) and s_Y(3)), 
                     4 => (s_X(1) and s_Y(3)),
                     5 => (s_X(2) and s_Y(3)),
                     6 => (s_X(3) and s_Y(3)),
                     others => '0');
      
      s_Z <= std_logic_vector(in1_adder + in2_adder + in3_adder + in4_adder);
   


end Behavioral;
