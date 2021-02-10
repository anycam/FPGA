----------------------------------------------------------------------------------
-- Nombre:
--				Camarena Garcia Andre
-- Programa: SEMAFORO
-- Fecha: 22-05-2020
-- Version:
-- NOTA:
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SEMA is
	PORT( clk: in std_logic;
			reset: in std_logic;
			Ro: out std_logic;
			Am: out std_logic;
			Ve: out std_logic);
			
end SEMA;

architecture Behavioral of SEMA is

signal Mem_Res : std_logic;
signal Mem_R : std_logic;
signal Mem_Am : std_logic;
signal Mem_V : std_logic;
signal Mem_V2 : std_logic;

SIGNAL CONT_RES: INTEGER RANGE 0 TO 999999:=0;
SIGNAL CONT_R: INTEGER RANGE 0 TO 49999999:=0;
SIGNAL CONT_AM: INTEGER RANGE 0 TO 49999999:=0;
SIGNAL CONT_V: INTEGER RANGE 0 TO 49999999:=0;
SIGNAL CONT_V2: INTEGER RANGE 0 TO 24999999:=0;

TYPE ESTADOS IS (R,A,B,C,D,E,F,G,H);
SIGNAL EDO_PRE, EDO_FUT:ESTADOS;


begin

P_ESTADOS:PROCESS(EDO_PRE,MEM_R,MEM_AM,MEM_V,MEM_RES,MEM_V2,CLK)

BEGIN
 CASE EDO_PRE IS
			
			
			--Estado Reset
			
			WHEN R =>
					
							RO <= '0';
							AM <= '0';
							VE <= '0';
							
							IF(MEM_RES ='1')THEN
								EDO_FUT <= A;
								
							ELSE
								EDO_FUT <= R;
								
							END IF;
					
					
				--Estado A
				
				WHEN A =>
							
							RO <= '1';
							AM <= '0';
							VE <= '0';
							
							IF(MEM_R='1')THEN
							
								EDO_FUT <= B;
								
							ELSE
							
								EDO_FUT <=A;
								
							END IF;
							
				--Estado B
				
				WHEN B =>
						
						RO <= '0';
						AM <= '0';
						VE <= '1';
						
						IF(MEM_V = '1')THEN
							
							EDO_FUT <= C;
							
						ELSE
						
							EDO_FUT <=B;
							
						END IF;
						
				--Estado C parpadeo de OFF
				
				WHEN C => 
				
						RO <= '0';
						AM <= '0';
						VE <= '0';
						
						IF(MEM_V2 ='1')THEN
							
							EDO_FUT <= D;
							
						ELSE
						
							EDO_FUT <= C;
							
						END IF;
				
				--Estado D parpadeo ON
				
				WHEN D =>
						
						RO <= '0';
						AM <= '0';
						VE <= '1';
						
						IF(MEM_V2 = '1')THEN
							
							EDO_FUT <= E;
						
						ELSE 
							
							EDO_FUT <= D;
							
						END IF;
						
				--Estado E parpadeo OFF
				
				WHEN E =>
						
						RO <= '0';
						AM <= '0';
						VE <= '1';
						
						IF(MEM_V2 = '1')THEN
							
							EDO_FUT <= F;
						
						ELSE 
							
							EDO_FUT <= E;
							
						END IF;
						
				--Estado F parpadeo ON
				
				WHEN F =>
						
						RO <= '0';
						AM <= '0';
						VE <= '1';
						
						IF(MEM_V2 = '1')THEN
							
							EDO_FUT <= G;
						
						ELSE 
							
							EDO_FUT <= F;
							
						END IF;
						
				--Estado G parpadeo OFF
				
				WHEN G =>
						
						RO <= '0';
						AM <= '0';
						VE <= '1';
						
						IF(MEM_V2 = '1')THEN
							
							EDO_FUT <= H;
						
						ELSE 
							
							EDO_FUT <= G;
							
						END IF;
						
				--Estado H
				
				WHEN H =>
						
						RO <= '0';
						AM <= '1';
						VE <= '0';
						
						IF(MEM_AM = '1')THEN
							
							EDO_FUT <= A;
						
						ELSE 
							
							EDO_FUT <= H;
							
						END IF;
						
	END CASE;
	
END PROCESS P_ESTADOS;
	
	
			--Reset General 
			
p_reloj: process(clk,reset,edo_fut)
		
begin 
				
					if(reset = '1')then 
						
						cont_res <=0;
						cont_r <=0;
						cont_am <=0;
						cont_v <=0;
						cont_v2 <=0;
						
						edo_pre <=R;
						
						
					elsif(clk 'event and clk = '1')then
					
						edo_pre <= edo_fut;
						
						
						
				--Demora para reset
				
				
				if(cont_res = 999999)then
				
					cont_res <= 0;
					mem_res <= '1';
					
					
				else 
				
					cont_res <= cont_res+1;
					mem_res <= '0';
					
				end if;
				
				
			--Demora de 1 segundo para rojo
			
				if(cont_r = 49999999)then
				
						cont_r <= 0;
						mem_r <= '1';
						
					else 
					
						cont_r <= cont_r+1;
						mem_r <='0';
						
					end if;
					
				--Demora de 1 segundo para verde
				
				if(cont_v = 49999999)then
				
						cont_v <= 0;
						mem_v <='1';
						
					else 
					
						cont_v <= cont_v+1;
						mem_v <= '0';
						
					end if;
					
				--Demora de 1 segundo para amarillo
				
				if(cont_am = 49999999)then
				
						cont_am <= 0;
						mem_am <= '1';
						
					else 
					
						cont_am <= cont_am+1;
						mem_am <= '0';
						
					end if;
					
				--Demora de 0.5 segundos para destello
				
						if(cont_v2 <= 24999999)then
						
							cont_v2 <= 0;
							mem_v2 <= '1';
							
						else 
								
								cont_v2 <= cont_v2+1;
								mem_v2 <= '0';
								
						end if;
					end if;
						
	end process p_reloj;
			

end Behavioral;

