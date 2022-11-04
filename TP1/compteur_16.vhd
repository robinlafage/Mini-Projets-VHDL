LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity compteur_16 is
  Port ( clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    enable : in STD_LOGIC;
    deb : out STD_LOGIC;
    out_count : out STD_LOGIC_VECTOR (3 downto 0)
    );
end compteur_16;


architecture compteur of compteur_16 is

  signal out_count_i : STD_LOGIC := '0';

begin

  out_count <= out_count_i;

  sync : process(clk)
  begin
    if clk'event and clk = '1' and enable = '1' then
      out_count_i <= out_count_i + 1;
      deb <= '0';

      if rst = '1' then
        out_count_i = '0';
      end if;

      if out_count_i = '16' then
        deb = '1';
        out_count_i = '0';
      end if;

    end if;
  end process sync;
end compteur;