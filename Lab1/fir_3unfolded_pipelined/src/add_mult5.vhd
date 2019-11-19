library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity add_mult5 is

  generic( n : natural );
  
  port(
        clk      : in std_logic;
		rst_n    : in std_logic;
		en       : in std_logic;
		en2      : in std_logic;
		en3      : in std_logic;
		en4      : in std_logic;
		en5      : in std_logic;
        d_mult1  : in  signed(n-1 downto 0);
        d_mult2  : in  signed(n-1 downto 0);		
        b1       : in  signed(n-1 downto 0);
        b2       : in  signed(n-1 downto 0);		
        d_sum    : in  signed(n-1 downto 0);		
        res      : out signed(n-1 downto 0)
  );
end entity;

architecture behavior of add_mult5 is

component mult is
  
  generic( n : natural );
  port(
        a   : in signed(n-1 downto 0);
        b   : in signed(n-1 downto 0);
        res : out signed(n-1 downto 0)
  );
end component;

component reg_n is

	generic( n : natural );
	
	port(	
		  d      :	in  signed(n-1 downto 0);
		  clk 	 :	in  std_logic; 
		  rst_n	 :	in  std_logic;        
		  en 	 :  in  std_logic; 		  
		  q  	 :  out signed(n-1 downto 0)
		  
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

signal res_mult1 : signed(n-1 downto 0);
signal res_mult2 : signed(n-1 downto 0);
signal q_reg1    : signed(n-1 downto 0);
signal q_reg2    : signed(n-1 downto 0);
signal q_reg3    : signed(n-1 downto 0);
signal q_reg4    : signed(n-1 downto 0);
signal q_reg5    : signed(n-1 downto 0);
signal q_reg6    : signed(n-1 downto 0);
signal q_reg7    : signed(n-1 downto 0);
signal q_reg8    : signed(n-1 downto 0);
signal q_reg9    : signed(n-1 downto 0);
signal q_reg10    : signed(n-1 downto 0);
signal q_sum1    : signed(n-1 downto 0);
  
begin
	
multiplication1: mult generic map (n => n_b)
             port map(
				      a => d_mult1,
					  b => b1, 
					  res => res_mult1
				      );
					  
multiplication2: mult generic map (n => n_b)
             port map(
				      a => d_mult2,
					  b => b2, 
					  res => res_mult2
				      );					  
					  
reg_n1 : reg_n generic map (n => n_b)
             port map(
				      d     => res_mult1,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en,
					  q     => q_reg1
				      );					 

reg_n2 : reg_n generic map (n => n_b)
             port map(
				      d     => res_mult2,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en,
					  q     => q_reg2
				      );	
					  
reg_n3 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg1,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en2,
					  q     => q_reg3
				      );					 

reg_n4 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg2,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en2,
					  q     => q_reg4
				      );	

reg_n5 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg3,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en3,
					  q     => q_reg5
				      );					 

reg_n6 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg4,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en3,
					  q     => q_reg6
				      );		

reg_n7 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg5,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en4,
					  q     => q_reg7
				      );					 

reg_n8 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg6,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en4,
					  q     => q_reg8
				      );			

reg_n9 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg7,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en5,
					  q     => q_reg9
				      );					 

reg_n10 : reg_n generic map (n => n_b)
             port map(
				      d     => q_reg8,
					  clk   => clk, 
					  rst_n => rst_n,
					  en    => en5,
					  q     => q_reg10
				      );								  
					 
addition1: adder generic map (n => n_b)	
             port map(
				      a   => q_reg9,
					  b   => d_sum, 
					  res => q_sum1
				      );				  

addition2: adder generic map (n => n_b)	
             port map(
				      a   => q_reg10,
					  b   => q_sum1, 
					  res => res
				      );

end architecture behavior; 
