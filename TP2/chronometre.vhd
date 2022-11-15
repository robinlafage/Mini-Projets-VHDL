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
    begin
        compteur_clk : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 4,
                C_MODULO => 10 --On fixe le N à 10 et donc la longueur du compteur à 4
            )
            port map(
                clk => clk,
                rst => rst,
                enable => start,
                max => ,
                out_count => out_count_tb
            );
        
        compteur_seconds : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 4,
                C_MODULO => 10 --On fixe le N à 10 et donc la longueur du compteur à 4
            )
            port map(
                clk => clk,
                rst => rst,
                enable => start,
                max => max_tb,
                out_count => out_count_tb
            );
            
        compteur_minutes : entity work.compteur_n
            generic map(
                C_NB_BIT_COUNTER => 4,
                C_MODULO => 10 --On fixe le N à 10 et donc la longueur du compteur à 4
            )
            port map(
                clk => clk,
                rst => rst,
                enable => start,
                max => max_tb,
                out_count => out_count_tb
            );
    

end Behavioral;


signal out_seconds : UNSIGNED (7 downto 0);
    signal out_minutes : UNSIGNED (7 downto 0);
    
--    begin
--        seconds <= STD_LOGIC_VECTOR(out_seconds);
--        minutes <= STD_LOGIC_VECTOR(out_minutes);
        
--        p1 : process(clk)
--        begin
--            if (clk'event and clk = '1') then
--                if (rst = '1') then --reset synchrone
--                    out_seconds <= (others => '0');
--                    out_minutes <= (others => '0');
--                elsif (start = '1') then
--                    if (out_minutes = 59 and out_seconds = 59) then --cas debordement minutes
--                        out_seconds <= (others => '0');
--                        out_minutes <= (others => '0');
--                    elsif (out_seconds = 59) then --cas debordement seconds
--                        out_seconds <= (others => '0');
--                        out_minutes <= out_minutes + 1;
--                    else
--                        out_seconds <= out_seconds + 1; --si pas de débordement on compte normalement
--                    end if;
--                end if;
--            end if;
--        end process;