LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.param.all;

ENTITY parprod_gen IS
    PORT(
        A  : IN  UNSIGNED(32-1 DOWNTO 0);
        B  : IN  UNSIGNED(32-1 DOWNTO 0);
        PP : OUT PARTIAL_PRODUCTS
        );
END ENTITY;

ARCHITECTURE struct OF parprod_gen IS
    
    COMPONENT mux2to1_n
        GENERIC( N : INTEGER:= 8);
        PORT(
            IN0    : IN UNSIGNED(N-1 DOWNTO 0);
            IN1    : IN UNSIGNED(N-1 DOWNTO 0);
            SEL    : IN STD_LOGIC;
            OUTPUT : OUT UNSIGNED(N-1 DOWNTO 0)
            );				
    END COMPONENT;	
	
    COMPONENT booth_enc
        GENERIC( N : INTEGER:= 8);
        PORT(
            A       : IN  UNSIGNED(N-1 DOWNTO 0);
            twoA    : IN  UNSIGNED(N-1 DOWNTO 0);
            Z       : IN  UNSIGNED(N-1 DOWNTO 0);
            B_SEL   : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
            PARPROD : OUT UNSIGNED(N-1 DOWNTO 0)
            );				
    END COMPONENT;
	
    
    SIGNAL s_a,s_two_a,s_z : UNSIGNED(32 DOWNTO 0);
    SIGNAL s_b         : STD_LOGIC_VECTOR(32 DOWNTO 0);	
    SIGNAL s_parprod   : PARTIAL_PRODUCTS;
	
	
    BEGIN
    
        s_a <= '0' & A;
        s_two_a <= A & '0';
        s_z <= (OTHERS=>'0');
        s_b <= STD_LOGIC_VECTOR(B) & '0';
        
        --first partial product
        s_parprod(0)(32+4) <= '0';
        s_parprod(0)(32+3) <= NOT s_b(2);
        s_parprod(0)(32+2) <= s_b(2);
        s_parprod(0)(32+1) <= s_b(2);
		
        parprod_0 : booth_enc		
            GENERIC MAP( N => 33)
            PORT MAP(
                    A       => s_a,
                    twoA    => s_two_a,
                    Z       => s_z,
                    B_SEL   => s_b(2 DOWNTO 0),
                    PARPROD => s_parprod(0)(32 DOWNTO 0)
					);
                
        --intermediate partial products
        parprod_interm : FOR i IN 1 TO 14 GENERATE
            s_parprod(i)(32+4) <= '1';
            s_parprod(i)(32+3) <= NOT s_b(2*i+2);
			
            parprod_1_to_14 : booth_enc
                GENERIC MAP(N => 33)
                PORT MAP(
                        A       => s_a,
                        twoA    => s_two_a,
                        Z       => s_z,
                        B_SEL   => s_b(2*i+2 DOWNTO 2*i),
                        PARPROD => s_parprod(i)(32+2 DOWNTO 2)
						);
						
            s_parprod(i)(1) <= '0';
            s_parprod(i)(0) <= s_b(2*i);
        END GENERATE;
        
        --penultimate partial product
        s_parprod(15)(32+4) <= '0';
        s_parprod(15)(32+3) <= NOT s_b(2*15+2);
		
        parprod_15 : booth_enc
            GENERIC MAP(N => 33)
            PORT MAP(
                    A       => s_a,
                    twoA    => s_two_a,
                    Z       => s_z,
                    B_SEL   => s_b(2*15+2 DOWNTO 2*15),
                    PARPROD => s_parprod(15)(32-1+3 DOWNTO 2)
					);
					
        s_parprod(15)(1) <= '0';
        s_parprod(15)(0) <= s_b(2*15);
        
        --last parproduct
        s_parprod(16)(32+4) <= '0';
        s_parprod(16)(32+3) <= '0';
        s_parprod(16)(32+2) <= '0';
		
        parprod_16 : mux2to1_n
            GENERIC MAP(N => 32)
            PORT MAP(
                    IN0    => (OTHERS => '0'),
                    IN1    => A,
                    SEL    => s_b(2*16),
                    OUTPUT => s_parprod(16)(33 DOWNTO 2)
					);
					
        s_parprod(16)(1) <= '0';
        s_parprod(16)(0) <= s_b(2*16);
		
    PP <= s_parprod;
	
END ARCHITECTURE;
