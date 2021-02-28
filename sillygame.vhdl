--
--
--
library ieee;
use ieee.std_logic_1164.all;
use work.SillyGamePack.all;

entity SillyGame is port(
  signal INCLK: in std_logic;
  signal SW: in std_logic_vector(1 downto 0);
  signal DISP: out t_displays;
  signal LEDR: out std_logic_vector(9 downto 0)
);
end entity SillyGame;

architecture SillyGame_arch of SillyGame is

  -- InputController component and associated signal(s)
  signal GameReset: std_logic := '0';
  component inputcontroller port(
    button0: in std_logic;
    button1: in std_logic;
    PlayerUp: out std_logic;
    PlayerDown: out std_logic;
    GameReset: out std_logic
  );
  end component inputcontroller;

  -- GameClock component and signals
  signal GameCLK: std_logic;
  component gameclock port(
    GameReset: in std_logic;
    INCLK: in std_logic;
    OUTCLK: out std_logic;
    isHit: in std_logic;
    PlayerLevel: out integer;
    PlayerScore: in integer
  );
  end component gameclock;

  -- Player component
  signal p1: t_player;
  component player port(
    GameReset: in std_logic;
    p1: inout t_player
  );
  end component player;

  -- Display component
  signal displays: t_displays;
  component display port(
    p1: in t_player;
    enemy1: in t_enemy;
    SSDISP: out t_displays
  );
  end component display;

  -- Enemy component
  signal enemy1: t_enemy;
  component enemy port(
    GameCLK: in std_logic;
    GameReset: in std_logic;
    random: in std_logic;
    enemy1: inout t_enemy := c_enemy_init;
    PlayerScored: out std_logic
  );
  end component enemy;

  -- Hit Test component
  component hittest port(
    PlayerRow: inout std_logic;
    enemy1: in t_enemy;
    isHit: out std_logic
  );
  end component hittest;

  -- Randomizer component
  signal random: std_logic;
  component randomizer port(
    CLK: in std_logic;
    random: out std_logic
  );
  end component randomizer;

  -- LED driver
  component leddriver port(
    PlayerLevel: in integer;
    LED: out std_logic_vector(9 downto 0)
  );
  end component leddriver;

begin

--  LEDR(9) <= PlayerUp;
--  LEDR(8) <= PlayerDown;
--  LEDR(7) <= GameReset;
--  LEDR(6) <= PlayerScored;
--  LEDR(5) <= isHit;
--  LEDR(4) <= '0';
--  LEDR(3) <= enemy1.alive;
--  LEDR(2) <= GameCLK;
--  LEDR(1) <= '0';
--  LEDR(0) <= random;

  inputcontroller_component: inputcontroller port map(SW(0), SW(1), p1.up, p1.down, GameReset);
  player_component: player port map(GameReset, p1);
  enemy1_component: enemy port map(GameCLK, GameReset, random, enemy1, p1.scored);
  display_component: display port map(p1, enemy1, DISP);
  gameclock_component: gameclock port map(GameReset, INCLK, GameCLK, p1.isHit, p1.level, p1.score);
  randomizer_component: randomizer port map(INCLK, random);
  hittest_component: hittest port map (p1.row, enemy1, p1.isHit);
  leddriver_component: leddriver port map (p1.level, LEDR);

end architecture SillyGame_arch;
