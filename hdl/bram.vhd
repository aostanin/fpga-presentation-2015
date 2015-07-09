library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity bram is
  generic (
    data_width : integer := 16;
    words      : integer := 1024
  );
  port (
    clk      : in  std_logic := '0';
    cs_n     : in  std_logic := '1';
    r_w      : in  std_logic := '1';
    addr     : in  std_logic_vector(integer(ceil(log2(real(words)))) - 1 downto 0) := (others => '0');
    data_in  : in  std_logic_vector(data_width - 1 downto 0) := (others => '0');
    data_out : out std_logic_vector(data_width - 1 downto 0) := (others => 'Z')
  );
end bram;

architecture rtl of bram is

  type memory_t is array(words - 1 downto 0) of std_logic_vector(data_width - 1 downto 0);

  shared variable memory : memory_t;

begin

  process (clk)
  begin
    if rising_edge(clk) then
      if cs_n = '0' then
        if r_w = '0' then
          memory(conv_integer(addr)) := data_in;
        else
          data_out <= memory(conv_integer(addr));
        end if;
      else
        data_out <= (others => 'Z');
      end if;
    end if;
  end process;

end rtl;

