----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2020 18:51:45
-- Design Name: 
-- Module Name: mult8b - Behavioral
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

entity mult8b is
 Port (
		rst : in std_logic;
		clk : in std_logic;  
		inicio        : IN  std_logic;
		fin           : OUT std_logic;
		a_in : in std_logic_vector(3 downto 0);
		b_in : in std_logic_vector(3 downto 0);
		r : out std_logic_vector(7 downto 0)
 );
end mult8b;



architecture Behavioral of mult8b is

signal s_inicio: std_logic;
signal s_fin: std_logic;
signal s_r: std_logic_vector(7 downto 0);
signal s_a : std_logic_vector(7 downto 0);
signal s_b : std_logic_vector(3 downto 0);

type ESTADO is(s0, s1, s2);
signal estadoActual, estadoSiguiente : ESTADO := s0;

 
begin

p_exec:process (clk)

begin

	if (clk'event and clk = '1') then
	
		if rst = '1' then
		
			estadoActual <= s0;
			
		else
		
			estadoActual <= estadoSiguiente;
			
		end if;
		
	end if;
	
end process;


p_estados:process(estadoActual, s_a, s_b, a_in, b_in, s_r)  
begin

r <= s_r; 

case estadoActual is

	when S0 =>
		fin <= '1';
		if(inicio = '1') then  
			s_a <= "0000" & a_in;
			s_b <= b_in;
			s_r <= "00000000";
			r <= s_r;  
			estadoSiguiente <= s1;
		else 
			r <= s_r;  
			estadoSiguiente <= s0;
		end if;

	when s1 =>
        fin <= '0';
		r <= s_r;
		
		if (s_b = "0000") then
			estadoSiguiente <= s0;
		else
			estadoSiguiente <= s2;
		end if;
		
	when S2 =>
        fin <= '0';
		r <= s_r;
		
		if (s_b(0) = '1') then
						
			s_r <= std_logic_vector(unsigned(s_r) + unsigned(s_a));
			s_a <= (s_a(6 downto 0) & "0");
			s_b <= ("0" & s_b(3 downto 1));
			estadoSiguiente <= s1;
			
		else
	
			s_a <= (s_a(6 downto 0) & "0");
			s_b <= ("0" & s_b(3 downto 1));
			estadoSiguiente <= s1;
						
		end if;

	when others => null;
		
end case;

end process;

end Behavioral;



