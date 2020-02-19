library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity walkingOne is 

	port (
	Clock_In : in std_logic;
	Reset_In : in std_logic;
	SW_In		: in std_logic; --We just care what switch(0) is
	LEDR_Out	: out std_logic_vector(9 downto 0);
	GPIO_Out	: out std_logic_vector(9 downto 0)
	);
	
end entity; 

architecture walkingOne_arch of walkingOne is

	type State_Type is (L0,L1,L2,L3,L4,L5,L6,L7,L8,L9); --States
		signal current_state, next_state : State_Type; 

begin

  State_Memory : process(Clock_In, Reset_In) 
    begin
      
    if (Reset_In = '0') then 
      current_state <= L0;
    elsif(rising_edge(Clock_In)) then
      current_state <= next_state;
  end if; 
  end process;
  
    Next_State_Logic : process (current_state, SW_In)
    begin
	 
      case(current_state) is
      
      when L0 => 
      if(SW_In = '1') then
          next_state <=  L1;
        else
            next_state <= L9;
      end if;
      
      
      when L1 => 
      if(SW_In = '1') then
          next_state <=  L2;
        else
            next_state <= L0;
      end if;    
      
        
      when L2 => 
      if(SW_In = '1') then
          next_state <=  L3;
        else
            next_state <= L1;
      end if;    
      
      
      when L3 => 
      if(SW_In = '1') then
          next_state <=  L4;
        else
            next_state <= L2;
      end if;
		
      when L4 => 
      if(SW_In = '1') then
          next_state <=  L5;
        else
            next_state <= L3;
      end if;
      when L5 => 
      if(SW_In = '1') then
          next_state <=  L6;
        else
            next_state <= L4;
      end if;
      when L6 => 
      if(SW_In = '1') then
          next_state <=  L7;
        else
            next_state <= L5;
      end if;
      when L7 => 
      if(SW_In = '1') then
          next_state <=  L8;
        else
            next_state <= L6;
      end if;
      when L8 => 
      if(SW_In = '1') then
          next_state <=  L9;
        else
            next_state <= L7;
      end if;
      when L9 => 
      if(SW_In = '1') then
          next_state <=  L0;
        else
            next_state <= L8;
      end if;		
    end case; 
	 
	 end process;	
	

    Output_Logic : process (current_state)
    begin
			case (current_state) is
			when L0 => 
				LEDR_Out <= "0000000001";
				GPIO_Out <= "0000000001";
			when L1 => 
				LEDR_Out <= "0000000010";
				GPIO_Out <= "0000000010";
			when L2 => 
				LEDR_Out <= "0000000100";
				GPIO_Out <= "0000000100";
			when L3 => 
				LEDR_Out <= "0000001000";
				GPIO_Out <= "0000001000";
			when L4 => 
				LEDR_Out <= "0000010000";
				GPIO_Out <= "0000010000";
			when L5 => 
				LEDR_Out <= "0000100000";
				GPIO_Out <= "0000100000";
			when L6 => 
				LEDR_Out <= "0001000000";
				GPIO_Out <= "0001000000";
			when L7 => 
				LEDR_Out <= "0010000000";
				GPIO_Out <= "0010000000";
			when L8 => 
				LEDR_Out <= "0100000000";
				GPIO_Out <= "0100000000";
			when L9 => 
				LEDR_Out <= "1000000000";
				GPIO_Out <= "1000000000";				
			end case;
	 
	 end process;	
	 
end architecture; 