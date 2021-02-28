--
--
--
library ieee;
use ieee.std_logic_1164.all;

entity randomizer is port(
  CLK: in std_logic;      -- this should be a fast system clock, not the game clock
  random: out std_logic
  );
end entity randomizer;

architecture randomizer_arch of randomizer is
  signal qt: std_logic_vector(7 downto 0) := "11010010";
begin

  randomizer_proc: process(CLK)
    variable tmp: std_logic;
  begin
    if (rising_edge(CLK))
    then
      tmp := qt(4) xor qt(3) xor qt(2) xor qt(0);
      qt <= tmp & qt(7 downto 1);
    end if;
  end process randomizer_proc;

  random <= qt(7);

end architecture randomizer_arch;
