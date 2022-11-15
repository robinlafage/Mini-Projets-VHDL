LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_16 is
  Port ( clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    enable : in STD_LOGIC;
    deb : out STD_LOGIC;
    out_count : out STD_LOGIC_VECTOR (3 downto 0)
    );
end compteur_16;


architecture compteur of compteur_16 is

  signal out_count_i : unsigned(3 downto 0) := (others => '0');

begin

  out_count <= std_logic_vector(out_count_i);

  sync : process(clk)
  begin
    if clk'event and clk = '1' then
        if rst = '1' then
            out_count_i <= "0000";
        elsif enable = '1' then
            if out_count_i = "1110" then
                deb <= '1';
                out_count_i <= "1111";
            elsif out_count_i = "1111" then
                deb <= '0';
                out_count_i <= "0000";
            else
                out_count_i <= out_count_i + 1;
                deb <= '0';
            end if ;
        end if;    
    end if;
  end process;
end compteur;