function dydt = vdp(~,y)
%% y(1):W_R_forag y(2):W_R_mid y(3):W_R_nest
%% y(4):W_E_forag y(5):W_E_mid y(6):W_E_nest
%% y(7):W_I_forag y(8):W_I_mid y(9):W_I_nest y(10):W_E_intra+W_I_intra
%% y(11):M y(12):D y(13):N

%% Constant Variables determined in set_parameter.m
global q_y;
global p_rstop;
global p_estop;
global q_x;
global p_mdetect;
global p_iteng;
global p_difeng;
global u_inside;
global u_outside;
global n_max;
global p_larva;
global p_din;
global n_food;
global n_hunger;
global p_ddetect;
global p_fdetect;
global p_mcoll;
global b_max;
global b_larva;
global a_foraging;
global a_midden;
global a_nest;
global a_intra;
global p_enemy;
global q_enemy;

global casenum %Scenario, which is determined in solve_vdp


CCS=y(1)+y(2)+y(3)+y(4)+y(5)+y(6)+y(7)+y(8)+y(9)+y(10);%%Current colony size
n_negative=(n_max/q_y)/(1-exp(-(n_max/q_y)));
n_positive=(n_max/q_y)/(exp(n_max/q_y) - 1);

switch casenum %Scenario, which is determined in solve_vdp
    case 1     %Colony size case (-1)    %Food case (-1)
        X_FB=q_x/(CCS - y(4) - y(5));
        Y_FB=n_negative * (exp(-y(13)/(CCS*q_y)));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 2         %Colony size case (0H)       %Food case (-1)
        X_FB=q_x/10;
        Y_FB=n_negative * (exp(-y(13)/(CCS*q_y)));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 3       %Colony size case (0L)        %Food case (-1)
       X_FB=q_x/100;
        Y_FB=n_negative * (exp(-y(13)/(CCS*q_y)));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 4        %Colony size case (+1)        %Food case (-1)
        X_FB=q_x * (CCS - y(4) - y(5)) /10000;
        Y_FB=n_negative * (exp(-y(13)/(CCS*q_y)));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 5         %Colony size case (-1)       %Food case (0)
        X_FB=q_x/(CCS - y(4) - y(5));
        Y_FB=1;
    case 6          %Colony size (0H)       %Food case (0)
        X_FB=q_x/10;
        Y_FB=1;
    case 7        %Colony size case (0L)        %Food case (0)
        X_FB=q_x/100;
        Y_FB=1;   
    case 8        %Colony size case (+1)        %Food case (0)
        X_FB=q_x * (CCS - y(4) - y(5)) /10000;
        Y_FB=1;
    case 9        %Colony size case (-1)        %Food case (+1)
       X_FB=q_x/(CCS - y(4) - y(5));
        Y_FB=n_positive * exp(y(13)/(CCS*q_y));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 10        %Colony size case (0H)        %Food case (+1)
        X_FB=q_x/10;
        Y_FB=n_positive * exp(y(13)/(CCS*q_y));
        if Y_FB > 10^9
            Y_FB=10^9;
        end
    case 11        %Colony size case (0L)        %Food case (+1)
        X_FB=q_x/100;
        Y_FB=n_positive * exp(y(13)/(CCS*q_y));
        if Y_FB > 10^9
            Y_FB=10^9;
        end        
    case 12        %Colony size case (+1)        %Food case (+1)
        X_FB=q_x * (CCS - y(4) - y(5)) /10000;
        Y_FB=n_positive * exp(y(13)/(CCS*q_y));
        if Y_FB > 10^9
            Y_FB=10^9;
        end    
end



%% Calclate nutritional energy shortage
if(y(13)<0)
    n_lack=-y(13)/CCS;
else n_lack=0;
end

%% Number of birth
Nb=min(b_max*exp(-(n_lack/n_hunger)),(b_larva*y(10)));

