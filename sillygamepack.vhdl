library ieee;
use ieee.std_logic_1164.all;

package SillyGamePack is

  type t_displays is array(5 downto 0) of std_logic_vector(7 downto 0);

  type t_enemy is record
    row:    std_logic;  -- enemy occupies top or bottom slot
    column: integer;    -- how far away the enemy is
    alive:  std_logic;  -- whether the enemy should be displayed
  end record t_enemy;
  constant c_enemy_init : t_enemy := ( row => '0', column => 0, alive =>'1' );

  type t_player is record
    up:     std_logic;  -- signal to indicate top button pressed, driven by inputcontroller
    down:   std_logic;  -- signal to indicate bottom button pressed, driven by inputcontroller
    row:    std_logic;  -- 2 rows, the player can be on the top row or the bottom
    scored: std_logic;  -- signal to indicate the player has scored, produced by enemy, consumed by player
    score:  integer;    -- number of enemies defeated, unspecified bit size
    level:  integer;    -- score / clkratio, driven and used by gameclock
    isHit:  std_logic;  -- isHit, not iShit, produced by hittest, consumed by enemy
  end record t_player;

end package SillyGamePack;
