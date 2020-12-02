----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Álvaro Miguel Rodríguez Mateos
-- 
-- Create Date: 24.11.2020 18:13:01
-- Design Name: 
-- Module Name: cerrojo - Behavioral
-- Project Name: Práctica 2 
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

entity cerrojo is
    port (
        rst : IN std_logic;
        clk : IN std_logic;
        boton : IN std_logic;
        clave : IN std_logic_vector (7 DOWNTO 0);
        bloqueado : OUT std_logic;
        --bloqueado : OUT std_logic_vector (7 DOWNTO 0); -- para placa
        intentos : OUT std_logic_vector (3 DOWNTO 0)
     );
end cerrojo;

architecture Behavioral of cerrojo is

--Señales
type estados is (estado_inicial, estado_tres, estado_dos, estado_uno, estado_final);
signal estado_actual, estado_siguiente : estados;

signal s_clave	: std_logic_vector (7 downto 0);
signal s_intentos	: std_logic_vector (3 downto 0);
signal s_boton_debouncer : std_logic;
signal s_clk	: std_logic;
signal s_display : std_logic_vector(6 downto 0);

--Componentes

component conv_7seg is
		port (
			x 		: in  std_logic_vector (3 downto 0);
			display	: out std_logic_vector (6 downto 0)
		);
end component;

component debouncer is
		port (
			rst             : in  std_logic;
			clk             : in  std_logic;
			x               : in  std_logic;
			xDeb            : out std_logic;
			xDebFallingEdge : out std_logic;
			xDebRisingEdge  : out std_logic	
		);
end component;

begin

--Instanciamos componentes para placa

    i_conv_7seg : conv_7seg 
		port map (	
			x 			=> s_intentos,
			display 	=> s_display
		);
		
	i_debouncer : debouncer 
		port map (
		   rst => rst,
			x => boton,
			clk => clk,
			xDebFallingEdge => s_boton_debouncer
		);
		
--Nos llevamos el clk a una señal y trabajamos sobre ella
s_clk <= clk;
intentos <= s_intentos;

p_registro : process (s_clk, rst)
             begin
                
                if(rst = '1') then
                
                   s_clave <= "00000000";
                   estado_actual <= estado_inicial;
                
                else
                
                   if rising_edge(s_clk) then
                   
                       estado_actual <= estado_siguiente;
                       
                     --  if s_boton_debouncer = '1' and estado_actual = estado_inicial then
                     if boton = '1' and estado_actual = estado_inicial then
                       
                           s_clave <= clave;
                       
                       end if;
                   
                   end if;
                
                end if;	
                    
             end process;
            
p_siguiente_estado: process (estado_actual, boton, clave, s_clave)
             begin
             
                 case estado_actual is
                 
                     when estado_inicial => 
                     
                       -- bloqueado <= "1111111111"; 
                        bloqueado <= '1';
                        s_intentos <="1010";
                        
                         --   if s_boton_debouncer = '1' then
                            if boton = '1' then 
                                estado_siguiente <= estado_tres;
                            else
                                estado_siguiente <= estado_actual;
                           end if;
                            
                     when estado_tres => 
                     
                      --  bloqueado <= "0000000000"; 
                        bloqueado <= '0';
                        s_intentos <="0011";
                        
                           -- if s_boton_debouncer = '1' and s_clave = clave then
                            if boton = '1' and s_clave = clave then 
                                estado_siguiente <= estado_inicial;
                           -- elsif s_boton_debouncer = '1' then
                            elsif boton = '1' then
                                estado_siguiente <= estado_dos;
                            else
                                estado_siguiente <= estado_actual;
                            end if;
    
                     when estado_dos => 
                     
                      --  bloqueado <= "0000000000"; 
                        bloqueado <= '0';
                        s_intentos <="0010";
                        
                            --if s_boton_debouncer = '1' and s_clave = clave then 
                            if boton = '1' and s_clave = clave then 
                                estado_siguiente <= estado_inicial;
                           -- elsif s_boton_debouncer = '1' then
                            elsif boton = '1' then
                                estado_siguiente <= estado_uno;
                            else
                                estado_siguiente <= estado_actual;
                            end if;
    
                     when estado_uno => 
                     
                      --  bloqueado <= "0000000000"; 
                        bloqueado <= '0';
                        s_intentos <="0001";
                        
                           -- if s_boton_debouncer = '1' and s_clave = clave then 
                            if boton = '1' and s_clave = clave then 
                                estado_siguiente <= estado_inicial;
                           -- elsif s_boton_debouncer = '1' then
                            elsif boton = '1' then
                                estado_siguiente <= estado_final;
                            else
                                estado_siguiente <= estado_actual;
                            end if;
                           
                     when estado_final => 
                     
                      --  bloqueado <= "0000000000"; 
                        bloqueado <= '0';
                        s_intentos <="1000";
                        estado_siguiente <= estado_actual;
                                          
                     when others => 
                       -- bloqueado <= "1111111111"; 
                        bloqueado <= '0';
                        s_intentos <="0000";
                        estado_siguiente <= estado_inicial;
                 end case;         
                    
             end process;

end Behavioral;
