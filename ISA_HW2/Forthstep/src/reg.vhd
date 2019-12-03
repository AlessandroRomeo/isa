library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg is
	
	port(	
		  d      :	in  std_logic_vector (31 downto 0);
		  clk 	 :	in  std_logic; 		  
		  q  	 :  out std_logic_vector (31 downto 0)
		  
		);

end entity;

architecture beh of reg is

begin

	process(clk)
	begin	
			
    if clk'event and clk='1' then
		
		q <= d;
		
     end if;
		
	end process;

end architecture beh; 


