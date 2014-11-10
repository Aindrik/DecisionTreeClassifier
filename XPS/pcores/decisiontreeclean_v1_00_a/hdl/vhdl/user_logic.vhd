------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2010 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Sun Apr 15 17:08:55 2012 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

use work.dt_example_pack.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_SLV_AWIDTH                 -- Slave interface address bus width
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--   C_NUM_REG                    -- Number of software accessible registers
--   C_NUM_MEM                    -- Number of memory spaces
--   C_NUM_INTR                   -- Number of interrupt event
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Reset                 -- Bus to IP reset
--   Bus2IP_Addr                  -- Bus to IP address bus
--   Bus2IP_CS                    -- Bus to IP chip select for user logic memory selection
--   Bus2IP_RNW                   -- Bus to IP read/not write
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
--   IP2Bus_IntrEvent             -- IP to Bus interrupt event
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_SLV_AWIDTH                   : integer              := 32;
    C_SLV_DWIDTH                   : integer              := 32;
    C_NUM_REG                      : integer              := 8;
    C_NUM_MEM                      : integer              := 3;
    C_NUM_INTR                     : integer              := 1
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    user_clk2x                     : in  std_logic;
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Reset                   : in  std_logic;
    Bus2IP_Addr                    : in  std_logic_vector(0 to C_SLV_AWIDTH-1);
    Bus2IP_CS                      : in  std_logic_vector(0 to C_NUM_MEM-1);
    Bus2IP_RNW                     : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(0 to C_SLV_DWIDTH-1);
    Bus2IP_BE                      : in  std_logic_vector(0 to C_SLV_DWIDTH/8-1);
    Bus2IP_RdCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    Bus2IP_WrCE                    : in  std_logic_vector(0 to C_NUM_REG-1);
    IP2Bus_Data                    : out std_logic_vector(0 to C_SLV_DWIDTH-1);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic;
    IP2Bus_IntrEvent               : out std_logic_vector(0 to C_NUM_INTR-1)
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute SIGIS : string;
  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Reset  : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
