----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2022 11:14:46 AM
-- Design Name: 
-- Module Name: FIFO_HW - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FIFO_HW is
    Port ( wr_clk : in STD_LOGIC;
           rd_clk : in std_logic;
           din : in std_logic_vector(31 downto 0);
           rd_en : in std_logic;
           wr_en : in std_logic;
           dout_norm : out std_logic_vector(31 downto 0);
           dout_slow : out std_logic_vector(31 downto 0);
           dout_doub : out std_logic_vector(63 downto 0)
    );
    
end FIFO_HW;

architecture Behavioral of FIFO_HW is

component fifo_generator_0
    Port ( wr_clk : in STD_LOGIC;
           rd_clk : in std_logic;
           din : in std_logic_vector(31 downto 0);
           rd_en : in std_logic;
           wr_en : in std_logic;
           --empty : in std_logic;
           dout: out std_logic_vector(31 downto 0);
           rst : in std_logic
    );
end component;     
    
component clk_wiz_0
    Port ( clk_in1 : in std_logic;
           clk_out1 : out std_logic;
           clk_out2 : out std_logic;
           clk_out3 : out std_logic;
           reset : in std_logic
    );
    
end component;

component fifo_generator_1
    Port ( clk : in std_logic;
           din : in std_logic_vector(31 downto 0);
           rd_en : in std_logic;
           wr_en : in std_logic;
           dout: out std_logic_vector(63 downto 0);
           srst : in std_logic
    );
end component;

signal rd_clk_half : std_logic := 'U'; 
signal rd_clk_same : std_logic := 'U';
signal rd_clk_doub : std_logic := 'U';  
signal rd_en_empty : std_logic := 'U';

begin


clk_wiz_inst : clk_wiz_0
    port map(
    clk_in1 => rd_clk,
    clk_out1 => rd_clk_half,
    clk_out2 => rd_clk_same,
    clk_out3 => rd_clk_doub,
    reset => '0'
    );

FIFO_norm : fifo_generator_0
    port map(
    wr_clk => wr_clk,
    rd_clk => rd_clk,
    din  => din,
    rd_en => rd_en,
    wr_en => wr_en,
    dout => dout_norm,
    rst => '0'
    );
    
FIFO_slow : fifo_generator_0
    port map(
    wr_clk => wr_clk,
    rd_clk => rd_clk_half,
    din  => din,
    rd_en => rd_en,
    wr_en => wr_en,
    dout => dout_slow,
    rst => '0'
    );
    
FIFO_doub : fifo_generator_1
    port map(
    clk => rd_clk,
    din  => din,
    rd_en => rd_en,
    wr_en => wr_en,
    dout => dout_doub,
    srst => '0'
    );

end Behavioral;
