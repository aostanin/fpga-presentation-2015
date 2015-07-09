library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity example5 is
  port (
    clk_50   : in  std_logic;
    buttons  : in  std_logic_vector(1 downto 0);
    leds     : out std_logic_vector(7 downto 0)
  );
end example5;

architecture rtl of example5 is

    signal cpu_datain       : std_logic_vector(15 downto 0) := (others => '0');
    signal cpu_dataout      : std_logic_vector(15 downto 0) := (others => '0');
    signal cpu_addr         : std_logic_vector(31 downto 0) := (others => '0');
    signal cpu_as_n         : std_logic := '1';
    signal cpu_r_w          : std_logic := '1';

    signal reset_n          : std_logic := '0';
    signal reset_cnt        : std_logic_vector(4 downto 0) := (others => '0');

    signal bootrom_cs_n     : std_logic := '1';
    signal bootrom_dataout  : std_logic_vector(15 downto 0) := (others => '0');

    signal bram_cs_n        : std_logic := '1';
    signal bram_dataout     : std_logic_vector(15 downto 0) := (others => '0');

    signal gpio_led_cs_n    : std_logic := '1';
    signal gpio_led_gpioout : std_logic_vector(15 downto 0) := (others => '0');

    signal gpio_btn_cs_n    : std_logic := '1';
    signal gpio_btn_gpioin  : std_logic_vector(15 downto 0) := (others => '0');
    signal gpio_btn_dataout : std_logic_vector(15 downto 0) := (others => '0');

begin

    -- CPU作ろう
    cpu_inst : entity work.TG68
    port map (
        clk      => clk_50,
        reset    => reset_n,
        data_in  => cpu_datain,
        data_out => cpu_dataout,
        addr     => cpu_addr,
        as       => cpu_as_n,
        uds      => open,
        lds      => open,
        rw       => cpu_r_w,
        dtack    => '0'
    );

    -- ROM
    bootrom_inst : entity work.bootrom
    port map (
        ce_n     => '0',
        oe_n     => '0',
        addr     => cpu_addr(12 downto 0),
        data_out => bootrom_dataout
    );

    -- RAM
    bram_inst : entity work.bram
    generic map (
        data_width => 16,
        words      => 4096
    )
    port map (
        clk      => clk_50,
        cs_n     => bram_cs_n,
        r_w      => cpu_r_w,
        addr     => cpu_addr(12 downto 1),
        data_in  => cpu_dataout,
        data_out => bram_dataout
    );

    -- ボタンのGPIO
    gpio_btn_inst : entity work.gpio
    generic map (
        data_width => 16
    )
    port map (
        reset_n  => reset_n,
        cs_n     => gpio_btn_cs_n,
        r_w      => cpu_r_w,
        data_in  => open,
        data_out => gpio_btn_dataout,
        gpio_in  => gpio_btn_gpioin,
        gpio_out => open
    );

    gpio_btn_gpioin <= (15 downto 2 => '0') & buttons;

    -- LEDのGPIO
    gpio_led_inst : entity work.gpio
    generic map (
        data_width => 16
    )
    port map (
        reset_n  => reset_n,
        cs_n     => gpio_led_cs_n,
        r_w      => cpu_r_w,
        data_in  => cpu_dataout,
        data_out => open,
        gpio_in  => open,
        gpio_out => gpio_led_gpioout
    );

    leds <= gpio_led_gpioout(7 downto 0);

    -- チップセレクトを設定
    bootrom_cs_n  <= '0' when cpu_as_n = '0' and cpu_addr(31 downto 28) = X"0"        else '1';
    bram_cs_n     <= '0' when cpu_as_n = '0' and cpu_addr(31 downto 28) = X"1"        else '1';
    gpio_btn_cs_n <= '0' when cpu_as_n = '0' and cpu_addr               = X"A0000000" else '1';
    gpio_led_cs_n <= '0' when cpu_as_n = '0' and cpu_addr               = X"A0000002" else '1';

    -- CPUのデータバスを繋ぐ
    cpu_datain <= bootrom_dataout  when bootrom_cs_n = '0' else
                  bram_dataout     when bram_cs_n = '0' else
                  gpio_btn_dataout when gpio_btn_cs_n = '0' else
                  (others => '0');

    -- 起動時はCPUのresetラインを'0'にしないといけない
    set_reset : process(clk_50)
    begin
        if rising_edge(clk_50) then
            if reset_cnt < 31 then
                reset_n <= '0';
                reset_cnt <= reset_cnt + 1;
            else
                reset_n <= '1';
            end if;
        end if;
    end process;

end rtl;

