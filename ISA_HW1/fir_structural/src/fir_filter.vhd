library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity fir_filter is

port(
  clk   : in  std_logic;
  rst_n : in  std_logic;  
  din   : in  signed(n_b-1 downto 0) ;
  vin   : in  std_logic; 
  b     : in  coeff; 
  dout  : out signed(n_b-1 downto 0);
  vout  : out std_logic
    ); 

end entity;


architecture beh of fir_filter is 

component mult is
  
  generic( n : natural );
  port(
        a   : in signed(n-1 downto 0);
        b   : in signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end component;

component add_mult is

  generic( n : natural );
  
  port(
        d_mult  : in  signed(n-1 downto 0);
        b       : in  signed(n-1 downto 0);
        d_sum   : in  signed(n-1 downto 0);		
        res     : out signed(n-1 downto 0)
  );
end component;

component reg_n is

	generic( n : natural );
	
	port(	
		  d 	   :	in  signed(n-1 downto 0);
		  clk 	   :	in  std_logic; 
		  rst_n	   :	in  std_logic; 
		  en 	   :    in  std_logic; 		  
		  q  	   :    out signed(n-1 downto 0)
		  
		);

end component;

component reg_coeff is
	
	port(	
		  d      :	in  coeff;
		  clk 	 :	in  std_logic; 
		  rst_n	 :	in  std_logic; 
		  en 	 :  in  std_logic; 		  
		  q  	 :  out coeff
		  
		);

end component;

component ff is
	
	port(	
		  d 		:	in  std_logic;
		  clk 		:	in  std_logic; 
		  rst_n	    :	in  std_logic;
		  q  		:   out std_logic
		  
		);

end component;

component reg_chain is

	generic( n : natural );
	
	port(	
		  d 	  :	in  signed(n-1 downto 0);
		  clk 	  :	in  std_logic; 
		  rst_n	  :	in  std_logic; 
		  en 	  : in  std_logic; 		  
		  q  	  : out coeff
		  
		);

end component; 

signal q_reg_samp   : signed(n_b-1 downto 0);
signal q_reg_chain  : coeff;
signal q_reg_coeff  : coeff;
signal data_sum     : coeff; -- the data in input at the 10 adders can be described with the same type of the coeffcients
signal en_reg_out   : std_logic; 


begin

reg_samples: reg_n generic map (n => n_b)
               port map(
			            d     => din,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg_samp
			            );
						
reg_coefficients: reg_coeff
               port map(
			            d     => b,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg_coeff
			            );						

reg_out: reg_n generic map (n => n_b)
               port map(
			            d     => data_sum(N),      
						clk   => clk,
						rst_n => rst_n,
						en    => en_reg_out,     
						q     => dout
			            );

ff_en_reg_out: ff 
               port map(
			            d     => vin,
						clk   => clk,
						rst_n => rst_n,
						q     => en_reg_out
			            );	
						
ff_vout: ff 
               port map(
			            d     => en_reg_out,
						clk   => clk,
						rst_n => rst_n,
						q     => vout
			            );						
						
delay_line: reg_chain generic map (n => n_b)
               port map(
			            d     => q_reg_samp,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg_chain					  
                        );					
						
first_coeff: mult generic map (n => n_b) 
               port map(
				        a   => q_reg_samp,
					    b   => q_reg_coeff(0), 
					    res => data_sum(0)
				       );
					   
operations: for i in 0 to N-1 generate 

adder_mult:	add_mult generic map (n => n_b)

		       port map(
			            d_mult  => q_reg_chain(i+1),
						b       => q_reg_coeff(i+1),
						d_sum   => data_sum(i),
						res     => data_sum(i+1)
		                );
	
end generate;					    
 
end architecture;


  

