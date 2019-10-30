library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity fir_block_3 is

  generic( n : natural );

port(
  clk         : in  std_logic;
  rst_n       : in  std_logic;  
  din         : in  signed(n-1 downto 0) ;
  vin         : in  std_logic;
  en_reg_out  : in  std_logic;
  en          : in  std_logic;
  en2         : in  std_logic;
  en3         : in  std_logic;
  b           : in  coeff; 
  di1         : in  signed(n-1 downto 0);    -- the first index represent the input number (starting from left an so also the number of the coefficient),
  di2         : in  signed(n-1 downto 0);    -- the second index represent the the starting block    
  di3         : in  signed(n-1 downto 0);   
  di4         : in  signed(n-1 downto 0);   
  di5         : in  signed(n-1 downto 0);   
  di6         : in  signed(n-1 downto 0);   
  di7         : in  signed(n-1 downto 0);   
  do1         : out signed(n-1 downto 0);    
  do2         : out signed(n-1 downto 0);     
  do3         : out signed(n-1 downto 0);
  do4         : out signed(n-1 downto 0);
  dout        : out signed(n-1 downto 0)
    ); 

end entity;


architecture beh of fir_block_3 is 

component mult is
  
  generic( n : natural );
  port(
        a   : in signed(n-1 downto 0);
        b   : in signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end component;

component add_mult1 is

  generic( n : natural );
  
  port(
        clk      : in std_logic;
		rst_n    : in std_logic;
		en       : in std_logic;
        d_mult1  : in  signed(n-1 downto 0);
        d_mult2  : in  signed(n-1 downto 0);
        d_mult3  : in  signed(n-1 downto 0);
        d_mult4  : in  signed(n-1 downto 0);		
        b1       : in  signed(n-1 downto 0);
        b2       : in  signed(n-1 downto 0);
        b3       : in  signed(n-1 downto 0);
        b4       : in  signed(n-1 downto 0);		
        d_sum    : in  signed(n-1 downto 0);		
        res      : out signed(n-1 downto 0)
  );
end component;

component add_mult2 is

  generic( n : natural );
  
  port(
        clk      : in std_logic;
		rst_n    : in std_logic;
		en       : in std_logic;
		en2      : in std_logic;
        d_mult1  : in  signed(n-1 downto 0);
        d_mult2  : in  signed(n-1 downto 0);
        d_mult3  : in  signed(n-1 downto 0);
        d_mult4  : in  signed(n-1 downto 0);		
        b1       : in  signed(n-1 downto 0);
        b2       : in  signed(n-1 downto 0);
        b3       : in  signed(n-1 downto 0);
        b4       : in  signed(n-1 downto 0);		
        d_sum    : in  signed(n-1 downto 0);		
        res      : out signed(n-1 downto 0)
  );
end component;

component add_mult3 is

  generic( n : natural );
  
  port(
        clk      : in std_logic;
		rst_n    : in std_logic;
		en       : in std_logic;
		en2      : in std_logic;
		en3      : in std_logic;		
        d_mult1  : in  signed(n-1 downto 0);
        d_mult2  : in  signed(n-1 downto 0);		
        b1       : in  signed(n-1 downto 0);
        b2       : in  signed(n-1 downto 0);		
        d_sum    : in  signed(n-1 downto 0);		
        res      : out signed(n-1 downto 0)
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

signal q_reg_samp   : signed(n_b-1 downto 0);
signal q_reg_coeff  : coeff;
signal data_mul     : coeff;                       -- this signal contains the inputs of the multipliers 

signal q_reg1   : signed(n_b-1 downto 0);
signal q_reg2   : signed(n_b-1 downto 0);
signal q_reg3   : signed(n_b-1 downto 0);
signal q_reg4   : signed(n_b-1 downto 0);

signal q_ext_reg1   : signed(n_b-1 downto 0);
signal q_ext_reg2   : signed(n_b-1 downto 0);
signal q_ext_reg3   : signed(n_b-1 downto 0);
signal data_sum     : sum_prop;  

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
			            d     => data_sum(3),      
						clk   => clk,
						rst_n => rst_n,
						en    => en_reg_out,     
						q     => dout
			            );									
						
reg1: reg_n generic map (n => n_b)
               port map(
			            d     => q_reg_samp,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg1
			            );	

reg2: reg_n generic map (n => n_b)
               port map(
			            d     => q_reg1,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg2
			            );	

reg3: reg_n generic map (n => n_b)
               port map(
			            d     => q_reg2,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg3
			            );	
						
reg4: reg_n generic map (n => n_b)
               port map(
			            d     => q_reg3,
						clk   => clk,
						rst_n => rst_n,
						en    => vin,
						q     => q_reg4
			            );							
						
first_coeff: mult generic map (n => n_b) 
               port map(
				        a   => q_reg_samp,
					    b   => q_reg_coeff(0), 
					    res => data_sum(0)
				       );
					   
external_reg1: reg_n generic map (n => n_b)
               port map(
			            d     => data_sum(0),
						clk   => clk,
						rst_n => rst_n,
						en    => en,
						q     => q_ext_reg1
			            );		

external_reg2: reg_n generic map (n => n_b)
               port map(
			            d     => data_sum(1),   
						clk   => clk,
						rst_n => rst_n,
						en    => en2,
						q     => q_ext_reg2
			            );	

external_reg3: reg_n generic map (n => n_b)
               port map(
			            d     => data_sum(2),   
						clk   => clk,
						rst_n => rst_n,
						en    => en3,
						q     => q_ext_reg3
			            );															   
						
adder_mult1:	add_mult1 generic map (n => n_b)

		       port map(
			            clk     => clk, 
						rst_n   => rst_n,
						en      => en, 
			            d_mult1 => data_mul(1),
			            d_mult2 => data_mul(2),
			            d_mult3 => data_mul(3),
			            d_mult4 => data_mul(4),						
						b1      => q_reg_coeff(1),
						b2      => q_reg_coeff(2),
						b3      => q_reg_coeff(3),
						b4      => q_reg_coeff(4),						
						d_sum   => q_ext_reg1,       
						res     => data_sum(1)      
		                );		

adder_mult2:	add_mult2 generic map (n => n_b)

		       port map(
			            clk     => clk, 
						rst_n   => rst_n,
						en      => en, 
						en2     => en2, 
			            d_mult1 => data_mul(5),
			            d_mult2 => data_mul(6),
			            d_mult3 => data_mul(7),
			            d_mult4 => data_mul(8),						
						b1      => q_reg_coeff(5),
						b2      => q_reg_coeff(6),
						b3      => q_reg_coeff(7),
						b4      => q_reg_coeff(8),
						d_sum   => q_ext_reg2,       
						res     => data_sum(2)      
		                );								
						
adder_mult3:	add_mult3 generic map (n => n_b)

		       port map(
			            clk     => clk, 
						rst_n   => rst_n,
						en      => en, 
						en2     => en2, 
						en3     => en3, 
			            d_mult1 => data_mul(9),
			            d_mult2 => data_mul(10),
						b1      => q_reg_coeff(9),
						b2      => q_reg_coeff(10),
						d_sum   => q_ext_reg3,       
						res     => data_sum(3)      
		                );									

data_mul(1) <=  di1;
data_mul(2) <=  di2;					    
data_mul(3) <=  q_reg1;					    
data_mul(4) <=  di3;					    
data_mul(5) <=  di4;					    
data_mul(6) <=  q_reg2;					    
data_mul(7) <=  di5;					    
data_mul(8) <=  di6;					    
data_mul(9) <=  q_reg3;					    
data_mul(10)<=  di7;	

do1 <= q_reg1;
do2 <= q_reg2;
do3 <= q_reg3;
do4 <= q_reg4;						    
 
end architecture;


  

