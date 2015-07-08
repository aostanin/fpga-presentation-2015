library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity example2 is
  port (
    clk_50  : in  std_logic;
    buttons : in  std_logic_vector(1 downto 0);
    leds    : out std_logic_vector(7 downto 0)
  );
end example2;

architecture rtl of example2 is

    signal counter : std_logic_vector(31 downto 0);

begin

    process(clk_50)
    begin
        if buttons /= "11" then
            -- ボタン押したらcounterをリセット
            counter <= (others => '0');
        elsif rising_edge(clk_50) then
            -- counterを上がる
            counter <= counter + 1;
        end if;
    end process;

    -- counterのビット24~32をLEDで表示
    leds <= counter(31 downto 24);

end rtl;

