library verilog;
use verilog.vl_types.all;
entity PWM is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        duty            : in     vl_logic_vector(9 downto 0);
        PWM_sig         : out    vl_logic
    );
end PWM;
