library verilog;
use verilog.vl_types.all;
entity LEDBlinkFPGA is
    port(
        clk             : in     vl_logic;
        RST_n           : in     vl_logic;
        LEDs            : out    vl_logic_vector(7 downto 0)
    );
end LEDBlinkFPGA;
