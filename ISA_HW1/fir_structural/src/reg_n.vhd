library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

entity reg_n is

	generic( n : natural );
	
	port(	
		  d      :	in  signed(n-1 downto 0);
		  clk 	 :	in  std_logic; 
		  rst_n	 :	in  std_logic;        
		  en 	 :  in  std_logic; 		  
		  q  	 :  out signed(n-1 downto 0)
		  
		);

end entity;

architecture beh of reg_n is

begin

	process(clk, en, rst_n)
	begin
	
    if rst_n = '0' then
	
		q <= (others=>'0');

    end if;		
			
    if clk'event and clk='1' and en='1' then
		
		q <= d;
		
     end if;
		
	end process;

end architecture beh; 


