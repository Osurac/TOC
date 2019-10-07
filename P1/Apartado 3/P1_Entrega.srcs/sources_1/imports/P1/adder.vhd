library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder4b is
    port( a: in  std_logic_vector(7 downto 0);
          b: in  std_logic_vector(7 downto 0);
          c: out std_logic_vector(7 downto 0);
	      op: in bit  );
end adder4b;

architecture rtl of adder4b is
    signal a_u, b_u, c_u, c2: signed(7 downto 0);
    signal op_u: bit;
begin
    a_u <= signed(a);

    op_suma: process (op_u)
      begin
       case op is 
        when '1' => b_u <= not(signed(b)) + "00000001";
        when '0' => b_u <= signed(b);
        when others => 
	end case;
    end process op_suma;

    
    c_u <= a_u + b_u;
    c   <= std_logic_vector(c_u(7 downto 0));
end rtl;

