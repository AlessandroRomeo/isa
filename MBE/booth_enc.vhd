LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY parprod_sel IS
    GENERIC( N : INTEGER:=8 );
    PORT(
        A       : IN  UNSIGNED(N-1 DOWNTO 0);
        twoA    : IN  UNSIGNED(N-1 DOWNTO 0);
        Z       : IN  UNSIGNED(N-1 DOWNTO 0);
        B_SEL   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        PARPROD : OUT UNSIGNED(N-1 DOWNTO 0)
        );				
END ENTITY;

ARCHITECTURE struct OF parprod_sel IS

    COMPONENT mux3to1_n
        GENERIC( N : INTEGER := 8);
        PORT(
            IN00    : IN  UNSIGNED(N-1 DOWNTO 0);
            IN01_10 : IN  UNSIGNED(N-1 DOWNTO 0);
            IN11    : IN  UNSIGNED(N-1 DOWNTO 0);
            SEL     : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
            OUTPUT  : OUT UNSIGNED(N-1 DOWNTO 0)
            );				
    END COMPONENT;
    
    SIGNAL parprod : UNSIGNED(N-1 DOWNTO 0);
    SIGNAL b_sel : STD_LOGIC_VECTOR(1 DOWNTO 0);
    
    BEGIN
    
        mux : mux3to1_n
		
            GENERIC MAP(N => N)
            PORT MAP(
                    IN00    => Z,
                    IN01_10 => A,
                    IN11    => twoA,
                    SEL     => b_sel,
                    OUTPUT  => parprod
					);

        b_sel(0) <= B_SEL(0) XOR B_SEL(2);
        b_sel(1) <= B_SEL(1) XOR B_SEL(2);
        
        sign_eval : FOR i IN 0 TO N-1 GENERATE
            PARPROD(i) <= parprod(i) XOR B_SEL(2);
        END GENERATE;
        
END ARCHITECTURE;