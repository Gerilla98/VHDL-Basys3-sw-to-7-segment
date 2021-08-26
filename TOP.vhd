----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.08.2021 20:36:12
-- Design Name: 
-- Module Name: TOP - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
--  Port ( );
  Port ( 
      clk: in std_logic;
       sw: in std_logic_vector(15 downto 0);
       seg: out std_logic_vector(6 downto 0);
       an: out std_logic_vector(3 downto 0)
       
--        ones:       out  std_logic_vector (3 downto 0);
--        tens:       out  std_logic_vector (3 downto 0);
--        hundreds:   out  std_logic_vector (3 downto 0);
--        thousands:  out  std_logic_vector (3 downto 0)
);
end TOP;

architecture Behavioral of TOP is
    signal counter: std_logic_vector(15 downto 0);
    signal counter2: std_logic_vector(1 downto 0);
    signal an_in: std_logic_vector(3 downto 0) ;
    signal i: std_logic_vector(2 downto 0);
    signal i2: std_logic_vector(2 downto 0);
    
    alias Hex_Display_Data: std_logic_vector (15 downto 0) is sw;
--    alias rpm_1:    std_logic_vector (3 downto 0) is ones;
--    alias rpm_10:   std_logic_vector (3 downto 0) is tens;
--    alias rpm_100:  std_logic_vector (3 downto 0) is hundreds;
--    alias rpm_1000: std_logic_vector (3 downto 0) is thousands;
        signal rpm_1: std_logic_vector(3 downto 0) ;
        signal rpm_10: std_logic_vector(3 downto 0) ;
        signal rpm_100: std_logic_vector(3 downto 0) ;
        signal rpm_1000: std_logic_vector(3 downto 0) ;
        
        signal ones: std_logic_vector(6 downto 0) ;
        signal tens: std_logic_vector(6 downto 0) ;
        signal hundreds: std_logic_vector(6 downto 0) ;
        signal thousands: std_logic_vector(6 downto 0) ;
        
        signal nulla:   std_logic_vector(6 downto 0) := "1000000";
        signal one:     std_logic_vector(6 downto 0) := "1111001"; 
        signal two:     std_logic_vector(6 downto 0) := "0100100"; 
        signal three:   std_logic_vector(6 downto 0) := "0110000"; 
        signal four:    std_logic_vector(6 downto 0) := "0011001"; 
        signal five:    std_logic_vector(6 downto 0) := "0010010"; 
        signal six:     std_logic_vector(6 downto 0) := "0000010";
        signal seven:   std_logic_vector(6 downto 0) := "1111000"; 
        signal eight:   std_logic_vector(6 downto 0) := "0000000"; 
        signal nine:    std_logic_vector(6 downto 0) := "0010000"; 
          
                
    
    
    
    
    
    
begin
     
--------------------------------bcd----------------------------------------------
 process (Hex_Display_Data)
        type fourbits is array (3 downto 0) of std_logic_vector(3 downto 0);
        -- variable i : integer := 0;  -- NOT USED
        -- variable bcd : std_logic_vector(15 downto 0) := (others => '0');
        variable bcd:   std_logic_vector (15 downto 0);
        -- variable bint : std_logic_vector(15 downto 0) := Hex_Display_Data;
        variable bint:  std_logic_vector (13 downto 0); -- SEE process body
    begin
        bcd := (others => '0');      -- ADDED for EVERY CONVERSION
        bint := Hex_Display_Data (13 downto 0); -- ADDED for EVERY CONVERSION

        for i in 0 to 13 loop
            bcd(15 downto 1) := bcd(14 downto 0);
            bcd(0) := bint(13);
            bint(13 downto 1) := bint(12 downto 0);
            bint(0) := '0';

            if i < 13 and bcd(3 downto 0) > "0100" then
                bcd(3 downto 0) := 
                    std_logic_vector (unsigned(bcd(3 downto 0)) + 3);
            end if;
            if i < 13 and bcd(7 downto 4) > "0100" then
                bcd(7 downto 4) := 
                    std_logic_vector(unsigned(bcd(7 downto 4)) + 3);
            end if;
            if i < 13 and bcd(11 downto 8) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(11 downto 8)) + 3);
            end if;
            if i < 13 and bcd(15 downto 12) > "0100" then
                bcd(11 downto 8) := 
                    std_logic_vector(unsigned(bcd(15 downto 12)) + 3);
            end if;
        end loop;

        (rpm_1000, rpm_100, rpm_10, rpm_1)  <= 
                  fourbits'( bcd (15 downto 12), bcd (11 downto 8), 
                               bcd ( 7 downto  4), bcd ( 3 downto 0) );
    end process ;


