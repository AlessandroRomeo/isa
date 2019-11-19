library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;

use work.param.all;

entity reg_chain is

	generic( n : natural );
	
	port(	
		  d 	  :	in  signed(n-1 downto 0);
		  clk 	  :	in  std_logic; 
		  rst_n	  :	in  std_logic; 
		  en 	  : in  std_logic; 		  
		  q  	  : out coeff
		  
		);

end entity;

architecture beh of reg_chain is

component reg_n is

	generic( n : natural );
	
	port(	
		  d 	  :	in  signed(n-1 downto 0);
		  clk 	  :	in  std_logic; 
		  rst_n	  :	in  std_logic; 
		  en 	  : in  std_logic; 		  
		  q  	  : out signed(n-1 downto 0)
		  
		);

end component;

signal q_reg : coeff;

begin

q_reg(0) <= d; 

registers: for i in 0 to 9 generate 

delay_chain: reg_n generic map (n => n_b)

		port map(
		          d     => q_reg(i),
			      clk   => clk, 
			      rst_n => rst_n,
			      en    => en, 
                  q     => q_reg(i+1)
		        );
	
end generate;

q <= q_reg;

end architecture beh; 


