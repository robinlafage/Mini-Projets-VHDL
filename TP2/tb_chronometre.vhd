library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chronometer_tb is
end chronometer_tb;

architecture tb of chronometer_tb is
    signal clk_tb, rst_tb, start_tb : STD_LOGIC := '0';
    signal seconds_tb : STD_LOGIC_VECTOR (7 downto 0);
    signal minutes_tb : STD_LOGIC_VECTOR (7 downto 0);

begin
	chronometer : entity work.chronometer
	port map(
	clk => clk_tb,
	rst => rst_tb,
	start => start_tb,
	minutes => minutes_tb,
	seconds => seconds_tb
	);

	clk_tb <= not(clk_tb) after 5 ns;
	start_tb <= '1', '0' after 200ns, '1' after 250ns;
	rst_tb <= '1', '0' after 10 ns, '1' after 80 ns, '0' after 100ns;
end tb;
