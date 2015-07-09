library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_tb is
end top_tb;

architecture test of top_tb is
  constant clk_period   : time := 20 ns;

  signal   clk          : std_logic := '0';

  signal   buttons      : std_logic_vector(1 downto 0) := (others => '0');
  signal   leds         : std_logic_vector(7 downto 0) := (others => '0');

begin

  example_inst : entity work.example4
  port map(
    clk_50       => clk,
    buttons      => buttons,
    leds         => leds
  );

  process
  begin
    clk <= '0';
    wait for clk_period / 2;
    clk <= '1';
    wait for clk_period / 2;
  end process;

end test;
