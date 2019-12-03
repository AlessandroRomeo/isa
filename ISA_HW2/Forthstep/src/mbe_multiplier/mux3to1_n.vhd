LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux3to1_n IS
    GENERIC( N : INTEGER := 8);
    PORT(
        IN00    : IN UNSIGNED(N-1 DOWNTO 0);
        IN01_10 : IN UNSIGNED(N-1 DOWNTO 0);
        IN11    : IN UNSIGNED(N-1 DOWNTO 0);
        SEL     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        OUTPUT  : OUT UNSIGNED(N-1 DOWNTO 0)
        );				
END ENTITY;

ARCHITECTURE struct OF mux3to1_n IS

    COMPONENT mux2to1_n
        GENERIC( N : INTEGER := 8);
        PORT(
            IN0    : IN  UNSIGNED(N-1 DOWNTO 0);
            IN1    : IN  UNSIGNED(N-1 DOWNTO 0);
            SEL    : IN  STD_LOGIC;
            OUTPUT : OUT UNSIGNED(N-1 DOWNTO 0)
            );				
    END COMPONENT;
    
    SIGNAL tmp   : UNSIGNED(N-1 DOWNTO 0);
    SIGNAL s_sel : STD_LOGIC;
    
    BEGIN
    
        mux1 : mux2to1_n
            GENERIC MAP(N => N)
            PORT MAP(
                    IN0    => IN00,
                    IN1    => IN11,
                    SEL    => SEL(1),
                    OUTPUT => tmp
					);
					
        mux2 : mux2to1_n
            GENERIC MAP(N => N)
            PORT MAP(
                    IN0    => tmp,
                    IN1    => IN01_10,
                    SEL    => s_sel,
                    OUTPUT => OUTPUT
					);
					
        s_sel <= SEL(0) XOR SEL(1);
        
END ARCHITECTURE;
