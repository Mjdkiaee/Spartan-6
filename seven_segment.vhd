
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity seven_segment is

	generic ( g_clk : integer := 24_000_000;
		     g_time_elapse : integer := 1 --mili second
		
	);
Port ( clock: in  STD_LOGIC;
          segment : out  STD_LOGIC_VECTOR (7 downto 0);
           sel : out  bit_vector (3 downto 0));
end seven_segment;



architecture Behavioral of seven_segment is
constant c_clk_time : integer := g_clk * g_time_elapse/1000; 
--signal select_seg: bit_vector(3 downto 0) :=  "0111";
signal sel_seg 		:bit_vector(3 downto 0):= "0111";
begin
	process(clock)
	variable counter : integer range 0 to c_clk_time-1;
    begin
    	if rising_edge (clock) then
    		
    	
	    	
	    		
	    	if counter> c_clk_time then
	    		counter := 0;
	    		sel_seg <= sel_seg ror 1;
		    else 
					counter:= counter+1;
				
	    		case (sel_seg) is
				        when "1110"=>
							           segment <= x"F9";	-- 1 	on 7_seg
						when "1101"=>
							            segment <= x"B0";	-- 3	on 7_seg
						when "1011"=>
							            segment <= x"90";	-- 9	on 7_seg
						when "0111"=>
							             segment <= x"90";  -- 9	on 7_seg
						when others =>
							            segment <= x"FF";
	    		end case;
	    		
	    	end if;
	    end if;	


		
	end process ; -- 

sel <=sel_seg;
end Behavioral;

