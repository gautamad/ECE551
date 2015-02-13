library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        Accum           : in     vl_logic_vector(15 downto 0);
        Pcomp           : in     vl_logic_vector(15 downto 0);
        Pterm           : in     vl_logic_vector(13 downto 0);
        Fwd             : in     vl_logic_vector(11 downto 0);
        A2D_res         : in     vl_logic_vector(11 downto 0);
        Error           : in     vl_logic_vector(11 downto 0);
        Intgrl          : in     vl_logic_vector(11 downto 0);
        Icomp           : in     vl_logic_vector(11 downto 0);
        Iterm           : in     vl_logic_vector(11 downto 0);
        src1sel         : in     vl_logic_vector(2 downto 0);
        src0sel         : in     vl_logic_vector(2 downto 0);
        multiply        : in     vl_logic;
        sub             : in     vl_logic;
        mult2           : in     vl_logic;
        mult4           : in     vl_logic;
        saturate        : in     vl_logic;
        dst             : out    vl_logic_vector(15 downto 0)
    );
end ALU;
