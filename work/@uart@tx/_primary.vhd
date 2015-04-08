library verilog;
use verilog.vl_types.all;
entity UartTx is
    generic(
        IDLE            : integer := 0;
        LOAD            : integer := 1;
        \TRMT\          : integer := 2;
        S3              : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        TX              : out    vl_logic;
        trmt            : in     vl_logic;
        tx_data         : in     vl_logic_vector(7 downto 0);
        tx_done         : out    vl_logic
    );
end UartTx;
