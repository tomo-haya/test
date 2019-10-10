function result = solve_vdp_roundtrip(Case)
%Function for making S1-S12 Tables
%% Initial setting
global casenum
casenum = Case;
global ene_init
global intra_init
global forager_init
global midworker_init
global nestworker_init
h = waitbar(0,['Case',num2str(casenum)]);%Waitbar
year=15;
t_tot=      6.5*60*60*30*7*year;%simulation time(year)
y0=[0; 0; forager_init; 0; 0; midworker_init; 0; 0; nestworker_init; intra_init; 0; 0; ene_init];%%Initial workers
options = odeset('Events',@events);
set_parameter();%%Parameter determination

global b_larva;
global q_y;
%% Configuration: Modified variables and the range
global parametername;
parametername='n_hunger';                              %Variable name
global  n_hunger;                                      %Variable name
step=1;%%%FiX
%range: +-50%
rangevalue =n_hunger;                                  %Variable name
range=0.5*rangevalue:rangevalue/step:1.5*rangevalue;   %Range (In document, 50%-150%)
%range=rangevalue;                                     %Original           
result=zeros(length(range),15);


%% Solve ODE repeatedly in the set range
for i=1:length(range)
    result(i,1)=range(i);
    set_parameter();
    %Value change
    n_hunger=range(i);                          %Variable name                        
    %% If another constant value is changed with upper variable's change, please write here.
  %  b_larva=p_larva * 1/1e5;
  %  q_y= n_max * 1.4;
    [t,y,~,~] = ode23tb(@vdp,[0 t_tot],y0,options);
    result(i,2:14)=y(end,:);%Memorize all worker's number.
    
    CCS =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);%%Current colony size
    result(i,15)=CCS(end);%Memorize the colony size
    waitbar(i/length(range));    %% Update waitbar
end
close(h);

%% Event function which catches small colony size
    function [value,isterminal,direction] = events(~,y)
        CCS_now=y(1)+y(2)+y(3)+y(4)+y(5)+y(6)+y(7)+y(8)+y(9)+y(10);
        % Locate the time when height passes through zero in a
        % decreasing direction and stop integration.
        value(1) = CCS_now;     % Detect CCS_now = 1
        isterminal(1) = 1;   % Stop the integration
        direction(1) = -1;   % negative direction
    end
end
