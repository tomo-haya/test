function [t,y]=solve_vdp(Case)

global casenum  %Global variable to determine case @ vdp.m
casenum = Case;

year=15;%simulation time(year)
t_tot=      6.5*60*60*30*7*year;    %[sec]  oneday:6.5h, one month:30day, one year:7month
%% Initialize
set_parameter();    %Constant variables determination
global ene_init
global intra_init
global forager_init
global midworker_init
global nestworker_init
y0=[0; 0; forager_init; 0; 0; midworker_init; 0; 0; nestworker_init; intra_init; 0; 0; ene_init];%%Initial workers
options = odeset('Events',@events);

[t,y] = ode23tb(@vdp,[0 t_tot],y0,options);%Solve ODE. t:sec, y:see vdp.m 

%% Event function which catches small colony size
    function [value,isterminal,direction] = events(~,y)
        CCS_now=y(1)+y(2)+y(3)+y(4)+y(5)+y(6)+y(7)+y(8)+y(9)+y(10);
        value(1) = CCS_now;     % Detect CCS_now = 1
        isterminal(1) = 1;   % Stop the integration, if set as 1, then calc is stopped @ ccs < 1
        direction(1) = -1;   % negative direction
    end
end
