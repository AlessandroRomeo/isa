LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE ieee.numeric_std.all;

PACKAGE param_pkg IS

    TYPE PARTIAL_PRODUCTS IS ARRAY (16 DOWNTO 0) OF UNSIGNED(32+4 DOWNTO 0);
	
END PACKAGE;