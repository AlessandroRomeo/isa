library ieee;
library std;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use ieee.std_logic_textio.all;

use work.param.all;

entity fir_tb is
	
end entity;

architecture test of fir_tb is

component fir_filter is

port(
     clk   : in  std_logic;
     rst_n : in  std_logic;  
     din   : in  data;
     vin   : in  std_logic; 
     b     : in  coeff; 
     dout  : out data;
     vout  : out std_logic
    ); 
	
end component;
	
	file file_inputs   : text;
	file file_inputs2  : text;	
--	file file_douts    : text;

	
	signal tb_clk		: std_logic;
	
-- signals for the DP	
	signal tb_rst_n        : std_logic;
	signal tb_din    	   : data;
    signal tb_vin          : std_logic;
    signal tb_b            : coeff;	
    signal tb_dout         : data;
    signal tb_vout         : std_logic;		
	
	
begin
	
	process -- clock generation at 500mhz.
	begin
		tb_clk <= '1';
		wait for 1 ns;
		tb_clk <= '0';
		wait for 1 ns;
	end process;
	
	process -- reset generation 
	begin
		tb_rst_n   <= '0';	
		wait for 3 ns;
		tb_rst_n   <= '1';		
		wait;
	end process;
	
	
-- process for:
-- 1) reading inputs from file 
	process
	
	variable v_iline	: line;
	variable v_din   	: std_logic_vector(n_b-1 downto 0); 
	 
	begin
	
	tb_vin <= '0';
	
	wait for 3 ns;
	
    tb_vin <= '1';

	-- opening file			
 	file_open(file_inputs,   "samples_bin.txt",     read_mode); 

	while not endfile(file_inputs) loop  	
	
	for i in 0 to 2 loop 
			readline(file_inputs, v_iline);
			 read(v_iline, v_din);	
			
			  tb_din(i) <= signed(v_din);
	
	end loop;	 

     wait for 2 ns;	
	 
	end loop;	 

    tb_vin <= '0';
	
	 wait for 2 ns; 

	file_close(file_inputs);	
	    
	wait;
	end process;
        
-- process for:
-- 2) reading coefficients from file 
	process
	
	variable v_iline	: line;
	variable v_coeff  	: std_logic_vector(n_b-1 downto 0); 	
	 
	begin
	
	wait for 3 ns;
			
 	file_open(file_inputs2,   "coeffs_bin.txt",     read_mode); 

	for i in 0 to n_c-1 loop	                        
		
			readline(file_inputs2, v_iline);
			read(v_iline, v_coeff);
			tb_b(i) <= signed(v_coeff); 	
			
    end loop;	 
                     
	 wait for 2 ns; 

	file_close(file_inputs2);	
	    
	wait;
	end process;	
	
-- process for:
-- 3) writing douts in a file 
	-- process
	
	-- variable v_oline	: line;			
	 
	-- begin
	
	-- wait for 3 ns;
			
	--opening file
	-- file_open(file_douts,  "sim_douts.txt",     write_mode);
	
	-- wait for 4 ns;	

	-- for i in 0 to 66 loop	                        
		
		-- write(v_oline, std_logic_vector(tb_dout(0)), right, n_b);   
		-- writeline(file_douts, v_oline); 	

		-- write(v_oline, std_logic_vector(tb_dout(1)), right, n_b);   
		-- writeline(file_douts, v_oline); 
		
		-- write(v_oline, std_logic_vector(tb_dout(2)), right, n_b);   
		-- writeline(file_douts, v_oline); 		
		
	 -- wait for 2 ns;
			
    -- end loop;	 
                     
	 -- wait for 2 ns; 

	-- file_close(file_douts);	
	    
	-- wait;
	-- end process;		

	
		
	p_fir : fir_filter
		port map(
		          clk 		  => tb_clk,   
		          rst_n       => tb_rst_n,                                                                
			      din		  => tb_din,       
                  vin         => tb_vin,   			
			      b	          => tb_b,                                       
			      dout	      => tb_dout,  
                  vout        => tb_vout 				  				  
				  
			     );
				 
		 
end test;
        