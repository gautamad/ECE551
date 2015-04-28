library verilog;
use verilog.vl_types.all;
entity barcode is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        BC              : in     vl_logic;
        ID_vld          : out    vl_logic;
        ID              : out    vl_logic_vector(7 downto 0);
        clr_ID_vld      : in     vl_logic
    );
end barcode;
