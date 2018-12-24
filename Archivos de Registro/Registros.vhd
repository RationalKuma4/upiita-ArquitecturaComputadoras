library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_ARITH.all;
use IEEE.NUMERIC_STD.ALL;

entity principal is
    Port (  dir, she, clk, wr, clr: in std_logic;
				shamt: in std_logic_vector(2 downto 0);
				reg1, reg2, regw: in std_logic_vector(3 downto 0); --Localizacion de memoeria
				wdat: in std_logic_vector(7 downto 0); --Dato a escribir
				dat1, dat2: out std_logic_vector (7 downto 0)); --Datos de salida a led
end principal;

architecture Behavioral of principal is
	type registros is array (0 to 15) of std_logic_vector(7 downto 0);
	signal reg:registros;
begin
	process(reg1, reg2, regw, shamt, clr, clk, dir, she)
	begin
		if (clr = '1') then
			for i in 0 to 15 loop
				reg(i) <= (others => '0');
			end loop;
		elsif (rising_edge(clk)) then
			if (she = '1' and dir = '0') then
				dat1 <= SHR(reg(conv_integer(reg1)),shamt);
			elsif (she = '1' and dir = '1') then
				dat1 <= SHL(reg(conv_integer(reg1)),shamt);
			else
				dat1 <= reg(conv_integer(reg1));
			end if;
			dat2 <= reg(conv_integer(reg2));
			if (wr = '1') then
				reg(conv_integer(regw)) <= wdat;
			end if;
		end if;
	end process;
end Behavioral;