-----------------------------------bcd to seven segment-------------------------------------
bcdtoseg: process(rpm_1, rpm_10, rpm_100, rpm_1000) begin

    case rpm_1 is
      when "0000" =>   ones<=nulla;
      when "0001" =>   ones<=one;
      when "0010" =>   ones<=two;
      when "0011" =>   ones<=three;
      when "0100" =>   ones<=four;
      when "0101" =>   ones<=five;
      when "0110" =>   ones<=six;
      when "0111" =>   ones<=seven;
      when "1000" =>   ones<=eight;
      when others =>   ones<=nine;
end case;

    case rpm_10 is
      when "0000" =>   tens<=nulla;
      when "0001" =>   tens<=one;
      when "0010" =>   tens<=two;
      when "0011" =>   tens<=three;
      when "0100" =>   tens<=four;
      when "0101" =>   tens<=five;
      when "0110" =>   tens<=six;
      when "0111" =>   tens<=seven;
      when "1000" =>   tens<=eight;
      when others =>   tens<=nine;
end case;

    case rpm_100 is
      when "0000" =>   hundreds<=nulla;
      when "0001" =>   hundreds<=one;
      when "0010" =>   hundreds<=two;
      when "0011" =>   hundreds<=three;
      when "0100" =>   hundreds<=four;
      when "0101" =>   hundreds<=five;
      when "0110" =>   hundreds<=six;
      when "0111" =>   hundreds<=seven;
      when "1000" =>   hundreds<=eight;
      when others =>   hundreds<=nine;
end case;

    case rpm_1000 is
      when "0000" =>   thousands<=nulla;
      when "0001" =>   thousands<=one;
      when "0010" =>   thousands<=two;
      when "0011" =>   thousands<=three;
      when "0100" =>   thousands<=four;
      when "0101" =>   thousands<=five;
      when "0110" =>   thousands<=six;
      when "0111" =>   thousands<=seven;
      when "1000" =>   thousands<=eight;
      when others =>   thousands<=nine;
end case;

end process;






    
    display: process(i) begin
                
        if i="000" then
            an<= "1110";
            --seg<="1111001";
            seg<=ones;
        elsif i="001" then
            an<= "1101";
            --seg<="0100100";
            seg<=tens;
        elsif i="010" then
            an<= "1011";
            --seg<="0110000";
            seg<=hundreds;
        else
            an<= "0111";
           -- seg<="0011001";
            seg<=thousands;    
        end if;
 
    end process;   
       
    INC_i: process(counter2(1)) begin
        if rising_edge(counter2(1)) then 
           
                    i2 <= std_logic_vector(unsigned(i2)+1); 
               
                if i2 > "011" then 
                    i2<="000";
                end if; 
                    i<=i2; 
         end if;                   
    end process;

   clk_division: process(clk) begin
        if(rising_edge(clk)) then
            
                counter <= std_logic_vector(unsigned(counter)+1);
            
        end if;
    end process;
    
    clk_division2: process(counter(15)) begin
        if(rising_edge(counter(15))) then
            
                counter2 <= std_logic_vector(unsigned(counter2)+1);
            
        end if;
    end process;

end Behavioral;
