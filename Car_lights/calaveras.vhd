----------------------------------------------------------------------------------
-- Nombre:
-- Programa: CALAVERA
-- Fecha: /06/2020
-- Version: 1
-- Grupo: 2606
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity calavera is
port( clk : in std_logic;
		reset : in std_logic;
		
		izq_in : in std_logic;
		der_in : in std_logic;
	   inter_in : in std_logic;
		rever_in : in std_logic;
		stop_in : in std_logic;
		
		izq_led : out std_logic;
		der_led : out std_logic;
		rever_led : out std_logic;
		stop_led : out std_logic);
end calavera;
architecture behavioral of calavera is
	signal mem_res : std_logic; --Bandera Reset
	signal mem_men : std_logic; --Bandera demora menor
	signal cont_rest : integer	range 0 to 999999:=0;
	signal cont_men : integer range 0 to 49999999:=0;--Retardo 1000 ms
	

	
type estados is (r,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,edo0,
						izq0,izq1,izq2,izq3,izq4,izq5,izq6,izq7,izq8,izq9,izq10,izq11,izq12,izq13,izq14,izq15,
						der0,der1,der2,der3,der4,der5,der6,der7,der8,der9,der10,der11,der12,der13,der14,der15,
						rev0,rev1,rev2,rev3,rev4,rev5,
						stp0,stp1,stp2,stp3);
	signal edo_pre, edo_fut : estados;
begin
p_estados: process (edo_pre,mem_res,mem_men,izq_in,der_in,stop_in,clk)	
		begin
		case edo_pre is
-------------------------------------------------------------------------------------------		
			when r => 
						izq_led <= '0';
						der_led <= '0';
						stop_led <= '0';
						if (mem_res='1')then
							edo_fut <= izq0;
						else
							edo_fut<=r;
						end if;
-------------------------------------------------------------------------------------------					
			when edo0 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (inter_in='1')then
							edo_fut <= a;
						else
							edo_fut<=izq0;
						end if;	
-------------------------------------------------------------------------------------------					
			when a => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (rever_in='1')then
							edo_fut <= b;
						else
							edo_fut<=i;
						end if;		
-------------------------------------------------------------------------------------------					
			when b => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (stop_in='1')then
							edo_fut <= c;
						else
							edo_fut<=f;
						end if;
-------------------------------------------------------------------------------------------					
			when c => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '1';
						edo_fut<=d;
-------------------------------------------------------------------------------------------					
			when d => 
						izq_led <= '1';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <=e;
						else
							edo_fut<=d;
						end if;
-------------------------------------------------------------------------------------------					
			when e => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <=edo0;
						else
							edo_fut<=e;
						end if;						
-------------------------------------------------------------------------------------------					
			when f => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						edo_fut<=g;
-------------------------------------------------------------------------------------------					
			when g => 
						izq_led <= '1';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <=h;
						else
							edo_fut<=g;
						end if;						
-------------------------------------------------------------------------------------------					
			when h => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <=edo0;
						else
							edo_fut<=h;
						end if;		
-------------------------------------------------------------------------------------------					
			when i => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (stop_in='1')then
							edo_fut <=j;
						else
							edo_fut<=m;
						end if;
-------------------------------------------------------------------------------------------					
			when j => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						edo_fut<=k;
-------------------------------------------------------------------------------------------					
			when k => 
						izq_led <= '1';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <=l;
						else
							edo_fut<=k;
						end if;		
-------------------------------------------------------------------------------------------					
			when l => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <=edo0;
						else
							edo_fut<=l;
						end if;
-------------------------------------------------------------------------------------------					
			when m => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						edo_fut<=n;
-------------------------------------------------------------------------------------------					
			when n => 
						izq_led <= '1';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <=o;
						else
							edo_fut<=n;
						end if;		
-------------------------------------------------------------------------------------------					
			when o => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <=edo0;
						else
							edo_fut<=o;
						end if;						
