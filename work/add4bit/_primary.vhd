library verilog;
use verilog.vl_types.all;
entity add4bit is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        Sum             : out    vl_logic_vector(3 downto 0);
        co              : out    vl_logic
    );
end add4bit;
