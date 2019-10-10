function [t,y]=solve_vdp_pertur(Case, disturbance, dist_term)

global casenum
casenum = Case;
%%%disturbance   1:Starvation 2:Midden collapse 3:Debris inflow
%%%dist_term   1:Longperiod 2:Short period 3:During grow up

year=15;%simulation time(year)
stopflag = 0;%After the colony is extinction, the simulation stops.
t_tot=      6.5*60*60*30*7*year;    %Total simulation time [sec]
set_parameter();%%Parameter determination
global p_fdetect;
global p_mcoll; 
global p_din;
if (dist_term == 1)
    t_pertur=   6.5*60*60*30*7*5;      %time to start disturbance[sec]
    l_pertur=   6.5*60*60*30*7*2;      %Period of disturbance[sec]
    if (disturbance == 1)
            e1_pertur=  3.4*10^(-4);%p_fdetect value under disturbance   
            c_coll_pertur= p_mcoll;%p_mcoll value under disturbance   
            d_plus_pertur= p_din;%p_din value under disturbance   
    end
    if (disturbance == 2)
            e1_pertur= p_fdetect;   
            c_coll_pertur= p_mcoll * 600;
            d_plus_pertur= p_din;
    end
    if (disturbance == 3)
            e1_pertur=  p_fdetect;   
            c_coll_pertur= p_mcoll;
            d_plus_pertur= 5e-3;
    end
end

if (dist_term == 2)
    t_pertur=   6.5*60*60*30*7*5;      %time to start disturbance[sec]
    l_pertur=   6.5*60*60*30;          %Period of disturbance[sec]
    if (disturbance == 1)
            e1_pertur=  3.0*10^(-4);   
            c_coll_pertur= p_mcoll;
            d_plus_pertur= p_din;
    end
    if (disturbance == 2)
            e1_pertur= p_fdetect;   
            c_coll_pertur= p_mcoll * 5000;
            d_plus_pertur= p_din;
    end
    if (disturbance == 3)
            e1_pertur=  p_fdetect;   
            c_coll_pertur= p_mcoll;
            d_plus_pertur= 0.03;
    end
end

if (dist_term == 3)
    t_pertur=   6.5*60*60*30;       %time to start disturbance[sec]
    l_pertur=   6.5*60*60*30;       %Period of disturbance[sec]
    if (disturbance == 1)
            e1_pertur=  2.6*10^(-4);   
            c_coll_pertur= p_mcoll;
            d_plus_pertur= p_din;
    end
    if (disturbance == 2)
            e1_pertur= p_fdetect;   
            c_coll_pertur= p_mcoll *10;
            d_plus_pertur= p_din;
    end
    if (disturbance == 3)
            e1_pertur=  p_fdetect;   
            c_coll_pertur= p_mcoll;
            d_plus_pertur= 1e-4;
    end
end


%% Initialize
global ene_init
global intra_init
global forager_init
global midworker_init
global nestworker_init
y0=[0; 0; forager_init; 0; 0; midworker_init; 0; 0; nestworker_init; intra_init; 0; 0; ene_init];%%Initial workers

%% Simulation under normal environment
options = odeset('Events',@events);
[t,y,~,~] = ode23tb(@vdp,[0 t_pertur],y0,options);%%Normal environment untill disturbance start

%% Disturbance start
p_fdetect=e1_pertur;
p_din=d_plus_pertur;
p_mcoll = c_coll_pertur;

[ta,ya,te,~]=ode23tb(@vdp,[t_pertur t_pertur+l_pertur],y(end,:),options);%%Dusturbed environment untill disturbance end

if (ta(end)<t_pertur+l_pertur)%%Extinct judge
    %sprintf('Case%d is dead at %0.5f day',casenum,((te(end)-t_pertur)/(6.5*60*60)))
    stopflag = 1;
end
t=vertcat(t,ta);
y=vertcat(y,ya);

%% Disturbance finish
if (stopflag == 0) 
    set_parameter();
    [ta,ya]=ode23tb(@vdp,[t_pertur+l_pertur t_tot],y(end,:),options);
    t=vertcat(t,ta);
    y=vertcat(y,ya);
end




%% Event function
    function [value,isterminal,direction] = events(~,y)
        CCS_now=y(1)+y(2)+y(3)+y(4)+y(5)+y(6)+y(7)+y(8)+y(9)+y(10);
        % Locate the time when height passes through zero in a
        % decreasing direction and stop integration.
        value(1) = CCS_now - 1;     % we set impposible value for not doing this event.% Detect CCS_now = 1
        isterminal(1) = 1;   % Stop the integration
        direction(1) = -1;   % negative direction
    end
end
