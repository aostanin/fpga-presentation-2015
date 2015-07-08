library IEEE;
use IEEE.std_logic_1164.all;

entity gpio is
  generic (
    data_width : integer := 8
  );
  port (
    cs_n       : in  std_logic := '1';
    r_w        : in  std_logic := '1';
    reset_n    : in  std_logic := '0';
    data_in    : in  std_logic_vector(data_width - 1 downto 0) := (others => '0');
    data_out   : out std_logic_vector(data_width - 1 downto 0) := (others => 'Z');

    gpio_in    : in  std_logic_vector(data_width - 1 downto 0) := (others => '0');
    gpio_out   : out std_logic_vector(data_width - 1 downto 0) := (others => '0')
  );
end gpio;


architecture rtl of gpio is

  signal gpio_out_reg : std_logic_vector(data_width - 1 downto 0) := (others => '0');

begin

  gpio_out <= gpio_out_reg;

  process (cs_n, r_w, reset_n)
  begin
    if cs_n = '0' and reset_n = '1' then
      if r_w = '0' then
        gpio_out_reg <= data_in;
      else
        data_out <= gpio_in;
      end if;
    else
      data_out <= (others => 'Z');
    end if;
  end process;

end rtl;

