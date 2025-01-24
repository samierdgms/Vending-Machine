library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ChocolateMachine is
end tb_ChocolateMachine;

architecture Behavioral of tb_ChocolateMachine is

    -- Component Declaration for the Unit Under Test (UUT)
    component ChocolateMachine
        Port (
            CLK      : in  STD_LOGIC; -- Saat sinyali
            RESET    : in  STD_LOGIC; -- Sıfırlama sinyali
            COIN     : in  STD_LOGIC; -- Jeton giriş sinyali
            BUTTON_S : in  STD_LOGIC; -- Çikolata seçme düğmesi
            FA       : out STD_LOGIC; -- Çikolata A durumu
            FB       : out STD_LOGIC; -- Çikolata B durumu
            FC       : out STD_LOGIC; -- Çikolata C durumu
            AO       : out STD_LOGIC; -- Çikolata A seçilebilir sinyali
            BO       : out STD_LOGIC  -- Çikolata B seçilebilir sinyali
        );
    end component;

    -- Signals for connecting to the UUT
    signal CLK      : STD_LOGIC := '0';
    signal RESET    : STD_LOGIC := '0';
    signal COIN     : STD_LOGIC := '0';
    signal BUTTON_S : STD_LOGIC := '0';
    signal FA       : STD_LOGIC;
    signal FB       : STD_LOGIC;
    signal FC       : STD_LOGIC;
    signal AO       : STD_LOGIC;
    signal BO       : STD_LOGIC;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ChocolateMachine
        Port map (
            CLK => CLK,
            RESET => RESET,
            COIN => COIN,
            BUTTON_S => BUTTON_S,
            FA => FA,
            FB => FB,
            FC => FC,
            AO => AO,
            BO => BO
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset the machine
        RESET <= '1';
        wait for clk_period;
        RESET <= '0';
        wait for clk_period;

        -- Test Case 1: Insert one coin and select A
        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        BUTTON_S <= '1';  -- Select chocolate A
        wait for clk_period;
        BUTTON_S <= '0';
        wait for clk_period;

        -- Test Case 2: Insert two coins and select B
        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        BUTTON_S <= '1';  -- Select chocolate B
        wait for clk_period;
        BUTTON_S <= '0';
        wait for clk_period;

        -- Test Case 3: Insert three coins and select C
        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        COIN <= '1';
        wait for clk_period;
        COIN <= '0';
        wait for clk_period;

        BUTTON_S <= '1';  -- Select chocolate C
        wait for clk_period;
        BUTTON_S <= '0';
        wait for clk_period;

        -- End of simulation
        wait;
    end process;

end Behavioral;