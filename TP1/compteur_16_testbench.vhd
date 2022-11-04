LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity test_compteur_16 is
end test_compteur_16;


architecture test_compteur of test_compteur_16 is
  --inputs
  signal clk : STD_LOGIC;
  signal rst : STD_LOGIC;
  signal enable : STD_LOGIC;

  --outputs
  signal  deb : STD_LOGIC;
  signal out_count : STD_LOGIC_VECTOR (3 downto 0);
  signal out_count_i : STD_LOGIC := '0';

begin

  c1: entity work.compteur_16(compteur)
    portmap (clk, rst, enable, deb, out_count, out_count_i);
  
  
    
end test_compteur;