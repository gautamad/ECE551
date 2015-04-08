library verilog;
use verilog.vl_types.all;
entity simple_cnt is
    generic(
        SIZE            : integer := 12
    );
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        count           : out    vl_logic_vector
    );
end simple_cnt;
