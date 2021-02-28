-- display - controls the player and enemyy position on the 7 segment display
--
--

library ieee;
use ieee.std_logic_1164.all;
use work.SillyGamePack.all;

entity display is port (
  p1: in t_player;
  enemy1: in t_enemy;
  SSDISP: out t_displays
);
end entity display;

architecture display_arch of display is
  signal enemy1glyph: std_logic_vector(7 downto 0);
  signal playerglyph: std_logic_vector(7 downto 0);
  signal score1glyph: std_logic_vector(7 downto 0);
  signal score2glyph: std_logic_vector(7 downto 0);

  function bcd1scoreglyph(playerScore: integer) return std_logic_vector is
    variable score : integer;
    variable bcds : std_logic_vector(7 downto 0);
  begin
    score := playerScore mod 10;

    if score = 0 then    bcds := "11000000";
    elsif score = 1 then bcds := "11111001";
    elsif score = 2 then bcds := "10100100";
    elsif score = 3 then bcds := "10110000";
    elsif score = 4 then bcds := "10011001";
    elsif score = 5 then bcds := "10010010";
    elsif score = 6 then bcds := "10000010";
    elsif score = 7 then bcds := "11111000";
    elsif score = 8 then bcds := "10000000";
    elsif score = 9 then bcds := "10011000";
    else bcds := "11111111";
    end if;

    return bcds;
  end function;

  function bsd2scoreglyph(playerScore: integer) return std_logic_vector is
    variable score : integer;
    variable bcds : std_logic_vector(7 downto 0);
  begin
    score := playerScore / 10;

    if score = 0 then    bcds := "11000000";
    elsif score = 1 then bcds := "11111001";
    elsif score = 2 then bcds := "10100100";
    elsif score = 3 then bcds := "10110000";
    elsif score = 4 then bcds := "10011001";
    elsif score = 5 then bcds := "10010010";
    elsif score = 6 then bcds := "10000010";
    elsif score = 7 then bcds := "11111000";
    elsif score = 8 then bcds := "10000000";
    elsif score = 9 then bcds := "10011000";
    else bcds := "11111111";
    end if;

    return bcds;
  end function;

  function showScore(player: t_player; enemy: t_enemy) return boolean is
  begin
    return player.isHit = '1' or enemy.alive /= '1';
  end function;

begin

  enemy1glyph <= "10011100" when enemy1.row = '0' else
                 "10100011" when enemy1.row = '1' else
                 "11111111";
  playerglyph <= "11111101" when p1.row = '0' else
                 "11111011";
  score1glyph <= bcd1scoreglyph(p1.score);
  score2glyph <= bsd2scoreglyph(p1.score);

  SSDISP(5) <= playerglyph when enemy1.column /= 5 else playerglyph and enemy1glyph;
  SSDISP(4) <= enemy1glyph when enemy1.column = 4 else "11111111";
  SSDISP(3) <= enemy1glyph when enemy1.column = 3 else "11111111";
  SSDISP(2) <= enemy1glyph when enemy1.column = 2 else "11111111";

  SSDISP(1) <= score2glyph when showScore(p1, enemy1)
          else enemy1glyph when enemy1.column = 1 and enemy1.alive = '1'
          else "11111111";
  SSDISP(0) <= score1glyph when showScore(p1, enemy1)
          else enemy1glyph when enemy1.column = 0 and enemy1.alive = '1'
          else "11111111";

end architecture display_arch;
