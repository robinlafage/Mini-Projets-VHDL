library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chronometer is
    port(
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        start : in STD_LOGIC;
        seconds : out STD_LOGIC_VECTOR (7 downto 0);
        minutes : out STD_LOGIC_VECTOR (7 downto 0)
    );
end chronometer;

architecture Behavioral of chronometer is
    --define 2 unsused signals, the out of the clock counter, and the max of the minutes :
    signal out_count_clk : STD_LOGIC_VECTOR (25 downto 0);
    signal max_minutes : STD_LOGIC;

    --define the 3 internal signals : 
    signal max_clk, max_seconds, start_minutes : STD_LOGIC := '0';
    
    begin
        --define the clock counter :
        compteur_clk : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 26,
                C_MODULO => 50000000
            )
            port map(
                clk => clk,
                rst => rst,
                enable => start,
                max => max_clk,
                out_count => out_count_clk
            );
        --define the seconds counter :
        compteur_seconds : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 8,
                C_MODULO => 60 
            )
            port map(
                clk => clk,
                rst => rst,
                enable => max_clk,
                max => max_seconds,
                out_count => seconds
            );
        --define the minutes counter :
        compteur_minutes : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 8,
                C_MODULO => 60 
            )
            port map(
                clk => clk,
                rst => rst,
                enable => start_minutes,
                max => max_minutes,
                out_count => minutes
            );
        --when the max of the seconds and the max of the clock are 1, the max of the minutes is 1 :
        start_minutes <= max_seconds and max_clk;
end Behavioral;