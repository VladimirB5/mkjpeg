library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use IEEE.NUMERIC_STD.all;

--------------------------------------------------------------------------------
-- ENTITY
--------------------------------------------------------------------------------
entity FinitePrecRndNrst is
  generic
  (
    C_IN_SZ   : natural := 37;
    C_OUT_SZ  : natural := 16;
    C_FRAC_SZ : natural := 15
  );
  port (
    CLK     : in std_logic;
    RST     : in std_logic;
    datain  : in STD_LOGIC_VECTOR(C_IN_SZ-1 downto 0);
    dataval : in std_logic;
    dataout : out STD_LOGIC_VECTOR(C_OUT_SZ-1 downto 0);

    clip_inc : out std_logic;
    dval_out : out std_logic
  );
end FinitePrecRndNrst;


--------------------------------------------------------------------------------
-- ARCHITECTURE
--------------------------------------------------------------------------------
architecture RTL of FinitePrecRndNrst is
   signal sign         : std_logic;
   signal rc_val       : signed(C_IN_SZ-1 downto 0);
   signal data_round_f : signed(C_IN_SZ-1 downto 0);
   signal data_round   : signed(C_IN_SZ-C_FRAC_SZ-1 downto 0);
   signal data_rs      : signed(C_OUT_SZ-1 downto 0);
   signal dataval_d1   : std_logic;
   signal sign_d1      : std_logic;
   signal clip         : std_logic;

 begin
   sign <= datain(C_IN_SZ-1);
   rc_val(C_IN_SZ-1 downto C_FRAC_SZ) <= (others => '0');
   rc_val(C_FRAC_SZ-1) <= '1';
   rc_val(C_FRAC_SZ - 2 downto 0) <= (others => '0');

   reg1 : PROCESS (CLK, RST)
    BEGIN
     IF RST = '1' THEN
       data_round_f <= (others => '0');
       dataval_d1   <= '0';
       sign_d1      <= '0';
       dval_out     <= '0';
     ELSIF rising_edge(CLK) THEN
       data_round_f <= signed(datain) + rc_val;
       dataval_d1   <= dataval;
       dval_out     <= dataval_d1;
       sign_d1      <= sign;
     END IF;
   END PROCESS reg1;

----------------------------------------------------------------
-- Clipping detection
----------------------------------------------------------------

   gen_normal : if (C_IN_SZ-C_FRAC_SZ > C_OUT_SZ) generate
       constant HIGH : integer := C_IN_SZ-C_FRAC_SZ-1;
       constant LOW  : integer := C_OUT_SZ-1;
   begin
       -- Clipping occurs when the selected bits contain
       -- both zeros and ones.
       clip <= (not (and data_round(HIGH downto LOW))) and
               (or data_round(HIGH downto LOW));
   end generate;


   gen_special : if (C_IN_SZ-C_FRAC_SZ = C_OUT_SZ) generate
   begin
       clip <= '1' when
           (data_round(C_OUT_SZ-1) /= sign_d1) and
           (data_round /= to_signed(0, data_round'length))
           else '0';
   end generate;

----------------------------------------------------------------
-- Registered output and saturation
----------------------------------------------------------------
   reg2 : process(CLK, RST)
   begin
       if RST = '1' then
           data_rs  <= (others => '0');
           clip_inc <= '0';
       elsif rising_edge(CLK) then
           clip_inc <= '0';
           if clip = '1' then
               -- Clipping counter increment
               if dataval_d1 = '1' then
                   clip_inc <= '1';
               end if;
               -- Saturation
               if sign_d1 = '1' then
                   -- Minimum + 1
                   data_rs(C_OUT_SZ-1) <= '1';
                   data_rs(C_OUT_SZ-2 downto 0) <= (others => '0');
               else
                   -- Maximum positive value
                   data_rs(C_OUT_SZ-1) <= '0';
                   data_rs(C_OUT_SZ-2 downto 0) <= (others => '1');
               end if;
           else
               data_rs <= data_round(C_OUT_SZ-1 downto 0);
           end if;
       end if;
   end process reg2;

   data_round <= data_round_f(C_IN_SZ-1 downto C_FRAC_SZ);
   dataout <= std_logic_vector(data_rs);

end RTL;
