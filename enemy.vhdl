-- enemy
-- the blocks (err, lines) will advance slowly toward
-- the player, and the player needs to dodge them

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use work.SillyGamePack.all;

entity enemy is port(
  GameCLK: in std_logic;
  GameReset: in std_logic;
  random: in std_logic;
  enemy1: inout t_enemy;
  PlayerScored: out std_logic
);
end entity enemy;

architecture enemy_arch of enemy is
begin

  enemyProc: process(GameCLK, GameReset)
    variable ttl: integer := 9;
  begin
    if (GameReset = '1')
    then
      enemy1 <= c_enemy_init;
      enemy1.row <= random;
    elsif (rising_edge(GameCLK))
    then
      -- advance the enemy position
      -- or remove the enemy from the board if past the end (> 6)
      if (enemy1.alive = '0')
      then
        ttl := ttl - 1;
        PlayerScored <= '0';
        if (ttl = 0)
        then
          ttl := 10;
          enemy1.alive <= '1';
          enemy1.row <= random;
          enemy1.column <= 0;
          PlayerScored <= '0';
        end if;
      else
        if (enemy1.column < 6)
        then
           enemy1.column <= enemy1.column + 1;
        else
           enemy1.alive <= '0';
           PlayerScored <= '1';
        end if;
      end if;
    end if;
  end process enemyProc;

end architecture enemy_arch;
