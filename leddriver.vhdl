--
--
--
library ieee;
use ieee.std_logic_1164.all;

entity leddriver is port(
  PlayerLevel: in integer;
  LED: out std_logic_vector(9 downto 0)
  );
end entity leddriver;

architecture leddriver_arch of leddriver is
begin
  
  led_gen: for iled in 0 to 9 generate
    LED(iled) <= '0' when (PlayerLevel - 1) < (iled) else '1';
  end generate led_gen;

end architecture leddriver_arch;
  