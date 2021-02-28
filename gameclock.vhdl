-- gameclock
-- requires a 25MHz clock, or adjust the scaling factor
-- the game clock is much slower than the system clock
-- we need the frequency to be 1Hz or .5Hz or so
-- later, we'll need to make this adjustable so
-- the game can go faster or slower

library ieee;
use ieee.std_logic_1164.all;

entity gameclock is port(
  GameReset: in std_logic;
  INCLK: in std_logic;
  OUTCLK: out std_logic;
  isHit: in std_logic;    -- stop the clock when the player is hit
  PlayerLevel: out integer;
  PlayerScore: in integer	-- used to scale the clock
);
end entity gameclock;

architecture gameclock_arch of gameclock is
  signal level:     integer := 0;       -- the level is based on the score and used to calculate game speed
begin

  PlayerLevel <= level;

	gclkproc: process(GameReset, INCLK)
        variable clockState:std_logic := '0';  -- clock is running(1) or stopped(0)
        variable count:     integer := 0;       -- count the system clocks to produce the game clock
        variable clkvar:    std_logic := '0';   -- used for toggling
        constant maxlevel:  integer := 10;      -- dont exceed max level, as it would make the game too fast.... or should I?
        constant clkratio:  integer := 2;       -- increase game clock on every 2 point increase
	begin
    if (GameReset = '1')
    then
      clockState := '1';
      level <= 0;
    else
      if (isHit = '1' or clockState = '0')
      then
        clockState := '0';
      else
        if (rising_edge(INCLK))
        then
          count := count + 1;
          -- clock goes faster when the player goes up a level
          -- when you get beyond level 10 or so, it might be too fast
          level <= (PlayerScore / clkratio);
          if (level >= maxlevel)
          then
            level <= maxlevel;
          end if;
          if (count > 1250000 - ( level * (1250000 / 11) ) )
          -- 11? 1250000? These numbers are pulled out of thin air,
          -- but seem reasonable in testing
          then
            count := 0;
            clkvar := not clkvar;
            OUTCLK <= clkvar;
          end if;
        end if;
			end if;
		end if;
	end process gclkproc;
end architecture gameclock_arch;
