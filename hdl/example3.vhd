library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity example3 is
  port (
    clk_50   : in  std_logic;
    buttons  : in  std_logic_vector(1 downto 0);
    leds     : out std_logic_vector(7 downto 0)
  );
end example3;

architecture rtl of example3 is

    signal cpu_addr  : std_logic_vector(31 downto 0) := (others => '0');
    signal cpu_as_n  : std_logic := '1';

    signal reset_n   : std_logic := '0';
    signal reset_cnt : std_logic_vector(4 downto 0) := (others => '0');

begin

    -- CPU作ろう
    cpu_inst : entity work.TG68
    port map (
        clk => clk_50,
        reset => reset_n,
        data_in => (others => '0'),
        data_out => open,
        addr => cpu_addr,
        as => cpu_as_n,
        uds => open,
        lds => open,
        rw => open,
        dtack => '0'
    );

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

    -- CPUが出してるアドレスの24~32ビットをLEDで表示
    display_address : process(cpu_as_n)
    begin
        if cpu_as_n = '0' then
            leds <= cpu_addr(31 downto 24);
        else
            leds <= (others => '0');
        end if;
    end process;

end rtl;