component DPRAM_INPUT
    port (
      clka  : in std_logic;
      wea   : in std_logic_vector(0 downto 0);
      addra : in std_logic_vector(6 downto 0);
      dina  : in std_logic_vector(31 downto 0);
      douta : out std_logic_vector(31 downto 0);
      clkb  : in std_logic;
      web   : in std_logic_vector(0 downto 0);
      addrb : in std_logic_vector(6 downto 0);
      dinb  : in std_logic_vector(31 downto 0);
      doutb : out std_logic_vector(31 downto 0)
    );
  end component;
  
  attribute syn_black_box : boolean;
  attribute syn_black_box of dpram_input: component is true;
  
  component DPRAM_OUTPUT
    port (
      clka: in std_logic;
      wea: in std_logic_vector(0 downto 0);
      addra: in std_logic_vector(6 downto 0);
      dina: in std_logic_vector(31 downto 0);
      clkb: in std_logic;
      addrb: in std_logic_vector(6 downto 0);
      doutb: out std_logic_vector(31 downto 0));
  end component;
  
   COMPONENT dt_4stage
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         d_attributes : IN  T_ATTRIBUTES(3 downto 0);
         ram_access : IN  std_logic;
         ram_din : IN  std_logic_vector(19 downto 0);
         ram_addr : IN  std_logic_vector(3 downto 0);
         ram_we : IN  std_logic_vector(3 downto 0);
         ram_dout : OUT  T_DTRAM_DOUT(3 downto 0);
         results : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
  
  attribute syn_black_box of dpram_output: component is true;
  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg1                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg2                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg3                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg4                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg4_dummy_value   :  std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg5                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg6                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg7                       : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_reg_write_sel              : std_logic_vector(0 to 7);
  signal slv_reg_read_sel               : std_logic_vector(0 to 7);
  signal slv_ip2bus_data                : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;

  
  -- Signals for user logic memory space example
  ------------------------------------------
  --type BYTE_RAM_TYPE is array (0 to 255) of std_logic_vector(0 to 7);
  --type DO_TYPE is array (0 to C_NUM_MEM-1) of std_logic_vector(0 to C_SLV_DWIDTH-1);
  --signal mem_data_out                   : DO_TYPE;
  --signal mem_address                    : std_logic_vector(0 to 7);
  --signal mem_select                     : std_logic_vector(0 to 2);
  --signal mem_read_enable                : std_logic;
  --signal mem_read_enable_dly1           : std_logic;
  --signal mem_read_req                   : std_logic;
  --signal mem_ip2bus_data                : std_logic_vector(0 to C_SLV_DWIDTH-1);
  --signal mem_read_ack_dly1              : std_logic;
  --signal mem_read_ack                   : std_logic;
  --signal mem_write_ack                  : std_logic;


  --type SAMPLE_TYPE is array (0 to 7) of std_logic_vector(0 to 9);
  --To select the out data from any of the 3 memories 
  -- or
  --To select the output  from one of the inram memories
  
  type DO_TYPE is array (natural range <>) of std_logic_vector(0 to C_SLV_DWIDTH-1);
  --For the write enable of one of the 8 inram memories by microblaze
  type WRITE_TYPE is array (0 to 7) of std_logic_vector(0 downto 0); 
  
  --Since we are controlling with the clock cycles and we know after 8 clock cycles the data will be 
  --ready the T-results is 7 bits because input ram's depth is 128, and we need 7 bits to represent this-- wrong
  --xyz_in_addr_shreg is 7 bits long to create a 8 cycle delay
  type T_RESULTS is array (natural range <>) of std_logic_vector(6 downto 0); --m
  signal xyz_in_addr_shreg : T_RESULTS(6 downto 0) := (others => (others => '0')); --m
  signal mem_data_out                   : DO_TYPE(0 to 2);
  signal mem_select                     : std_logic_vector(0 to 2);
  signal mem_read_enable                : std_logic;
  signal mem_read_enable_dly1           : std_logic;
  signal mem_read_req                   : std_logic;
  signal mem_ip2bus_data                : std_logic_vector(0 to C_SLV_DWIDTH-1);
  signal mem_read_ack_dly1              : std_logic;
  signal mem_read_ack                   : std_logic;
  signal mem_write_ack                  : std_logic;
  signal write_enable                   : WRITE_TYPE;
  signal inram_select                   : std_logic_vector(0 to 7);
  signal inram_data_out                 : DO_TYPE(0 to 7);
  
    -- Added signals for dtree_peripheral functionality
    
  -- For the input Ram We and Din, as FPGA will only read from them.
  constant C_ZEROS                      : std_logic_vector(0 to 31) := (others => '0');
  constant C_ZERO_WE                    : std_logic_vector(0 downto 0) := "0";
  
  --For the timer to calculate the cycles
  signal xyz_cntr_en                    : std_logic;
  signal xyz_cntr                       : std_logic_vector(0 to 31);
  signal xyz_sample                     : DO_TYPE(0 to 7);
 -- signal x_sample                       : SAMPLE_TYPE;
 -- signal y_sample                       : SAMPLE_TYPE;
 -- signal z_sample                       : SAMPLE_TYPE;
  --signal xyz_result                     : std_logic_vector(7 downto 0);
  signal xyz_result                     : std_logic_vector(31 downto 0);
  signal write_xyz_result               : std_logic_vector(0 downto 0);
  
  type T_STATE is (IDLE, PROCESSING, DONE);
  signal xyz_state                      : T_STATE;
  signal process_samples                : std_logic;
 -- signal process_samples_shreg         :   std_logic_vector(5 downto 0);
  signal process_samples_shreg         :   std_logic_vector(6 downto 0);
  signal xyz_in_addr                    : std_logic_vector(0 to 6);
  --signal xyz_in_addr_q                  : std_logic_vector(0 to 6);
  --signal xyz_in_addr_qq                 : std_logic_vector(0 to 6);
  signal xyz_out_addr                   : std_logic_vector(0 to 6);
  signal process_samples_q              : std_logic;
  signal interrupt_pulse                : std_logic;
  signal interrupt_pulse_q              : std_logic;
  signal interrupt_stretched            : std_logic;
  signal num_loops                      : std_logic_vector(0 to 6);
  
  signal coef_ram_sel                   : std_logic_vector(31 downto 0);
  signal coef_ram_dout                  : T_DTRAM_DOUT(31 downto 0);
  
  signal pseudo_intr							 : std_logic ;
  
  
