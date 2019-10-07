library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder4b is
    port( a: in  std_logic_vector(7 downto 0);
          b: in  std_logic_vector(7 downto 0);
          c: out std_logic_vector(7 downto 0) );
end adder4b;

architecture rtl of adder4b is
    signal a_u, b_u, c_u, c2: signed(7 downto 0);
begin
    a_u <= signed(a);
    b_u <= not(signed(b)); --Invertimos los bits de 1 a 0 y sumamos 1 para pa pasar a c2
    c2 <= b_u + "00000001";
    c_u <= a_u + c2;
    c   <= std_logic_vector(c_u(7 downto 0));
end rtl;
