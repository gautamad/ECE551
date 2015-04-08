library verilog;
use verilog.vl_types.all;
entity bit_counter is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        shift           : in     vl_logic;
        bit_cnt         : out    vl_logic_vector(3 downto 0)
    );
end bit_counter;
