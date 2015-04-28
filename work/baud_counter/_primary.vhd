library verilog;
use verilog.vl_types.all;
entity baud_counter is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        rst_n           : in     vl_logic;
        transmitting    : in     vl_logic;
        shift_reg       : out    vl_logic
    );
end baud_counter;
