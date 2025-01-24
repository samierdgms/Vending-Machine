library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ChocolateMachine is
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
end ChocolateMachine;

architecture Behavioral of ChocolateMachine is
    type State_Type is (IDLE, A_SELECTED, B_SELECTED, C_SELECTED);
    signal state : State_Type := IDLE;
    signal coin_count : integer := 0;

begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            state <= IDLE;
            coin_count <= 0;
        elsif rising_edge(CLK) then
            case state is
                when IDLE =>
                    FA <= '1';
                    FB <= '1';
                    FC <= '1';
                    AO <= '0';
                    BO <= '0';

                    if COIN = '1' then
                        coin_count <= coin_count + 1;
                        state <= A_SELECTED;
                    end if;

                when A_SELECTED =>
                    FA <= '0';
                    AO <= '1';
                    if BUTTON_S = '1' then
                        state <= IDLE;
                        coin_count <= 0; -- Çikolata verildi, başa dön
                    elsif COIN = '1' then
                        coin_count <= coin_count + 1;
                        state <= B_SELECTED;
                    end if;

                when B_SELECTED =>
                    FB <= '0';
                    AO <= '0';
                    BO <= '1';
                    if BUTTON_S = '1' then
                        state <= IDLE;
                        coin_count <= 0; -- Çikolata verildi, başa dön
                    elsif COIN = '1' then
                        coin_count <= coin_count + 1;
                        state <= C_SELECTED;
                    end if;

                when C_SELECTED =>
                    FC <= '0';
                    AO <= '0';
                    BO <= '0';
                    if COIN = '1' then
                        state <= IDLE;
                        coin_count <= 0; -- Çikolata otomatik verildi, başa dön
                    end if;

                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;
