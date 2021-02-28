-- Input Controller
-- Accept input from 2 buttons - top button causes PlayerUp, bottom button causes PlayerDown,
-- both buttons cause GameReset
--
library ieee;
use ieee.std_logic_1164.all;
use work.SillyGamePack.all;

entity inputcontroller is port (
  button0: in std_logic;      -- bottom button
  button1: in std_logic;      -- top button
  PlayerUp: out std_logic;    -- button1 pressed causes signal
  PlayerDown: out std_logic;  -- button0 pressed causes signal
  GameReset: out std_logic    -- both buttons pressed causes signal
);
end entity inputcontroller;

architecture inputcontroller_arch of inputcontroller is
begin
  GameReset <= '1' when button0 = '0' and button1 = '0' else '0'; -- both buttons pressed
  PlayerUp <= '1' when button1 = '0' and button0 = '1' else '0';  -- top button pressed
  PlayerDown <= '1' when button0 = '0' and button1 = '1' else '0';-- bottom button pressed
end architecture inputcontroller_arch;
