----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:39:47 10/13/2017 
-- Design Name: 
-- Module Name:    LCD_16X2 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity LCD_16X2 is
    Port ( en : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           dato : out  STD_LOGIC_VECTOR (9 downto 0));
end LCD_16X2;

architecture Behavioral of LCD_16X2 is

type registros is array (0 to 63) of std_logic_vector (9 downto 0);
constant reg: registros :=(

x"38" & "10", x"38" & "00",
x"0F" & "10", x"0F" & "00",
x"01" & "10", x"01" & "00",
x"02" & "10", x"02" & "00", --Hasta aqui va a inicializar el LCD
x"4A" & "11", x"4A" & "01", -- J
x"55" & "11", x"55" & "01", -- U
x"4C" & "11", x"4C" & "01", -- L
x"49" & "11", x"49" & "01", -- I
x"4F" & "11", x"4F" & "01", -- O

x"20" & "11", x"20" & "01", -- 
x"42" & "11", x"42" & "01", -- B
x"52" & "11", x"52" & "01", -- R
x"41" & "11", x"41" & "01", -- A
x"4E" & "11", x"4E" & "01", -- N
x"44" & "11", x"44" & "01", -- D
x"4F" & "11", x"4F" & "01", -- O
x"4E" & "11", x"4E" & "01", -- N
x"20" & "11", x"20" & "01", -- 
x"4A" & "11", x"4A" & "01", -- J
x"4F" & "11", x"4F" & "01", -- O

x"C0" & "10",x"C0" & "00", --Salto a 0x40

x"55" & "11", x"55" & "01", -- U
x"50" & "11", x"50" & "01", -- P
x"49" & "11", x"49" & "01", -- I
x"49" & "11", x"49" & "01", -- I
x"54" & "11", x"54" & "01", -- T
x"41" & "11", x"41" & "01", -- A
x"20" & "11", x"20" & "01", --
x"49" & "11", x"49" & "01", -- I
x"50" & "11", x"50" & "01", -- P
x"4E" & "11", x"4E" & "01", -- N
x"00" & "00", x"00" & "00" --vacio
);

--Señal de apoyo de clk
signal auxclk: std_logic;

--Señal de direccion
signal dir: std_logic_vector(5 downto 0);

begin

--Señal de reloj
	process(clk)
	variable i:integer;
	begin
		if(rising_edge(clk)) then --flanco de subida reloj 50MHZ
			i:=i+1;
			if(i=500000) then 
				i:=0;
				auxclk<='1';
			else 
				auxclk<='0';
			end if;
		end if;
	end process;
	
	--contador 6 bits(0 a 63) bus direcciones
	
	process(auxclk)
	begin
		if(rising_edge(auxclk)) then
			dir <= dir+1;
		end if;
	end process;
	
	--Proceso de memoria ROM
	
	process(en,dir)
	begin
		if en = '1' then
			dato <= "0000000000";
		else
			dato <= reg(conv_integer(dir));
		end if;
	end process;


end Behavioral;

