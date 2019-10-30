library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity fir_filter is

port(
     clk   : in  std_logic;
     rst_n : in  std_logic;  
     din   : in  data;
     vin   : in  std_logic; 
     b     : in  coeff; 
     dout  : out data;
     vout  : out std_logic
    ); 

end entity;


architecture beh of fir_filter is 

component fir_block_1_2 is

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

end component;

component fir_block_3 is

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

end component;

component ff is
	
	port(	
		  d 		:	in  std_logic;
		  clk 		:	in  std_logic; 
		  rst_n	    :	in  std_logic;
		  q  		:   out std_logic
		  
		);

end component;

signal s_en_reg_out : std_logic;

signal q_ff1   : std_logic;  
signal q_ff2   : std_logic;  
signal q_ff3   : std_logic;  

signal o1_b1   : signed(n_b-1 downto 0);             -- means out1 of block 1
signal o2_b1   : signed(n_b-1 downto 0);          
signal o3_b1   : signed(n_b-1 downto 0);          
signal o4_b1   : signed(n_b-1 downto 0);  

signal o1_b2   : signed(n_b-1 downto 0);             -- means out1 of block 2
signal o2_b2   : signed(n_b-1 downto 0);          
signal o3_b2   : signed(n_b-1 downto 0);          
signal o4_b2   : signed(n_b-1 downto 0);

signal o1_b3   : signed(n_b-1 downto 0);             -- means out1 of block 3
signal o2_b3   : signed(n_b-1 downto 0);          
signal o3_b3   : signed(n_b-1 downto 0);          
signal o4_b3   : signed(n_b-1 downto 0);        

begin

-- Five FF are required to delay the vout the sixth is used as enable for the reg_out
ff1: ff 
               port map(
			            d     => vin,
						clk   => clk,
						rst_n => rst_n,
						q     => q_ff1
			            );	
						
ff2: ff 
               port map(
			            d     => q_ff1,
						clk   => clk,
						rst_n => rst_n,
						q     => q_ff2
			            );	

ff3: ff 
               port map(
			            d     => q_ff2,
						clk   => clk,
						rst_n => rst_n,
						q     => q_ff3
			            );

ff_en_reg_out: ff 
               port map(
			            d     => q_ff3,
						clk   => clk,
						rst_n => rst_n,
						q     => s_en_reg_out
			            );	

ff_vout: ff 
               port map(
			            d     => s_en_reg_out,
						clk   => clk,
						rst_n => rst_n,
						q     => vout
			            );						
																
						
fir_block1: fir_block_1_2 generic map (n => n_b)
                      
			    port map(
                         clk         => clk,
                         rst_n       => rst_n,
                         din         => din(0),
                         vin         => vin,
                         en_reg_out  => s_en_reg_out,
						 en          => q_ff1,
						 en2         => q_ff2,
						 en3         => q_ff3,					 
                         b           => b,
                         di1         => o1_b3,
                         di2         => o2_b2,
                         di3         => o2_b3,
                         di4         => o3_b2, 
                         di5         => o3_b3,
                         di6         => o4_b2, 
                         di7         => o4_b3,
                         do1         => o1_b1,    
                         do2         => o2_b1,    
                         do3         => o3_b1,
                         do4         => o4_b1,
                         dout        => dout(0)			
				         ); 
						 
fir_block2: fir_block_1_2 generic map (n => n_b)
                      
			    port map(
                         clk         => clk,
                         rst_n       => rst_n,
                         din         => din(1),
                         vin         => vin,
                         en_reg_out  => s_en_reg_out,
						 en          => q_ff1,
						 en2         => q_ff2,
						 en3         => q_ff3,					 
                         b           => b,
                         di1         => o1_b1,
                         di2         => o1_b3,
                         di3         => o2_b1,
                         di4         => o2_b3, 
                         di5         => o3_b1,
                         di6         => o3_b3, 
                         di7         => o4_b1,
                         do1         => o1_b2,    
                         do2         => o2_b2,    
                         do3         => o3_b2,
                         do4         => o4_b2,
                         dout        => dout(1)			
				         ); 		

fir_block3: fir_block_3 generic map (n => n_b)
                      
			    port map(
                         clk         => clk,
                         rst_n       => rst_n,
                         din         => din(2),
                         vin         => vin,
                         en_reg_out  => s_en_reg_out,
						 en          => q_ff1,
						 en2         => q_ff2,
						 en3         => q_ff3,
                         b           => b,
                         di1         => o1_b2,
                         di2         => o1_b1,
                         di3         => o2_b2,
                         di4         => o2_b1, 
                         di5         => o3_b2,
                         di6         => o3_b1, 
                         di7         => o4_b2,
                         do1         => o1_b3,    
                         do2         => o2_b3,    
                         do3         => o3_b3,
                         do4         => o4_b3,
                         dout        => dout(2)			
				         ); 								 
					    
 
end architecture;


  

