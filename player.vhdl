-- Player
-- Control the player position, adjusts PlayerRow
-- Top(0) or Bottom(0)
--
library ieee;
use ieee.std_logic_1164.all;
use work.SillyGamePack.all;

entity Player is port (
    GameReset: in std_logic;
    p1: inout t_player
);
end entity Player;

architecture Player_arch of Player is
begin

  p1.row <= '1' when p1.up = '1' else
            '0' when p1.down = '1';

  score_proc: process(GameReset, p1.scored)
    variable newScore : integer := 0;
  begin
    if (GameReset = '1')
    then
      newScore := 0;
    elsif (rising_edge(p1.scored))
    then
      newScore := p1.score + 1;
    end if;
    p1.score <= newScore;
  end process;

end architecture Player_arch;
