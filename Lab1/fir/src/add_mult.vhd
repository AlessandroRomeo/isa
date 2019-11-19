library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity add_mult is

  generic( n : natural );
  
  port(
        d_mult  : in  signed(n-1 downto 0);
        b       : in  signed(n-1 downto 0);
        d_sum   : in  signed(n-1 downto 0);		
        res     : out signed(n-1 downto 0)
  );
end entity;

architecture behavior of add_mult is

component mult is
  
  generic( n : natural );
  port(
        a   : in signed(n-1 downto 0);
        b   : in signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end component;
  
component adder is

  generic( n : natural );
  port(
        a   : in  signed(n-1 downto 0);
        b   : in  signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end component;

signal res_mult : signed(n-1 downto 0);
  
begin
	
multiplication: mult generic map (n => n_b)
             port map(
				      a => d_mult,
					  b => b, 
					  res => res_mult
				      );
					  
addition: adder generic map (n => n_b)	
             port map(
				      a => res_mult,
					  b => d_sum, 
					  res => res
				      );				  

end architecture behavior; 
