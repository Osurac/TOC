
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY simulacion IS
END simulacion;
 
ARCHITECTURE behavior OF simulacion IS 
 
-- Declaraci?n del componente que vamos a simular
   
	component mult8b
	  Port (
		rst : in std_logic;
		clk : in std_logic;  
		inicio        : IN  std_logic;
		fin           : OUT std_logic;
		a_in : in std_logic_vector(3 downto 0);
		b_in : in std_logic_vector(3 downto 0);
		r : out std_logic_vector(7 downto 0)
	  );
	end component;

--Entradas
    signal rst : std_logic;
    signal clk : std_logic;
	signal inicio : std_logic;
	signal a_in, b_in : std_logic_vector(3 downto 0);

--Salidas
	signal fin : std_logic;
    signal r : std_logic_vector(7 downto 0);
   
--Se define el periodo de reloj 
    constant clk_period : time := 50 ns;
 
BEGIN
 
-- Instanciacion de la unidad a simular 

   uut: mult8b PORT MAP (
         rst => rst,
         clk => clk,
         inicio => inicio,
		     fin => fin,
         a_in => a_in,
         b_in => b_in,
		 
         r => r
        );

-- Definicion del process de reloj
reloj_process :process
   begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;
 

--Proceso de estimulos
stim_proc: process
   begin		
-- Se mantiene el rst activado durante 45 ns.
      rst<='1';
      inicio <= '0';
      a_in <= "0000";
      b_in <= "0000";
      wait for 45 ns;
-- Dejamos de resetear	
      rst<='0';
      inicio <= '0';
      a_in <= "0000";
      b_in <= "0000";
      wait for 150 ns;	
-- Cargamos datos
      rst<='0';
      inicio <= '1';
      a_in <= "0011";
      b_in <= "1000";
      wait for 100 ns;	
-- Espera indefinida
      inicio <= '0';
      a_in <= "0000";
      b_in <= "0000";
      wait;
end process;

END;
