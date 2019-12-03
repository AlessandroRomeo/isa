LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY full_adder IS
    PORT(
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C_IN : IN STD_LOGIC;
        SUM : OUT STD_LOGIC;
        C_OUT : OUT STD_LOGIC
        );				
END ENTITY;

ARCHITECTURE structure OF full_adder IS
    
    COMPONENT half_adder
        PORT(
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            SUM : OUT STD_LOGIC;
            C_OUT : OUT STD_LOGIC
            );				
    END COMPONENT;

    SIGNAL s0, c0, c1 : STD_LOGIC;
    
    BEGIN
    
    HA0 : half_adder
        PORT MAP(
                A=>A,
                B=>B,
                SUM=>s0,
                C_OUT=>c0);
            
    HA1 : half_adder
        PORT MAP(
                A=>s0,
                B=>C_IN,
                SUM=>SUM,
                C_OUT=>c1);
    
    C_OUT <= c0 XOR c1;
    
END ARCHITECTURE;
