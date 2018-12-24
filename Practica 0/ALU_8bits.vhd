----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:27 10/12/2017 
-- Design Name: 
-- Module Name:    ALU_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:51:21 09/28/2017 
-- Design Name: 
-- Module Name:    ALU_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

USE IEEE.STD_LOGIC_ARITH.ALL;

USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_8bits is

    Port ( 
	 
			  a : in  STD_LOGIC_VECTOR (7 downto 0);

           b : in  STD_LOGIC_VECTOR (7 downto 0);

           op : in  STD_LOGIC_VECTOR (3 downto 0);

           Bandera : out  STD_LOGIC_VECTOR (3 downto 0);

           x : inout  STD_LOGIC_VECTOR (7 downto 0));

end ALU_8bits;

architecture Behavioral of ALU_8bits is

	signal muxa : std_logic_vector (7 downto 0);
	signal muxb : std_logic_vector (7 downto 0);
	signal carry : std_logic_vector (8 downto 0);
	
begin

		process (muxa, muxb, op, a, b, carry, x)
	
		begin
			
			carry <= (others => '0');
			carry(0) <= op(3);

		for i in 0 to 7 loop
		
			muxa(i) <= a(i) xor op(2);
			muxb(i) <= b(i) xor op(3);
				
		case(op(1 downto 0)) is
		
			when "00" => 
				
				x(i) <= muxa(i) and muxb(i);
			
			when "01" =>
				
				x(i) <= muxa(i) or muxb(i);
			
			when "10" => 
				
				x(i) <= muxa(i) xor muxb(i);
			
			when others => 
			
				x(i) <= (muxa(i) xor muxb(i)) xor carry(i);
				carry (i+1) <= (muxa(i) and muxb(i)) or ((muxa(i) xor muxb(i)) and carry(i));
		
		end case;
		end loop;
		
		Bandera(3) <= carry(8); -- Acarreo
		Bandera(0) <= carry(8) xor carry(7);	-- Overflow
		Bandera(1) <= (carry(8) xor carry(7)) xor x(7); -- Signo	
		Bandera(2) <= not (x(7) or x(6) or x(5) or x(4) or x(3) or x(2) or x(1) or x(0)); -- Cero
		
		end process;
		
	
end Behavioral;


