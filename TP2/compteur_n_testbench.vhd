LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_compteur_n is
end test_compteur_n;


architecture test_compteur of test_compteur_n is
  --inputs
  signal clk_tb : STD_LOGIC := '0';
  signal rst_tb : STD_LOGIC := '0';
  signal enable_tb : STD_LOGIC := '0';

  --outputs
  signal  deb_tb : STD_LOGIC := '0';
  signal out_count_tb : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

  tst: entity work.compteur_n(compteur)
    port map (clk => clk_tb,
    rst => rst_tb,
    enable => enable_tb,
    deb => deb_tb,
    out_count => out_count_tb);
  
  clk_tb <= not clk_tb after 5 ns;
  
  tst_process: process
  begin
    
    rst_tb <= '0';
    enable_tb <= '1';
    wait for 200 ns;
  
    rst_tb <= '1';
    enable_tb <= '1';
    wait for 20 ns;

    rst_tb <= '0';
    enable_tb <= '1';
    wait for 50 ns;

    rst_tb <= '0';
    enable_tb <= '0';
    wait for 40 ns;
    
    rst_tb <= '0';
    enable_tb <= '1';
    wait for 50 ns;
    
    wait;
  end process;  
end test_compteur;