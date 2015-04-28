library verilog;
use verilog.vl_types.all;
entity barcode_mimic is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        period          : in     vl_logic_vector(21 downto 0);
        send            : in     vl_logic;
        station_ID      : in     vl_logic_vector(7 downto 0);
        BC_done         : out    vl_logic;
        BC              : out    vl_logic
    );
end barcode_mimic;
