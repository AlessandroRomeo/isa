LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY half_adder IS
    PORT(
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        SUM : OUT STD_LOGIC;
        C_OUT : OUT STD_LOGIC
        );				
END ENTITY;

ARCHITECTURE structure OF half_adder IS

    BEGIN
    
    SUM <= A XOR B;
    C_OUT <= A AND B;
    
END ARCHITECTURE;
