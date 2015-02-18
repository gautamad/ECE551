library verilog;
use verilog.vl_types.all;
entity reset_synch is
    port(
        \RST_n\         : in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : out    vl_logic
    );
end reset_synch;
