-- Librerías
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all; 

entity pila_vhd is port (
	dat: in std_logic_vector(8 downto 0);  -- Datos de entrada
	q: out std_logic_vector(8 downto 0);  -- Datos de salida
	clkin, clr, up, dw, wpc: in std_logic  -- Reloj, Boton Clear, Up, down, Grabar
	);
end pila_vhd;

architecture Behavioral of pila_vhd is
	type contador is array (0 to 7) of std_logic_vector(8 downto 0);   -- Pila
	signal contas:contador;    -- Señal de pila
   signal clk: std_logic;    -- Reloj (Señal modificada para ir mas lento)	
begin
--
-- Proceso que disminuye la velocidad del reloj
--
process(clkin)  
variable i:integer:=0;  -- Variable auxiliar
begin
    if(rising_edge(clkin))then
        i:=i+1;
        if(i = 25000000)then
            clk<='1';
				i:=0;
		  else	
				clk<='0';
        end if;
    end if;
end process;
--
-- Proceso que controla la pila
--
process(clr, clk, up, dw, wpc, dat)
	variable sp: integer range 0 to 7;     -- Variable auxiliar
begin
	if (clr='1') then   -- Funcion "if" que activa la limpieza de la pila
		sp:=0;
		for I in 0 to 7 loop
			contas(I)<="000000000";
		end loop;
	elsif (clk'event and clk='1') then  -- Función principal de la pila
		if (wpc='1' and up='1') then    -- Función "if" que activa el guardado
			sp := sp+1; 
			contas(sp) <= dat; 
		elsif (wpc='0' and dw='1') then   -- Función "if" que activa el "Down"
				sp:= sp-1;
			   contas(sp) <= contas(sp)+1;
			elsif(wpc='1' and up='0') then  -- Función "if" que activa el "up"
				--sp:= sp+1;
				contas(sp) <= dat;--contas(sp)+1;
				else
					contas(sp) <= contas(sp)+1;  -- Contador de la pila
			end if;
		q<=contas(sp);  -- Asigna contador a la salida
	end if;
end process;
end Behavioral;
