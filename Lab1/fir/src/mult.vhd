library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity mult is
  
  generic( n : natural );
  port(
        a   : in signed(n-1 downto 0);
        b   : in signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end entity;

architecture beh of mult is 

signal tmp  : signed(2*n-1 downto 0);

begin

tmp <= a*b; 

res <= tmp(2*n-2 downto 13);

end architecture; 
 