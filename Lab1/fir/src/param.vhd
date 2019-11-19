library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param is
 
 constant N   : natural := 10;  -- filter order
 constant n_b : natural := 14;  -- number of bits
 constant n_c : natural := 11;  -- number of coefficients

 type coeff          is array (0 to n_c-1) of signed (n_b-1 downto 0);
  
end param;

