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
	--change of state every 10ns, so a clock period of 20ns, and 20ns*50 000 000 = 1s
	clk_tb <= not(clk_tb) after 10ns;
	--stop the chronometer for 5s
	start_tb <= '1', '0' after 100000ms, '1' after 150000ms;
	--reset the chronometer during 5s
	rst_tb <= '0', '1' after 400000ms, '0' after 450000ms;
end tb;
