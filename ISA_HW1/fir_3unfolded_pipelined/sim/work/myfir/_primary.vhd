library verilog;
use verilog.vl_types.all;
entity myfir is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        din1            : in     vl_logic_vector(13 downto 0);
        din2            : in     vl_logic_vector(13 downto 0);
        din3            : in     vl_logic_vector(13 downto 0);
        vin             : in     vl_logic;
        b0              : in     vl_logic_vector(13 downto 0);
        b1              : in     vl_logic_vector(13 downto 0);
        b2              : in     vl_logic_vector(13 downto 0);
        b3              : in     vl_logic_vector(13 downto 0);
        b4              : in     vl_logic_vector(13 downto 0);
        b5              : in     vl_logic_vector(13 downto 0);
        b6              : in     vl_logic_vector(13 downto 0);
        b7              : in     vl_logic_vector(13 downto 0);
        b8              : in     vl_logic_vector(13 downto 0);
        b9              : in     vl_logic_vector(13 downto 0);
        b10             : in     vl_logic_vector(13 downto 0);
        dout1           : out    vl_logic_vector(13 downto 0);
        dout2           : out    vl_logic_vector(13 downto 0);
        dout3           : out    vl_logic_vector(13 downto 0);
        vout            : out    vl_logic
    );
end myfir;
