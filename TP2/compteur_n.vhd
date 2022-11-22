LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compteur_N is
	Generic (
		C_NB_BIT_COUNTER : integer;
		C_MODULO : integer
	);
	Port ( clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		enable : in STD_LOGIC;
		max : out STD_LOGIC := '0';
		out_count : out STD_LOGIC_VECTOR (C_NB_BIT_COUNTER - 1 downto 0)
	);
end compteur_N;

architecture arch_compteur of compteur_N is
	signal cnt : UNSIGNED (C_NB_BIT_COUNTER - 1 downto 0);      
begin
	p1 : process(clk)
	begin
		if (clk'event and clk = '1') then
			if (rst = '1') then --reset synchrone
				cnt <= (others => '0');
			elsif (enable = '1') then
				if (cnt = C_MODULO-2) then --cas avant d�bordement
					max <= '1';
					cnt <= cnt+1;
				elsif (cnt = C_MODULO-1) then --cas du d�bordement
				    max <= '0';
					cnt <= (others => '0');
				else
					cnt <= cnt+1; --si pas de d�bordement on compte normalement
				end if;
			end if;
		end if;
	end process;
	out_count <= STD_LOGIC_VECTOR(cnt);
end arch_compteur;