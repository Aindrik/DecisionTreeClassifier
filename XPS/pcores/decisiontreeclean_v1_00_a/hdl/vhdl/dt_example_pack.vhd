library IEEE;
use IEEE.STD_LOGIC_1164.all;

package DT_EXAMPLE_PACK is

	type T_ATTRIBUTES is array (natural range <>) of std_logic_vector(7 downto 0);
   type T_DTRAM_DOUT is array (natural range <>) of std_logic_vector(19 downto 0);
   type T_RESULTS is array (natural range <>) of std_logic_vector(3 downto 0);

end DT_EXAMPLE_PACK;

