LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY mux2to1_n IS
    GENERIC( N : INTEGER := 8);
    PORT(
        IN0    : IN UNSIGNED(N-1 DOWNTO 0);
        IN1    : IN UNSIGNED(N-1 DOWNTO 0);
        SEL    : IN STD_LOGIC;
        OUTPUT : OUT UNSIGNED(N-1 DOWNTO 0)
        );				
END ENTITY;

ARCHITECTURE struct OF mux2to1_n IS

    BEGIN
    
    mux : FOR i IN 0 TO N-1 GENERATE
        OUTPUT(i) <= (IN1(i) AND SEL) OR (IN0(i) AND NOT SEL);
    END GENERATE;
    
END ARCHITECTURE;
