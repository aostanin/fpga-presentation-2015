library IEEE;
use IEEE.std_logic_1164.all;

entity example1 is
  port (
    buttons : in  std_logic_vector(1 downto 0);
    leds    : out std_logic_vector(7 downto 0)
  );
end example1;

architecture rtl of example1 is
begin

    -- ボタンだと押す時は'0'で押さない時は'1'
    leds <= "000000" & (not buttons);

end rtl;

