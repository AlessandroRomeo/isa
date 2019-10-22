library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

use work.param.all;

entity reg_coeff is
	
	port(	
		  d      :	in  coeff;
		  clk 	 :	in  std_logic; 
		  rst_n	 :	in  std_logic; 
		  en 	 :  in  std_logic; 		  
		  q  	 :  out coeff
		  
		);

end entity;

architecture beh of reg_coeff is

signal q_rst  : coeff;  

begin

q_rst_cycle:	for j in 0 to n_c-1 generate
	
                q_rst(j) <= (others=>'0');
	
                end generate;

	process(clk, en, rst_n)
	begin
	
	    if rst_n = '0' then
		
		q <= q_rst;

        end if;		
			
    if clk'event and clk='1' and en='1' then
		
		q <= d;
		
     end if;
		
	end process;

end architecture beh; 


