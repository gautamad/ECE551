library verilog;
use verilog.vl_types.all;
entity simple_cnt is
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        count           : out    vl_logic_vector(21 downto 0)
    );
end simple_cnt;
