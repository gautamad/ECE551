library verilog;
use verilog.vl_types.all;
entity motor_driver is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        lft             : in     vl_logic_vector(10 downto 0);
        rht             : in     vl_logic_vector(10 downto 0);
        fwd_lft         : out    vl_logic;
        rev_lft         : out    vl_logic;
        fwd_rht         : out    vl_logic;
        rev_rht         : out    vl_logic
    );
end motor_driver;
