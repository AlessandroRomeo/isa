library verilog;
use verilog.vl_types.all;
entity main is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        I_mem_out       : in     vl_logic_vector(31 downto 0);
        D_mem_out       : in     vl_logic_vector(31 downto 0);
        I_mem_addr      : out    vl_logic_vector(31 downto 0);
        I_mem_read      : out    vl_logic;
        D_mem_addr      : out    vl_logic_vector(31 downto 0);
        D_mem_in        : out    vl_logic_vector(31 downto 0);
        D_mem_read      : out    vl_logic;
        D_mem_write     : out    vl_logic
    );
end main;
