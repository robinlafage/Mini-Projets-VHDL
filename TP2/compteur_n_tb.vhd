library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compteur_N_tb is
end compteur_N_tb;

architecture tb of compteur_N_tb is

signal clk_tb, rst_tb, enable_tb : STD_LOGIC := '0';
signal max_tb : STD_LOGIC;
signal out_count_tb : STD_LOGIC_VECTOR (4 - 1 downto 0); --car on fixe C_NB_BIT_COUNTER=4 en dessous

begin
	compteur_10 : entity work.compteur_N
	generic map(
	C_NB_BIT_COUNTER => 4,
	C_MODULO => 10 --On fixe le N à 10 et donc la longueur du compteur à 4
	)
	port map(
	clk => clk_tb,
	rst => rst_tb,
	enable => enable_tb,
	max => max_tb,
	out_count => out_count_tb
	);

	clk_tb <= not(clk_tb) after 5 ns;
	enable_tb <= '1', '0' after 60ns, '1' after 90ns;
	rst_tb <= '1', '0' after 10 ns, '1' after 80 ns, '0' after 90ns;
end tb;
