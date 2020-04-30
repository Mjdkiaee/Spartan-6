
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ADC_Driver_128s102 is
    Port ( i_Clk : in  STD_LOGIC;
           i_Rst : in  STD_LOGIC;
           O_Mosi : out  STD_LOGIC;
           O_CS : out  STD_LOGIC;
           i_Miso : in  STD_LOGIC;
           O_Sclk : out  STD_LOGIC;
			 out_r_rising_counter: out  integer;
			  out_r_falling_counter: out  integer;
          o_data : out  STD_LOGIC_VECTOR (11 downto 0);
			 -- o_data : out  STD_LOGIC ;
           o_Data_valid : out  STD_LOGIC;
           i_Switch : in  STD_LOGIC_VECTOR (2 downto 0);
           o_chanel : out  STD_LOGIC_VECTOR (2 downto 0));
end ADC_Driver_128s102;

architecture Behavioral of ADC_Driver_128s102 is

signal r_CS : std_logic :='0' ;
signal r_Sclk : std_logic :='1';
signal r_ralling_counter :integer range 0 to 17 ;
signal r_rising_counter :integer range 0 to 15 ;
signal r_data_Buffer: STD_LOGIC_VECTOR (15 downto 0);
signal first: std_logic:='0';
--signal r_data_Buffer: STD_LOGIC;

begin

process(i_Clk)
begin
   if rising_edge(i_Clk) then
      if (i_Rst='1') then
        r_CS<='1';
        r_Sclk<='1';
     --   o_Data_valid<='0';
       else
        r_CS<='0';
       end if;
       if (r_CS='0') then
          r_Sclk<= not r_Sclk;
       end if;
    end if;
end process ;

 process(r_Sclk)
  begin
         
  if falling_edge(r_Sclk) then
   o_Data_valid<='0';

   if (r_ralling_counter<15) then
	
        r_ralling_counter<=r_ralling_counter+1;
	
        
        else
        r_ralling_counter<=0;
		  first<='1';
        end if;
		  if  (r_ralling_counter=0 and first='1') then
		      o_Data_valid<='1';
            o_data<=r_data_Buffer(11 downto 0);
			end if;	
		  
		 r_data_Buffer(15-r_ralling_counter)<=i_Miso;
  end if;

   if (rising_edge(r_Sclk)) then
		
		 
      if (r_rising_counter<15) then
        r_rising_counter<=r_rising_counter+1;
		  
      else
        r_rising_counter<=1;  
      end if;
		if (r_rising_counter>1 and r_rising_counter<5) then
          O_Mosi<= i_Switch(4-r_rising_counter);
          end if;
     
    end if;
  end process;
 out_r_rising_counter<= r_rising_counter;
  out_r_falling_counter<= r_ralling_counter;

 O_CS<=r_CS;
 O_Sclk<=r_Sclk;
 o_chanel<=i_Switch;
-- o_data<=r_data_Buffer(11 downto 0);
--o_data<=r_data_Buffer;
--o_data<='1';
end Behavioral;