%% Nutiritional Energy consumption
consume = u_inside*(y(1) + y(2) + y(3) + y(6) + y(7) + y(8) + y(9) + y(10))*24/6.5 + u_outside*(y(4) + y(5))*24/6.5; 
F_E_lack=1-exp(-(n_lack/n_hunger));

%% Number of death
D_R_f= min(1,a_foraging+F_E_lack) * y(1);
D_R_m= min(1,a_midden+F_E_lack) * y(2);
D_R_n= min(1,a_nest+F_E_lack) * y(3);
D_E_f= min(1,a_foraging+F_E_lack + p_enemy) * y(4);
D_E_m= min(1,a_midden+F_E_lack + p_enemy*exp(-y(11)/q_enemy)) * y(5);
D_E_n= min(1,a_nest+F_E_lack) * y(6);
D_I_f= min(1,a_foraging+F_E_lack) * y(7);
D_I_m= min(1,a_midden+F_E_lack) * y(8);
D_I_n= min(1,a_nest+F_E_lack) * y(9);
D_intra= min(1,a_intra+F_E_lack) * y(10);

%% ODE
dydt = zeros(13,1);
%Recruit
dydt(1) = p_fdetect * y(4) - p_rstop * y(1) - D_R_f;
dydt(2) = exp(-y(11)/p_mdetect) * y(5) - p_rstop * y(2) -D_R_m;
dydt(3) = (1-(1/exp((y(12)/p_ddetect)))) * y(6) - p_rstop * y(3) -D_R_n;
%Work
dydt(4) = p_rstop*y(1)-p_fdetect*y(4)-p_estop*y(4)+X_FB*y(1)*(y(7)+y(8)+y(9))*Y_FB + p_iteng*y(7)*Y_FB + p_difeng*y(8)*Y_FB + p_difeng*y(9)*Y_FB -D_E_f;
dydt(5) = p_rstop*y(2)-exp(-y(11)/p_mdetect)*y(5)-p_estop*y(5)+(p_difeng+X_FB*y(2))*y(10)*(1-p_larva)+X_FB*y(2)*y(8)+p_iteng*y(8)-D_E_m;
dydt(6) = p_rstop*y(3)-(1-(1/exp((y(12)/p_ddetect))))*y(6)-p_estop*y(6)+(p_difeng+X_FB*y(3))*y(10)*(1-p_larva)+X_FB*y(3)*y(9)+p_iteng*y(9)-D_E_n;
%Rest
dydt(7) = p_estop*y(4) - X_FB*y(1)*y(7)*Y_FB - p_iteng*y(7)*Y_FB -D_I_f;
dydt(8) = p_estop*y(5) - X_FB*y(1)*y(8)*Y_FB - X_FB*y(2)*y(8)-p_iteng*y(8)-p_difeng*y(8)*Y_FB -D_I_m;
dydt(9) = p_estop*y(6) - X_FB*y(1)*y(9)*Y_FB - X_FB*y(3)*y(9)-p_iteng*y(9) - p_difeng*y(9)*Y_FB -D_I_n;

dydt(10) = Nb - (p_difeng+X_FB*y(3))*y(10)*(1-p_larva) - (p_difeng+X_FB*y(2))*y(10)*(1-p_larva) -D_intra;%Intra-nest worker

dydt(11) = -p_mcoll*y(11) + exp(-y(11)/p_mdetect)*y(5);%Midden construction

dydt(12) = - (1-(1/exp((y(12)/p_ddetect))))*y(6) + p_din;%Debris inside the nest dynamics

dCCSdt = Nb-D_R_f-D_R_m-D_R_n-D_E_f-D_E_m-D_E_n-D_I_f-D_I_m-D_I_n-D_intra;%Colony size's dynamics
if(y(13)>n_max*CCS && p_fdetect*y(4)*n_food-consume>n_max*dCCSdt)%%Workers have maximum nutritional energy
    dydt(13)=n_max*dCCSdt;
else
    dydt(13) = p_fdetect*y(4)*n_food - consume;%Nutritional energy's dynamics
end