-------------------------------------------------------------------------------------------					
			when izq0 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (izq_in='1' and der_in='0')then
							edo_fut <= izq1;
						else
							edo_fut<=der0;
						end if;
-------------------------------------------------------------------------------------------		
			when der0 => 
						izq_led <= '0';
						der_led <= '0';
						stop_led <= '0';
						if (der_in='1' and izq_in='0')then
							edo_fut <= der1;
						else
							edo_fut<=rev0;
						end if;
-------------------------------------------------------------------------------------------		
			when izq1 => 
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (rever_in='1')then
							edo_fut <= izq2;
						else
							edo_fut<=izq9;
						end if;		
-------------------------------------------------------------------------------------------		
			when izq2 => 
						izq_led <= '1';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (stop_in = '1')then
							edo_fut<=izq3;
						else
						edo_fut <= izq6;	
					   end if;	
-------------------------------------------------------------------------------------------		
			when izq3 => 
						izq_led <= '1';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						edo_fut<=izq4;
						
-------------------------------------------------------------------------------------------		
			when izq4 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= izq5;
						else
							edo_fut<=izq4;
						end if;
-------------------------------------------------------------------------------------------		
			when izq5 => 
						izq_led <= '1';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '1';
						if(mem_men='1')then
							edo_fut<=edo0;
						else
							edo_fut<=izq5;
						end if;
-------------------------------------------------------------------------------------------		
			when izq6 => 
						izq_led <= '1';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						
						edo_fut <= izq7;
					
-------------------------------------------------------------------------------------------		
			when izq7 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= izq8;
						else
							edo_fut<=izq7;
						end if;		
-------------------------------------------------------------------------------------------
			when izq8 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=izq8;
						end if;
-------------------------------------------------------------------------------------------
			when izq9 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if(stop_in='1') then
						edo_fut <= izq10;
						else
						edo_fut<= izq13;
						end if;
-------------------------------------------------------------------------------------------
			when izq10 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						
						edo_fut <= izq11;
-------------------------------------------------------------------------------------------
			when izq11 =>
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= izq12;
						else
							edo_fut<=izq11;
						end if;
-------------------------------------------------------------------------------------------
			when izq12 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=izq12;
						end if;
-------------------------------------------------------------------------------------------
			when izq13 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						edo_fut<=izq14;
-------------------------------------------------------------------------------------------
			when izq14 =>
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= izq15;
						else
							edo_fut<=izq14;
						end if;
-------------------------------------------------------------------------------------------
			when izq15 =>
						izq_led <= '1';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=izq15;
						end if;
						
												
-------------------------------------------------------------------------------------------			

-------------------------------------------------------------------------------------------		
			when der1 => 
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '0';
						if (rever_in='1')then
							edo_fut <= der2;
						else
							edo_fut<=der9;
						end if;		
-------------------------------------------------------------------------------------------		
			when der2 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (stop_in = '1')then
							edo_fut<=der3;
						else
						edo_fut <= der6;	
					   end if;	
-------------------------------------------------------------------------------------------		
			when der3 => 
						izq_led <= '0';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '1';
						edo_fut<=der4;
						
-------------------------------------------------------------------------------------------		
			when der4 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= der5;
						else
							edo_fut<=der4;
						end if;
-------------------------------------------------------------------------------------------		
			when der5 => 
						izq_led <= '0';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '1';
						if(mem_men='1')then
							edo_fut<=edo0;
						else
							edo_fut<=der5;
						end if;
-------------------------------------------------------------------------------------------		
			when der6 => 
						izq_led <= '0';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '0';
						
						edo_fut <= der7;
					
-------------------------------------------------------------------------------------------		
			when der7 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= der8;
						else
							edo_fut<=der7;
						end if;		
-------------------------------------------------------------------------------------------
			when der8 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='1';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=der8;
						end if;
