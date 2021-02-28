--
--
--
library ieee;
use ieee.std_logic_1164.all;
use work.SillyGamePack.all;

entity hittest is port (
    PlayerRow: inout std_logic;
    enemy1: in t_enemy;
    isHit: out std_logic
);
end entity hittest;

architecture hittest_arch of hittest is
begin

  isHit <= '1' when (enemy1.column = 5 and PlayerRow = enemy1.row) else '0';

end architecture hittest_arch;
