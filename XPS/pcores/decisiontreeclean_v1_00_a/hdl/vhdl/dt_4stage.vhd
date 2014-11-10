library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.dt_example_pack.all;


entity dt_4stage is
   port(
      clk				: in	std_logic;
      rst				: in	std_logic;
      -- Inputs from prior stage of DT
      d_attributes	: in	T_ATTRIBUTES(3 downto 0);
      -- Coefficient RAM programming interface
      ram_access		: in	std_logic; -- this is for MB to access
      ram_din			: in	std_logic_vector(19 downto 0);
      ram_addr			: in	std_logic_vector(3 downto 0);
      ram_we			: in	std_logic_vector(3 downto 0);
      ram_dout			: out	T_DTRAM_DOUT(3 downto 0); 
      -- Outputs to next stage
      results			: out	std_logic_vector(3 downto 0) -- wire this to the last stage q_addr
   );
end dt_4stage;


architecture Behavioral of dt_4stage is

   component DT_EXAMPLE
      port(
         clk				: in	std_logic;
         rst				: in	std_logic;
         -- Inputs from prior stage of DT
         d_attributes	: in	T_ATTRIBUTES(3 downto 0);
         d_addr			: in	std_logic_vector(3 downto 0);
         d_level			: in	std_logic_vector(1 downto 0);
         -- Coefficient RAM programming interface
         ram_access		: in	std_logic; -- this is for MB to access
         ram_din			: in	std_logic_vector(19 downto 0);
         ram_addr			: in	std_logic_vector(3 downto 0);
         ram_we			: in	std_logic;
         ram_dout			: out	std_logic_vector(19 downto 0); 
         -- Outputs to next stage
         q_attributes	: out	T_ATTRIBUTES(3 downto 0);
         q_addr			: out	std_logic_vector(3 downto 0);-- this is the classification
         q_level			: out	std_logic_vector(1 downto 0)
      );		
   end component;
   signal s1_2_attributes,s2_3_attributes,s3_4_attributes,s4_attributes :T_ATTRIBUTES(3 downto 0);
   signal s1_2_addr ,s2_3_addr, s3_4_addr : std_logic_vector(3 downto 0);
begin


   STAGE_1 : DT_EXAMPLE
   port map(
      clk				=> clk,
      rst				=> rst,
      -- Inputs from prior stage of DT
      d_attributes	=> d_attributes,
      d_addr			=> "0000",
      d_level			=> "00",
      -- Coefficient RAM programming interface
      ram_access		=> ram_access,
      ram_din			=> ram_din, -- rules are written here
      ram_addr			=> ram_addr,
      ram_we			=> ram_we(0),
      ram_dout			=> ram_dout(0),
      -- Outputs to next stage
      q_attributes	=> s1_2_attributes,
      q_addr			=> s1_2_addr,
      q_level			=> open
   );		
   
      STAGE_2 : DT_EXAMPLE
   port map(
      clk				=> clk,
      rst				=> rst,
      -- Inputs from prior stage of DT
      d_attributes	=> s1_2_attributes,
      d_addr			=> s1_2_addr,
      d_level			=> "01",
      -- Coefficient RAM programming interface
      ram_access		=> ram_access,
      ram_din			=> ram_din,
      ram_addr			=> ram_addr,
      ram_we			=> ram_we(1),
      ram_dout			=> ram_dout(1),
      -- Outputs to next stage
      q_attributes	=> s2_3_attributes,
      q_addr			=> s2_3_addr,
      q_level			=> open
   );		

   STAGE_3 : DT_EXAMPLE
   port map(
      clk				=> clk,
      rst				=> rst,
      -- Inputs from prior stage of DT
      d_attributes	=> s2_3_attributes,
      d_addr			=> s2_3_addr,
      d_level			=> "10",
      -- Coefficient RAM programming interface
      ram_access		=> ram_access,
      ram_din			=> ram_din,
      ram_addr			=> ram_addr,
      ram_we			=> ram_we(2),
      ram_dout			=> ram_dout(2),
      -- Outputs to next stage
      q_attributes	=> s3_4_attributes,
      q_addr			=> s3_4_addr,
      q_level			=> open
   );		

   STAGE_4 : DT_EXAMPLE
   port map(
      clk				=> clk,
      rst				=> rst,
      -- Inputs from prior stage of DT
      d_attributes	=> s3_4_attributes,
      d_addr			=> s3_4_addr,
      d_level			=> "11",
      -- Coefficient RAM programming interface
      ram_access		=> ram_access,
      ram_din			=> ram_din,
      ram_addr			=> ram_addr,
      ram_we			=> ram_we(3),
      ram_dout			=> ram_dout(3),
      -- Outputs to next stage
      q_attributes	=> s4_attributes,
      q_addr			=> results,
      q_level			=> open
   );		

end Behavioral;

