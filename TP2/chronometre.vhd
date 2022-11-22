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
    signal out_count_clk : STD_LOGIC_VECTOR (25 downto 0);
    signal max_clk, max_seconds, max_minutes : STD_LOGIC := '0';
begin
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
    
    compteur_seconds : entity work.compteur_n
        generic map(
            C_NB_BIT_COUNTER => 8,
            C_MODULO => 60 
        )
        port map(
            clk => clk,
            rst => rst,
            enable => start,
            max => max_seconds,
            out_count => seconds
        );
        
    compteur_minutes : entity work.compteur_n
        generic map(
            C_NB_BIT_COUNTER => 8,
            C_MODULO => 60 
        )
        port map(
            clk => clk,
            rst => rst,
            enable => start,
            max => max_minutes,
            out_count => minutes
        );

    p_chrono : process(clk)
    begin
        if (clk'event and clk = '1') then
			if (rst = '1') then --reset synchrone
				out_count_clk <= (others => '0');
                minutes <= '0';
                seconds <= '0';
			elsif (start = '1') then
				if (max_clk = 1) then 
					--incrémenter secondes
				elsif (max_seconds = 1) then 
				    --incrémenter minutes
				elsif (max_minutes = 1) then
                    rst <= '1';
                else
					out_count_clk <= out_count_clk+1; --si pas de debordement on compte normalement
				end if;
			end if;
		end if;
	end process;

        
    

end Behavioral;


--signal out_seconds : UNSIGNED (7 downto 0);
--signal out_minutes : UNSIGNED (7 downto 0);
    
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
--                        out_seconds <= out_seconds + 1; --si pas de d�bordement on compte normalement
--                    end if;
--                end if;
--            end if;
--        end process;


-- 26 bits pour coder 50Mhz, 6 bits pour coder 60 secondes, 6 bits pour coder 60 minutes, 3 bits pour coder les 3 max
-- 41 bits donc 41 bascules 
-- Secondes et Minutes sont fixés sur 8 bits dans l'entity, étrange 