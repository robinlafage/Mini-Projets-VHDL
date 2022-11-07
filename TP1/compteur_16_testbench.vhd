LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity test_compteur_16 is
end test_compteur_16;


architecture test_compteur of test_compteur_16 is
  --inputs
  signal clk_tb : STD_LOGIC := '0';
  signal rst_tb : STD_LOGIC := '0';
  signal enable_tb : STD_LOGIC := '0';

  --outputs
  signal  deb_tb : STD_LOGIC := '0';
  signal out_count_tb : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
  signal out_count_i_tb : STD_LOGIC := '0';

begin

  tst: entity work.compteur_16(compteur)
    portmap (clk => clk_tb, rst => rst_tb, enable => enable_tb, deb => deb_tb, out_count => out_count_tb, out_count_i => out_count_i_tb);
  
  clk_tb <= not clk_tb after 5 ms;
  
  tst_process: process
  begin
    rst_tb <= '0';
    enable_tb <= '1';
    wait for 20 ms;
  
    rst_tb <= '0';
    enable_tb <= '0';
    wait for 30 ms;

    rst_tb <= '1';
    enable_tb <= '1';
    wait for 20 ms;

    rst_tb <= '1';
    enable_tb <= '0';
    wait for 30 ms;
  end process;  
end test_compteur;