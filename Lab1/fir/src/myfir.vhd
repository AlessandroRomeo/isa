library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.param.all;

entity myfir is

port(
  clk   : in  std_logic;
  rst_n : in  std_logic;  
  din   : in  signed(13 downto 0);
  vin   : in  std_logic; 
  b0    : in  signed(13 downto 0); 
  b1    : in  signed(13 downto 0); 
  b2    : in  signed(13 downto 0); 
  b3    : in  signed(13 downto 0); 
  b4    : in  signed(13 downto 0); 
  b5    : in  signed(13 downto 0); 
  b6    : in  signed(13 downto 0); 
  b7    : in  signed(13 downto 0); 
  b8    : in  signed(13 downto 0); 
  b9    : in  signed(13 downto 0); 
  b10   : in  signed(13 downto 0); 
  dout  : out signed(13 downto 0);
  vout  : out std_logic
    ); 

end entity;


architecture beh of myfir is 

component fir_filter is

port(
  clk   : in  std_logic;
  rst_n : in  std_logic;  
  din   : in  signed(n_b-1 downto 0) ;
  vin   : in  std_logic; 
  b     : in  coeff; 
  dout  : out signed(n_b-1 downto 0);
  vout  : out std_logic
    ); 

end component;


begin

my_filter:	fir_filter

		       port map(
			            clk   => clk,
						rst_n => rst_n,
						din   => din,
						vin   => vin,
                        b(0)  => b0,
                        b(1)  => b1,
                        b(2)  => b2,
                        b(3)  => b3,
                        b(4)  => b4,
                        b(5)  => b5,
                        b(6)  => b6,
                        b(7)  => b7,
                        b(8)  => b8,
                        b(9)  => b9,
                        b(10) => b10,
                        dout  => dout,
                        vout  => vout
 		                );				    
 
end architecture;


  

