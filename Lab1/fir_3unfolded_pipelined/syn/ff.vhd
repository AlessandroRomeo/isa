library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity ff is
	
	port(	
		  d 		:	in  std_logic;
		  clk 		:	in  std_logic; 
		  rst_n	    :	in  std_logic;
		  q  		:   out std_logic
		  
		);

end entity;

architecture behavior of ff is
begin

	process(clk, rst_n)
	begin
	
		if (rst_n  = '0') then
			    
		    q <= '0';

        end if;			
			
		if (rising_edge(clk)) then
		
			    q  <= d;
			
		end if;
		
	end process;

end architecture behavior; 
