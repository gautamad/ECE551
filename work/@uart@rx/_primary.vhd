library verilog;
use verilog.vl_types.all;
entity UartRx is
    port(
        rdy             : out    vl_logic;
        cmd             : out    vl_logic_vector(7 downto 0);
        clr_rdy         : in     vl_logic;
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        RX              : in     vl_logic
    );
end UartRx;
