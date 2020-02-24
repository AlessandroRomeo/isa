library verilog;
use verilog.vl_types.all;
entity data_mem is
    port(
        clk             : in     vl_logic;
        memRead         : in     vl_logic;
        memWrite        : in     vl_logic;
        address         : in     vl_logic_vector(6 downto 0);
        mem_in          : in     vl_logic_vector(31 downto 0);
        mem_out         : out    vl_logic_vector(31 downto 0)
    );
end data_mem;
