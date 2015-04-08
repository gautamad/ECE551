library verilog;
use verilog.vl_types.all;
entity shift_register is
    port(
        clk             : in     vl_logic;
        TX              : out    vl_logic;
        rst_n           : in     vl_logic;
        tx_data         : in     vl_logic_vector(7 downto 0);
        load            : in     vl_logic;
        shift           : in     vl_logic
    );
end shift_register;
