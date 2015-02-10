library verilog;
use verilog.vl_types.all;
entity add8bit is
    port(
        cout            : out    vl_logic;
        sum             : out    vl_logic_vector(7 downto 0);
        overflow        : out    vl_logic;
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        cin             : in     vl_logic
    );
end add8bit;
