----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2019 16:10:28
-- Design Name: 
-- Module Name: cerrojo - arch
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lock is
   port (
      clk   : in std_logic;
      rst   : in std_logic;                      -- reset asincrono
      e     : in std_logic_vector(7 downto 0);   -- la entrada
      b     : in std_logic;                      --si se ha pulsado boton o no (botton)
      t     : out std_logic_vector(6 downto 0);              -- salida de numero de intentos restantes
      o     : out std_logic_vector(15 downto 0);                    -- si se ha abierto o no (output)
      n     : in std_logic_vector(3 downto 0)
   );
end lock;

architecture arch of lock is


   component debouncer is
   port (
       rst             : in  std_logic;
       clk             : in  std_logic;
       x               : in  std_logic;
       xdeb            : out std_logic;
       xdebfallingedge : out std_logic;
       xdebrisingedge  : out std_logic);
   end component debouncer;
   
   
   component conv_7seg is
      port (
      x       : in  std_logic_vector (3 downto 0);
      display : out std_logic_vector (6 downto 0));
   end component conv_7seg;
   
   
   constant c_s0_st : std_logic_vector(2 downto 0) := "000";
   constant c_s1_st : std_logic_vector(2 downto 0) := "001";
   constant c_s2_st : std_logic_vector(2 downto 0) := "010";
   constant c_s3_st : std_logic_vector(2 downto 0) := "011";
   constant c_s4_st : std_logic_vector(2 downto 0) := "100";

   signal current_state , next_state : std_logic_vector(2 downto 0);
   
   signal s_key : std_logic_vector(7 downto 0);
   signal s_tries  : std_logic_vector(3 downto 0);
   signal s_clk : std_logic;
   signal s_button_deb : std_logic;
   signal s_nTries : std_logic_vector(3 downto 0);
   signal currentTries : std_logic_vector(3 downto 0);
   signal cont :unsigned(3 downto 0);
   signal resta : unsigned(3 downto 0);
   
begin

   i_debouncer : debouncer
   port map (
   rst => rst,
   x => b,
   clk => clk,
   xdebfallingedge => s_button_deb
   );
   s_clk <= clk;
   
   i_conv_7seg : conv_7seg
   port map (
      x => s_tries,
      display => t
   );
   
  

   p_reg : process(clk, rst)
   begin
      if rst = '1' then
         current_state <= c_s0_st;
         s_tries <= "0000";
         cont <= "0000";
         currentTries <= "0000";
      else
         if rising_edge(clk) then
            current_state <= next_state; 
            resta <= unsigned(s_nTries) - unsigned(currentTries);
            s_tries <= std_logic_vector(resta);
            cont <= unsigned(currentTries);
            
            if s_button_deb = '1' and current_state = c_s0_st then
               s_key <= e;
               s_nTries <= n;
               currentTries <= "0000";
               
            end if;
         end if;
      end if;
   end process p_reg;
   
   p_comb : process(current_state, s_button_deb, s_key)
   begin
      case current_state is
      
         when c_s0_st =>
         
            o <=  "1111111111111111";
            
            if (s_button_deb = '1') then
               
               next_state <= c_s1_st;
            else
               next_state <= current_state;
            end if;
            
         when c_s1_st =>
         
            o <= "0000000000000000";
            
            if (s_button_deb = '1' and e = s_key) then
               next_state <= c_s0_st;
            else if (s_button_deb = '1' and currentTries < s_nTries) then
                cont <= cont + "0001";
                currentTries <= std_logic_vector(cont);
                next_state <= c_s1_st;
            else if (s_button_deb = '1') then
                next_state <= c_s2_st;
            else
                next_state <= current_state;
            end if;
            end if;
            end if;
            
         when c_s2_st =>
         
             o <= "0000000000000000";
             next_state <= current_state;
            
         when others =>
               next_state <= c_s0_st;
            
      end case;
   end process p_comb;
   
end arch;
