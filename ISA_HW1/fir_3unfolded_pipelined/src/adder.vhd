library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is

  generic( n : natural );
  port(
        a   : in  signed(n-1 downto 0);
        b   : in  signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end entity;

architecture behavior of adder is
  
begin

	res  <= a + b; 	

end architecture behavior; 
