library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity tb_compteur_8_v1 is
end tb_compteur_8_v1;

architecture behavioral of tb_compteur_8_v1 is
	signal clk_tb		: std_logic	:='0';
	signal rst_tb		: std_logic	:='0';
	signal enable_tb	: std_logic	:='0';
	signal out_count_tb	: std_logic_vector(2 downto 0)	:= (others => '0');
begin
	inst : entity work.compteur_8_v1
		port map(
			clk			=> clk_tb,
			rst			=> rst_tb,
			enable		=> enable_tb,
			out_count	=> out_count_tb
		);
	
	clk_tb <= not clk_tb after 5 ns;	-- Periode : 10ns --> Frequence : 100MHz

	stim_proc :	process
	begin
		rst_tb		<= '0';
		enable_tb	<= '0';
		wait for 50 ns;

		rst_tb		<= '1';
		enable_tb	<= '0';
		wait for 20 ns;

		rst_tb		<= '0';
		enable_tb	<= '1';
		wait for 100 ns;

		rst_tb		<= '0';
		enable_tb	<= '0';
		wait for 20 ns;

		rst_tb		<= '0';
		enable_tb	<= '1';
		wait for 100 ns;

		rst_tb		<= '1';
		enable_tb 	<= '1';
		wait for 50 ns;

		rst_tb		<= '0';
		enable_tb 	<= '1';
		wait for 100 ns;

		wait;
    end process;
end behavioral;