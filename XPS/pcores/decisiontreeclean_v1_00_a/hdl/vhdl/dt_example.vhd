library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;



use work.DT_EXAMPLE_PACK.all;


entity DT_EXAMPLE is
	port(
		clk				: in	std_logic;
		rst				: in	std_logic;
		
		-- Inputs from prior stage of DT
		d_attributes	: in	T_ATTRIBUTES(3 downto 0);
		d_addr			: in	std_logic_vector(3 downto 0);
		d_level			: in	std_logic_vector(1 downto 0);
		
		-- Coefficient RAM programming interface
		ram_access		: in	std_logic; -- this is for MB to access
		ram_din			: in	std_logic_vector(19 downto 0); -- rules are written here
		ram_addr			: in	std_logic_vector(3 downto 0);
		ram_we			: in	std_logic;
		ram_dout			: out	std_logic_vector(19 downto 0); -- why do we need this, check
		
		-- Outputs to next stage
		q_attributes	: out	T_ATTRIBUTES(3 downto 0);
		q_addr			: out	std_logic_vector(3 downto 0);
		q_level			: out	std_logic_vector(1 downto 0)
	);		
end DT_EXAMPLE;


architecture RTL of DT_EXAMPLE is
 
	component LUK_UP1
		port (
			a		: in std_logic_vector(3 downto 0);
			d		: in std_logic_vector(19 downto 0);
			clk	: in std_logic;
			we		: in std_logic;
         qspo_ce :  in std_logic;
			qspo	: out std_logic_vector(19 downto 0)
		);
	end component;
   
   signal reg_attributes   : T_ATTRIBUTES(3 downto 0);
   signal reg_addr         : std_logic_vector(3 downto 0)  :=(others => '0');
   signal reg_level        : std_logic_vector(1 downto 0);
   signal coef_addr        : std_logic_vector(3 downto 0);
   signal coef_data        : std_logic_vector(19 downto 0);
   signal coefficient      : std_logic_vector(7 downto 0);
   signal attr_index       : std_logic_vector(1 downto 0);
   signal operation        : std_logic_vector(1 downto 0);
   signal true_addr        : std_logic_vector(3 downto 0);
   signal false_addr       : std_logic_vector(3 downto 0);
   signal selected_attr    : std_logic_vector(7 downto 0);

begin

   -- Line up input data with data from memory
  
   IN_REG : process(clk)
   begin
      if rising_edge(clk) then
         if (rst = '1') then
            reg_attributes <= (others => (others => '0'));
            reg_addr       <= (others => '0');
            reg_level      <= "10";        
         else
            reg_attributes <= d_attributes;
            reg_addr       <= d_addr;
            reg_level      <= d_level;                
         end if;
      end if;
   end process;
   
   -- Instantiate the Coefficient Memory
   
	COEF_MEM : LUK_UP1
   port map(
      a		=> coef_addr,
      d		=> ram_din,
      clk	=> clk,
      we		=> ram_we,
      qspo_ce  => '1',
      qspo	=> coef_data
   );

   coef_addr   <= ram_addr when ram_access = '1' else d_addr; -- it might access the Microblaze or FPGA.
   ram_dout    <= coef_data; 
   
   -- Map Coefficient RAM output to functional signals
   
   coefficient <= coef_data(7 downto 0);
   attr_index  <= coef_data(9 downto 8);
   operation   <= coef_data(11 downto 10);
   true_addr   <= coef_data(15 downto 12);
   false_addr  <= coef_data(19 downto 16);
   
   
   -- done bit is missing here
   
   -- Select attribute
   
   selected_attr <= reg_attributes(conv_integer(unsigned(attr_index)));
   
   -- Logic to make decision
   
   DT_BLOCK : process(clk)
   begin
      if rising_edge(clk) then
         if (rst = '1') then
            q_attributes	<= (others => (others => '0'));
            q_addr			<= (others => '0');
            q_level			<= "00";
         else
            -- Calculate decision (address) based on parameters
            case operation is
               when "00" =>
                  if (unsigned(selected_attr) <= unsigned(coefficient)) then
                     q_addr <= true_addr;
                  else
                     q_addr <= false_addr;
                  end if;
               when "01" =>
                  if (unsigned(selected_attr) > unsigned(coefficient)) then
                     q_addr <= true_addr;
                  else
                     q_addr <= false_addr;
                  end if;
               when others =>
                  q_addr <= reg_addr;
            end case;
            -- Pipeline attributes and level for next block
            q_attributes <= reg_attributes;
            q_level <= unsigned(reg_level) + 1;
         end if;
      end if;
   end process;
 --  ram_dout <=

end RTL;

