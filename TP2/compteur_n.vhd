LIBRARY IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_N is
  Generic (
  C_NB_BIT_COUNTER : integer;
  C_MODULO : integer
  );
  Port ( clk : in STD_LOGIC;
  rst : in STD_LOGIC;
  enable : in STD_LOGIC;
  max : out STD_LOGIC;
  out_count : out STD_LOGIC_VECTOR (C_NB_BIT_COUNTER - 1 downto 0)
  );
  end compteur_N;


architecture compteur of compteur_N is

  signal out_count_i : unsigned(C_NB_BIT_COUNTER-1 downto 0) := (others => '0');

begin

  out_count <= std_logic_vector(out_count_i);

  sync : process(clk)
  begin
    if clk'event and clk = '1' then
        if rst = '1' then
            out_count_i <= (others => '0');
        elsif enable = '1' then
            if out_count_i = C_MODULO-1 then -- max
                out_count_i <= (others => '0');
            else
                out_count_i <= out_count_i + 1;
            end if ;
        end if;    
    end if;
  end process;
end compteur;