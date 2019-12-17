----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 19:38:35
-- Design Name: 
-- Module Name: multiplexor8a1 - multiplexer8to1Arch
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexor8a1 is
  generic(
    bits_entradas: positive := 32
  ); 
  port( 
    entrada0  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada1  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada2  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada3  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada4  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada5  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada6  : in  std_logic_vector(bits_entradas-1 downto 0);
    entrada7  : in  std_logic_vector(bits_entradas-1 downto 0);
    seleccion : in  std_logic_vector(2 downto 0); 
    salida  : out std_logic_vector(bits_entradas-1 downto 0)  
  ); 
end multiplexor8a1;

architecture multiplexer8to1Arch of multiplexor8a1 is

begin

  salida <= entrada0 when (seleccion = "000") else 
            entrada1 when (seleccion = "001") else 
            entrada2 when (seleccion = "010") else 
            entrada3 when (seleccion = "011") else 
            entrada4 when (seleccion = "100") else 
            entrada5 when (seleccion = "101") else 
            entrada6 when (seleccion = "110") else 
            entrada7;  

end multiplexer8to1Arch;