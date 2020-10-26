----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2020 11:07:22
-- Design Name: 
-- Module Name: contadorMod16 - Behavioral
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
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contadorMod16 is
port(
    rst: IN std_logic;
    clk: IN std_logic;
    cuenta: IN std_logic;
    salida: OUT std_logic_vector(3 downto 0)
);

end contadorMod16;

architecture Behavioral of contadorMod16 is

 component registro is
        port (
          rst    : IN  std_logic;
          clk    : IN  std_logic;
          load   : IN  std_logic;
          E      : IN std_logic_vector(3 downto 0);
          S : OUT std_logic_vector(3 downto 0)
        );
    end component;
    
    component sumador is
        port (
           A : IN   std_logic_vector(3 downto 0);
           B : IN   std_logic_vector(3 downto 0);
           C : OUT  std_logic_vector(3 downto 0)   
        );
    end component;

   signal clk_1Hz : std_logic;

   signal E: std_logic_vector(3 downto 0);
   signal S: std_logic_vector(3 downto 0);
   
   signal A: std_logic_vector(3 downto 0);
   signal B: std_logic_vector(3 downto 0);
   signal C: std_logic_vector(3 downto 0);
            

begin

    process(rst, clk)
    
    begin
   
   if (rst = '1') then 
   salida <= (others => '0');
   
   elsif rising_edge(clk) and (clk='1') then 
          
         if (cuenta = '1') then
          
         salida <= S + 1;
          
         end if;
  
  end if;
    
  end process;
  
   sum: sumador PORT MAP (
        A => "0001",
        B => S, 
        C => E
    );
        
    reg: registro PORT MAP (
         rst => rst,
         clk => clk,
		 load => cuenta,
         E => E,
         S => S
      );
    
        
end Behavioral;