begin


  --USER logic implementation added here

  ------------------------------------------
  -- Code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(0 to 7);
  slv_reg_read_sel  <= Bus2IP_RdCE(0 to 7);
  slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3) or Bus2IP_WrCE(4) or Bus2IP_WrCE(5) or Bus2IP_WrCE(6) or Bus2IP_WrCE(7);
  slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3) or Bus2IP_RdCE(4) or Bus2IP_RdCE(5) or Bus2IP_RdCE(6) or Bus2IP_RdCE(7);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Reset = '1' then
        slv_reg0 <= (others => '0');
        slv_reg1 <= (others => '0');
        slv_reg2 <= (others => '0');
        slv_reg3 <= (others => '0');
        slv_reg4 <= (others => '0');
        slv_reg5 <= (others => '0');
        slv_reg6 <= (others => '0');
        slv_reg7 <= (others => '0');
      else
        case slv_reg_write_sel is
          when "10000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "01000000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg1(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00100000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg2(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00010000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg3(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00001000" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg4(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;

          when "00000100" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg5(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000010" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg6(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when "00000001" =>
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg7(byte_index*8 to byte_index*8+7) <= Bus2IP_Data(byte_index*8 to byte_index*8+7);
              end if;
            end loop;
          when others => null;
        end case;
        -- Add self clear to "GO" bit
        if (slv_reg0(31) = '1') then
          slv_reg0(31) <= '0';   
        end if;
        
        --
        slv_reg4_dummy_value <= X"0000000D";
        -- Add self clear to xyz_timer reset bit
        if (slv_reg0(0) = '1') then
          slv_reg0(0) <= '0';
        end if;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4_dummy_value, pseudo_intr, slv_reg6, xyz_cntr ) is
  begin

    case slv_reg_read_sel is
      when "10000000" => slv_ip2bus_data <= slv_reg0;
      when "01000000" => slv_ip2bus_data <= slv_reg1;
      when "00100000" => slv_ip2bus_data <= slv_reg2;
      when "00010000" => slv_ip2bus_data <= slv_reg3;
      when "00001000" => slv_ip2bus_data <= slv_reg4_dummy_value;
      when "00000100" => slv_ip2bus_data <= pseudo_intr & "0000000000000000000000000000000";
      when "00000010" => slv_ip2bus_data <= slv_reg6;
      when "00000001" => slv_ip2bus_data <= xyz_cntr; -- number of cycles
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;
  
  -- Add a hardware timer to time the number of clock cycles required to perform xyz processing
  
  XYZ_TIMER : process(Bus2IP_Clk)
  begin
    if rising_edge(Bus2IP_Clk) then
    --  if (Bus2IP_Reset = '1' or slv_reg0(0) = '1') then
     if (Bus2IP_Reset = '1') then
        xyz_cntr <= (others => '0');
      else
        if (xyz_cntr_en = '1') then
          xyz_cntr <= unsigned(xyz_cntr) + 1;
          --xyz_cntr <=  x"deadbeef";
        end if;
      end if;
    end if;
  end process;
  

  ------------------------------------------
  -- Code to access user logic memory region from PLB bus
  -- 
  -- Note:
  -- The Bus2IP_Addr, Bus2IP_CS,
  -- and Bus2IP_RNW IPIC signals are dedicated to these user logic
  -- memory spaces. Each user logic memory space has its own address
  -- range and is allocated one bit on the Bus2IP_CS signal to indicated
  -- selection of that memory space. 
  ------------------------------------------
  mem_select      <= Bus2IP_CS;
  mem_read_enable <= ( Bus2IP_CS(0) or Bus2IP_CS(1) or Bus2IP_CS(2) ) and Bus2IP_RNW;
  mem_read_ack    <= mem_read_ack_dly1;
  mem_write_ack   <= ( Bus2IP_CS(0) or Bus2IP_CS(1) or Bus2IP_CS(2)) and not(Bus2IP_RNW);
  
  with Bus2IP_Addr(27 to 29) select inram_select <= 
    x"80" when "000",
    x"40" when "001",
    x"20" when "010",
    x"10" when "011",
    x"08" when "100",
    x"04" when "101",
    x"02" when "110",
    x"01" when "111",
    x"00" when others;

  -- implement single clock wide read request
  mem_read_req    <= mem_read_enable and not(mem_read_enable_dly1);
  BRAM_RD_REQ_PROC : process( Bus2IP_Clk ) is
  begin
    if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
      if ( Bus2IP_Reset = '1' ) then
        mem_read_enable_dly1 <= '0';
      else
        mem_read_enable_dly1 <= mem_read_enable;
      end if;
    end if;
  end process BRAM_RD_REQ_PROC;

  -- this process generates the read acknowledge 1 clock after read enable
  -- is presented to the BRAM block. The BRAM block has a 1 clock delay
  -- from read enable to data out.
  BRAM_RD_ACK_PROC : process( Bus2IP_Clk ) is
  begin
    if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
      if ( Bus2IP_Reset = '1' ) then
        mem_read_ack_dly1 <= '0';
      else
        mem_read_ack_dly1 <= mem_read_req;
      end if;
    end if;
  end process BRAM_RD_ACK_PROC;
  
  -- implement INRAM read mux
  INRAM_READ_MUX : process(inram_select, inram_data_out)
  begin
    case inram_select is
      when x"80" => mem_data_out(0) <= inram_data_out(0); -- 2^7 = 128
      when x"40" => mem_data_out(0) <= inram_data_out(1); -- 2^6 = 64
      when x"20" => mem_data_out(0) <= inram_data_out(2); -- 2^5 = 32
      when x"10" => mem_data_out(0) <= inram_data_out(3); -- 2^4 = 16
      when x"08" => mem_data_out(0) <= inram_data_out(4); -- 2^3 = 8
      when x"04" => mem_data_out(0) <= inram_data_out(5); -- 2^2 = 4
      when x"02" => mem_data_out(0) <= inram_data_out(6); -- 2^1 = 2
      when x"01" => mem_data_out(0) <= inram_data_out(7); -- 2^0 = 1
      when others => mem_data_out(0) <= (others => '0'); 
    end case;
  end process;

  -- implement Block RAM read mux
  MEM_IP2BUS_DATA_PROC : process( mem_data_out, mem_select ) is
  begin
    case mem_select is
      when "100" => mem_ip2bus_data <= mem_data_out(0);
      when "010" => mem_ip2bus_data <= mem_data_out(1);
      when "001" => mem_ip2bus_data <= mem_data_out(2);
      when others => mem_ip2bus_data <= (others => '0');
    end case;
  end process MEM_IP2BUS_DATA_PROC;
 
  -- generate the eight 128x32 RAMs that compose the 1K x 32 INRAM

  INRAM_GENERATE : for i in 0 to 7 generate
  
    write_enable(i)(0) <= not(Bus2IP_RNW) and Bus2IP_CS(0) and inram_select(i);
    
    INRAM : DPRAM_INPUT
    port map(
      clka  => Bus2IP_Clk,
      wea   => write_enable(i),
      addra => Bus2IP_Addr(20 to 26), -- 26 is 2^5 that is every 32 bits are jumped with the next incremented address. Now 7 bit address /20-26/ is required for 128 rows
      dina  => Bus2IP_Data,
      douta => inram_data_out(i),
      clkb  => user_clk2x,
      web   => C_ZERO_WE,
      addrb => xyz_in_addr,
      dinb  => C_ZEROS,
      doutb => xyz_sample(i)
    );
  end generate;
   
  OUTRAM : DPRAM_OUTPUT
    port map(
      clka      => user_clk2x,
      wea       => write_xyz_result,
      addra     => xyz_out_addr,
      dina      => xyz_result,
      clkb      => Bus2IP_Clk,
      addrb     => Bus2IP_Addr(23 to 29),
      doutb     => mem_data_out(1)
    );


  ------------------------------------------
  -- Code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  mem_ip2bus_data when mem_read_ack = '1' else
                  (others => '0');

  IP2Bus_WrAck <= slv_write_ack or mem_write_ack;
  IP2Bus_RdAck <= slv_read_ack or mem_read_ack;
  IP2Bus_Error <= '0';
  
  -------------------------------------
  -- Code for xyz sample calculation
  -------------------------------------
  
--  -- XYZ calculation engine x8
--
--  XYZ_GEN : for i in 0 to 7 generate
--    
--    XYZ_PROCESSING : process(user_clk2x)
--      variable xyz_addition : std_logic_vector(0 to 9);
--    begin
--      if rising_edge(user_clk2x) then
--        if (Bus2IP_Reset = '1') then
--          xyz_result(i)   <= '0';
--          x_sample(i)     <= (others => '0');
--          y_sample(i)     <= (others => '0');
--          z_sample(i)     <= (others => '0');
--        else
--          if (process_samples = '1') then
--            x_sample(i) <= "00" & xyz_sample(i)(8 to 15);
--            y_sample(i) <= "00" & xyz_sample(i)(16 to 23);
--            z_sample(i) <= "00" & xyz_sample(i)(24 to 31);
--          end if;
--          xyz_addition := unsigned(x_sample(i)) + unsigned(y_sample(i)) + unsigned(z_sample(i));
--          xyz_result(i) <= '0';
--          if (conv_integer(unsigned(xyz_addition)) > 384) then
--            xyz_result(i) <= '1';
--          end if;
--        end if;
--      end if;
--    end process;
--    
--  end generate;

    COEF_RAM_SELECT : process(Bus2IP_Addr(21 to 25))
    begin
      coef_ram_sel <= (others => '0');
      coef_ram_sel(conv_integer(Bus2IP_Addr(21 to 25))) <= '1';
    end process;
	 
      
   
	XYZ_GEN : for i in 0 to 7 generate
      signal d_attributes : T_ATTRIBUTES(3 downto 0);
      signal coef_ram_we : std_logic_vector(31 downto 0);
   begin
   
      coef_ram_we(i*4+3 downto i*4) <= coef_ram_sel(i*4+3 downto i*4) when Bus2IP_RNW = '0' and Bus2IP_CS(2) = '1'
         else (others => '0');
   
      -- LITTLE_ENDIAN <= BIG_ENDIAN;
   
      d_attributes(3) <= xyz_sample(i)(0 to 7);
      d_attributes(2) <= xyz_sample(i)(8 to 15);
      d_attributes(1) <= xyz_sample(i)(16 to 23);
      d_attributes(0) <= xyz_sample(i)(24 to 31);
   
      XYZ_PROCESSING : dt_4stage
         port map(
            clk				=> user_clk2x,
            rst				=> Bus2IP_Reset,
            -- Inputs from prior stage of DT
            d_attributes	=> d_attributes,
            -- Coefficient RAM programming interface
            ram_access		=> slv_reg2(31), -- enable bit from MB.
            ram_din			=> Bus2IP_Data(12 to 31),
            ram_addr			=> Bus2IP_Addr(26 to 29),
            ram_we			=> coef_ram_we(i*4+3 downto i*4),
            ram_dout			=> coef_ram_dout(i*4+3 downto i*4),
            -- Outputs to next stage
            results			=> xyz_result(i*4+3 downto i*4)
         );
         
   end generate;
	
   
  -- implement INRAM read mux
  COEF_RAM_READ_MUX : process(coef_ram_sel, coef_ram_dout)
  begin
    mem_data_out(2)(0 to 11) <="000000000000" ;
    case coef_ram_sel is
      when x"00000001" => mem_data_out(2)(12 to 31) <= coef_ram_dout(0);
      when x"00000002" => mem_data_out(2)(12 to 31) <= coef_ram_dout(1);
      when x"00000004" => mem_data_out(2)(12 to 31) <= coef_ram_dout(2);
      when x"00000008" => mem_data_out(2)(12 to 31) <= coef_ram_dout(3);
      when x"00000010" => mem_data_out(2)(12 to 31) <= coef_ram_dout(4);
      when x"00000020" => mem_data_out(2)(12 to 31) <= coef_ram_dout(5);
      when x"00000040" => mem_data_out(2)(12 to 31) <= coef_ram_dout(6);
      when x"00000080" => mem_data_out(2)(12 to 31) <= coef_ram_dout(7);
      
      when x"00000100" => mem_data_out(2)(12 to 31) <= coef_ram_dout(8);
      when x"00000200" => mem_data_out(2)(12 to 31) <= coef_ram_dout(9);
      when x"00000400" => mem_data_out(2)(12 to 31) <= coef_ram_dout(10);
      when x"00000800" => mem_data_out(2)(12 to 31) <= coef_ram_dout(11);
      when x"00001000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(12);
      when x"00002000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(13);
      when x"00004000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(14);
      when x"00008000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(15);

      when x"00010000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(16);
      when x"00020000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(17);
      when x"00040000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(18);
      when x"00080000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(19);
      when x"00100000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(20);
      when x"00200000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(21);
      when x"00400000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(22);
      when x"00800000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(23);

      when x"01000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(24);
      when x"02000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(25);
      when x"04000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(26);
      when x"08000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(27);
      when x"10000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(28);
      when x"20000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(29);
      when x"40000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(30);
      when x"80000000" => mem_data_out(2)(12 to 31) <= coef_ram_dout(31);
      
      when others => mem_data_out(2) <= (others => '0');
    end case;
  end process;

   

  -- XYZ controller
  
  XYZ_CTRL : process(user_clk2x)
  begin
    if rising_edge(user_clk2x) then
      if (Bus2IP_Reset = '1') then
        xyz_state <= IDLE;
        process_samples <= '0';
        xyz_cntr_en <= '0';
        xyz_in_addr <= (others => '0');
        -- xyz_in_addr_q <= (others => '0');
        --xyz_in_addr_qq <= (others => '0');
        xyz_out_addr <= (others => '0');
        process_samples_q <= '0';
        write_xyz_result <= "0";
		  pseudo_intr <=  '0';
        interrupt_pulse <= '0';
        interrupt_pulse_q <= '0';
        interrupt_stretched <= '0';
        num_loops <= (others => '0');
      else
        -- Defaults
        process_samples <= '0';
        xyz_cntr_en <= '0';
        xyz_in_addr <= (others => '0');
        num_loops <= num_loops;
	     interrupt_pulse <= '0';
        xyz_cntr_en <= '0';
        case xyz_state is
          when IDLE =>
            xyz_state <= IDLE;
            if (slv_reg0(31) = '1') then
              xyz_state <= PROCESSING;
              xyz_cntr_en <= '1';
              num_loops <= slv_reg1(25 to 31); -- total rows of (dataset /8) - 1 in micro blaze
            end if;
          when PROCESSING =>
            xyz_state <= PROCESSING;
            process_samples <= '1';
            xyz_cntr_en <= '1';
            xyz_in_addr <= unsigned(xyz_in_addr) + 1;
            if (xyz_in_addr = num_loops) then
              xyz_state <= DONE;
            end if;
          when DONE =>
            xyz_state <= IDLE;
            
				pseudo_intr <= '1';
            interrupt_pulse <= '1';
          when others =>
            xyz_state <= IDLE;
        end case;
        
        --check here
--        xyz_in_addr_q <= xyz_in_addr;
--        xyz_in_addr_qq <= xyz_in_addr_q;
--        xyz_out_addr <= xyz_in_addr_qq;
        
        --check here
--        process_samples_q <= process_samples;
--        write_xyz_result(0) <= process_samples_q;

         
        interrupt_pulse_q <= interrupt_pulse;
        interrupt_stretched <= interrupt_pulse_q or interrupt_pulse;

        xyz_in_addr_shreg <= xyz_in_addr_shreg(5 downto 0) & xyz_in_addr; --  xyz_in_addr_shreg(6) is 4 bits and so on-- its a 2 dimentional array
        xyz_out_addr  <=  xyz_in_addr_shreg(6);
        
--        process_samples_shreg <= process_samples_shreg(4 downto 0) & process_samples;
--        write_xyz_result(0) <= process_samples_shreg(5);
      -- this is the write enable required for the bus
        process_samples_shreg <= process_samples_shreg(5 downto 0) & process_samples;
        write_xyz_result(0) <= process_samples_shreg(6);
        
      end if;
    end if;
  end process;
  
  -- Interrupt generation
  
  INTR_GEN : process(Bus2IP_Clk)
  begin
    if rising_edge(Bus2IP_Clk) then
      if (Bus2IP_Reset = '1') then
        IP2Bus_IntrEvent <= (others => '0');
      else
        IP2Bus_IntrEvent(0) <= interrupt_stretched;
      end if;
    end if;
  end process;
   

end IMP;
