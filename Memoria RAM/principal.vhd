library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM_FULL is
port(
       clk, rw, cs : in std_logic;
		 dir : in std_logic_vector(4 downto 0);
       di : in std_logic_vector(7 downto 0);           										
       do : out std_logic_vector(7 downto 0);            
       hd : out std_logic_vector(3 downto 0));            
end RAM_FULL;   
                                               
architecture arqRAM_FULL of RAM_FULL is

signal clk120 : std_logic;
signal clk6 : std_logic;
signal sc5b : std_logic_vector(4 downto 0);
signal sc2b : std_logic_vector(1 downto 0);
signal ssum : std_logic_vector(4 downto 0);
signal dirmux : std_logic_vector(4 downto 0);
type mem is array(0 to 31) of
     std_logic_vector(7 downto 0);
	  
	 	signal regs: MEM :=  
(x"03",x"9F",x"25",x"0D",
x"99",x"49",x"41",x"1D",
x"01",x"19",x"11",x"c1",
x"63",x"85",x"61",x"71",
--SE REPITE BLA BLA
x"03",x"9F",x"25",x"0D",
x"99",x"49",x"41",x"1D",
x"01",x"19",x"11",x"c1",
x"63",x"85",x"61",x"71"
);
-- 
--	  
--signal regs : mem :=(x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
--                        x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
--                        x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
--                        x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF"); 	
begin
c120:process(clk)
variable i: integer:=0;
begin
if(clk'event and clk = '1') then
	i := i + 1;
	if (i = 100000) then -- 50MHz / 500KHZ
		clk120 <= '1';
		i := 0;
	else
		clk120 <= '0';
	end if;
end if;
end process c120;

c6:process(clk)
variable i: integer:=0;
begin
if (clk'event and clk = '1') then
	i := i+1;
	if (i = 10000000) then -- 50MHz / 5Hz
		clk6 <= '1';
		i := 0;
	else
		clk6<='0';
	end if;
end if;
end process c6;

cont2b:process(clk120)
begin
if (clk120'event and clk120 = '1') then
	sc2b <= sc2b + 1;
end if;
end process cont2b;

cont5b:process(clk6)
begin
if(clk6'event and clk6 = '1') then
	sc5b <= sc5b+1;
end if;
end process cont5b;

	sumab:process(sc2b,sc5b)
begin
	ssum <= sc2b + sc5b;
end process sumab;

mux:process(ssum,dir,rw)
begin
if (rw = '1') then
	dirmux <= ssum;
else
	dirmux <= dir;
end if;
end process mux;

m_RAM:process(clk,rw,cs,di,dirmux)
begin
if (cs = '1') then
	do <= (others =>'0');
elsif(clk'event and clk = '1') then
	if (rw = '1') then
		do <= regs(conv_integer(dirmux));
	else
		regs(conv_integer(dirmux)) <= di;
	end if;
end if;
end process m_RAM;

deco:process(sc2b)
begin
case sc2b is

	when "00" => hd <= "0111";
	when "01" => hd <= "1011";
	when "10" => hd <= "1101";
	when others => hd <= "1110";
end case;

end process deco;
end arqRAM_FULL;