-------------------------------------------------------------------------------------------
			when der9 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '0';
						if(stop_in='1') then
						edo_fut <= der10;
						else
						edo_fut<= der13;
						end if;
-------------------------------------------------------------------------------------------
			when der10 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '1';
						
						edo_fut <= der11;
-------------------------------------------------------------------------------------------
			when der11 =>
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= der12;
						else
							edo_fut<=der11;
						end if;
-------------------------------------------------------------------------------------------
			when der12 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '1';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=der12;
						end if;
-------------------------------------------------------------------------------------------
			when der13 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '0';
						edo_fut<=der14;
-------------------------------------------------------------------------------------------
			when der14 =>
						izq_led <= '0';
						der_led <= '0';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= der15;
						else
							edo_fut<=der14;
						end if;
-------------------------------------------------------------------------------------------
			when der15 =>
						izq_led <= '0';
						der_led <= '1';
						rever_led <='0';
						stop_led <= '0';
						if (mem_men='1')then
							edo_fut <= edo0;
						else
							edo_fut<=der15;
						end if;
-------------------------------------------------------------------------------------------		
			when rev0 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='0';
						stop_led <= '0';
						if (rever_in='1')then
							edo_fut <= rev1;
						else
							edo_fut<=stp0;
						end if;
-------------------------------------------------------------------------------------------		
			when rev1 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='1';
						stop_led <= '0';
						if (stop_in='1')then
							edo_fut <= rev2;
						else
							edo_fut<=rev4;
						end if;		
-------------------------------------------------------------------------------------------		
			when rev2 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='1';
						stop_led <= '1';
						edo_fut<=rev3;
-------------------------------------------------------------------------------------------		
			when rev3 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='1';
						stop_led <= '1';
						if (mem_res ='1')then
							edo_fut <= edo0;
						else
							edo_fut<=rev3;
						end if;
-------------------------------------------------------------------------------------------		
			when rev4 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='1';
						stop_led <= '0';
						edo_fut<=rev5;
-------------------------------------------------------------------------------------------		
			when rev5 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='1';
						stop_led <= '0';
						if (mem_res='1')then
							edo_fut <= edo0;
						else
							edo_fut<=rev5;
						end if;						
-------------------------------------------------------------------------------------------						
-------------------------------------------------------------------------------------------		
			when stp0 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='0';
						stop_led <= '0';
						if (stop_in='1')then
							edo_fut <= stp1;
						else
							edo_fut<=edo0;
						end if;
-------------------------------------------------------------------------------------------		
			when stp1 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='0';
						stop_led <= '0';
						if (stop_in='1')then
							edo_fut <= stp2;
						else
							edo_fut<=stp3;
						end if;		
-------------------------------------------------------------------------------------------		
			when stp2 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='0';
						stop_led <= '1';
						if (mem_res='1')then
							edo_fut <= edo0;
						else
							edo_fut<=stp2;
						end if;		
-------------------------------------------------------------------------------------------		
			when stp3 => 
						izq_led <= '0';
						der_led <= '0';
						rever_led<='0';
						stop_led <= '0';
						if (mem_res ='1')then
							edo_fut <= edo0;
						else
							edo_fut<=stp3;
						end if;
-------------------------------------------------------------------------------------------		
			end case;
			end process p_estados;
-------------------------------------------------------------------------------------------
p_reloj: process (clk,reset,edo_fut)
	begin
		if (reset ='1')then
			cont_rest <= 0;
			cont_men <= 0;
			edo_pre <= r;
		elsif (clk 'event and clk ='1')then
			edo_pre <= edo_fut;
			
			if(cont_rest=999999) then
				cont_rest <= 0;
				mem_res <= '1';
				else
					cont_rest<=cont_rest+1;
					mem_res<='0';
			end if;
			
			if (cont_men=49999999)then
				cont_men<=0;
				mem_men<='1';
			else
				cont_men<=cont_men+1;
				mem_men<='0';
			end if;
		end if;
	end process p_reloj;
end behavioral;