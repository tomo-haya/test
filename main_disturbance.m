%Program to make Figure5, Figure6, Figure7

%% ƒtƒHƒ“ƒg
reset(groot);
set(groot,'defaultAxesFontSize',12);
set(groot,'defaultAxesFontWeight','demi'); % normal/demi/bold
set(groot,'defaultTextFontSize',12);
set(groot,'defaultTextFontWeight','demi');

clear
clc

    Disturbance = 1;%%1:Starvation(Fig. 5) 2:Midden collapse(Fig. 6) 3:Debris inflow(Fig. 7)

    
    
%% Figure size parameters
    figh = 0.10;%%Size of figure for height
    figw = 0.20;%%Size of figure for width
    dist_h = 0.32;%%Distance between figure for height
    dist_w1 = 0.27;%%Distance between figure for width
    below_ini0 = -0.081;
    left_ini1 = 0.14;%%Distance between figure for height
    dist_h2 = 0.14;%%Distance between figure for height
 
    pos11 = [left_ini1 below_ini0 + 3 * dist_h  figw figh];
    pos12 = [left_ini1 + dist_w1  below_ini0 + 3 * dist_h figw figh];
    pos13 = [left_ini1 + 2 * dist_w1  below_ini0 + 3 * dist_h figw figh];
    pos14 = [left_ini1 below_ini0 + 3 * dist_h - dist_h2 figw figh];
    pos15 = [left_ini1 + dist_w1 below_ini0 + 3 * dist_h - dist_h2 figw figh];
    pos16 = [left_ini1 + 2 * dist_w1 below_ini0 + 3 * dist_h - dist_h2 figw figh];
    pos17 = [left_ini1 below_ini0 + 2 * dist_h  figw figh];
    pos18 = [left_ini1 + dist_w1 below_ini0 + 2 * dist_h  figw figh];
    pos19 = [left_ini1 + 2 * dist_w1 below_ini0 + 2 * dist_h  figw figh];
    pos110 = [left_ini1  below_ini0 + 2 * dist_h - dist_h2 figw figh];
    pos111 = [left_ini1 + 1 * dist_w1 below_ini0 + 2 * dist_h - dist_h2 figw figh];
    pos112 = [left_ini1 + 2 * dist_w1 below_ini0 + 2 * dist_h - dist_h2  figw figh];
    pos113 = [left_ini1  below_ini0 + 1 * dist_h figw figh];
    pos114 = [left_ini1 + 1 * dist_w1 below_ini0 + 1 * dist_h figw figh];
    pos115 = [left_ini1 + 2 * dist_w1 below_ini0 + 1 * dist_h figw figh];
    pos116 = [left_ini1 below_ini0 + 1 * dist_h - dist_h2 figw figh];
    pos117 = [left_ini1 + dist_w1 below_ini0 + 1 * dist_h - dist_h2 figw figh];
    pos118 = [left_ini1 + 2 * dist_w1 below_ini0 + 1 * dist_h - dist_h2 figw figh];
    S = zeros(1,3);
    
%% Solve ODE and memorize the result
for i=1:9
   if (i == 1)
   [t,y]=solve_vdp_pertur(1,Disturbance,1);%%Solve ODE (Scenario:X(-1)Y(-1), long-term disturbance)
   ty1=t/(6.5*60*60*30*7);
   CCS1 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F1 = zeros(m,1);
   M1 = zeros(m,1);
   N1 = zeros(m,1);
   I1 = zeros(m,1);    
   CCS1_eng = zeros(m,1); 
   F1(:,1) =  y(:,4);
   M1(:,1) = y(:,5);
   N1(:,1) =  y(:,6);
   I1(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS1_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y1 = [F1(:,1), M1(:,1), N1(:,1), I1(:,1)];
   Z1 = zeros(m,4);
   end
   if (i == 2)
   [t,y]=solve_vdp_pertur(5,Disturbance,1);%%Solve ODE (Scenario:X(-1)Y(0), long-term disturbance)
   ty2=t/(6.5*60*60*30*7);
   CCS2 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F2 = zeros(m,1);
   M2 = zeros(m,1);
   N2 = zeros(m,1);
   I2 = zeros(m,1);    
   CCS2_eng = zeros(m,1); 
   F2(:,1) =  y(:,4);
   M2(:,1) = y(:,5);
   N2(:,1) =  y(:,6);
   I2(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS2_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y2 = [F2(:,1), M2(:,1), N2(:,1), I2(:,1)];
   Z2 = zeros(m,4);
   end
   if (i == 3)
   [t,y]=solve_vdp_pertur(9,Disturbance,1);%%Solve ODE (Scenario:X(-1)Y(+1), long-term disturbance)
   ty3=t/(6.5*60*60*30*7);
   CCS3 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F3 = zeros(m,1);
   M3 = zeros(m,1);
   N3 = zeros(m,1);
   I3 = zeros(m,1);    
   CCS3_eng = zeros(m,1); 
   F3(:,1) =  y(:,4);
   M3(:,1) = y(:,5);
   N3(:,1) =  y(:,6);
   I3(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS3_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y3 = [F3(:,1), M3(:,1), N3(:,1), I3(:,1)];
   Z3 = zeros(m,4);
   end
   
   if (i == 4)
   [t,y]=solve_vdp_pertur(1,Disturbance,2);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance)
   ty4=t/(6.5*60*60*30*7);
   CCS4 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F4 = zeros(m,1);
   M4 = zeros(m,1);
   N4 = zeros(m,1);
   I4 = zeros(m,1);    
   CCS4_eng = zeros(m,1); 
   F4(:,1) =  y(:,4);
   M4(:,1) = y(:,5);
   N4(:,1) =  y(:,6);
   I4(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS4_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y4 = [F4(:,1), M4(:,1), N4(:,1), I4(:,1)];
   Z4 = zeros(m,4);
   end
   if (i == 5)
   [t,y]=solve_vdp_pertur(5,Disturbance,2);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance)
   ty5=t/(6.5*60*60*30*7);
   CCS5 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F5 = zeros(m,1);
   M5 = zeros(m,1);
   N5 = zeros(m,1);
   I5 = zeros(m,1);    
   CCS5_eng = zeros(m,1); 
   F5(:,1) =  y(:,4);
   M5(:,1) = y(:,5);
   N5(:,1) =  y(:,6);
   I5(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS5_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y5 = [F5(:,1), M5(:,1), N5(:,1), I5(:,1)];
   Z5 = zeros(m,4);
   end
   if (i == 6)
   [t,y]=solve_vdp_pertur(9,Disturbance,2);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance)
   ty6=t/(6.5*60*60*30*7);
   CCS6 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F6 = zeros(m,1);
   M6 = zeros(m,1);
   N6 = zeros(m,1);
   I6 = zeros(m,1);    
   CCS6_eng = zeros(m,1); 
   F6(:,1) =  y(:,4);
   M6(:,1) = y(:,5);
   N6(:,1) =  y(:,6);
   I6(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS6_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y6 = [F6(:,1), M6(:,1), N6(:,1), I6(:,1)];
   Z6 = zeros(m,4);
   end
   
   if (i == 7)
   [t,y]=solve_vdp_pertur(1,Disturbance,3);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance before grown-up)
   ty7=t/(6.5*60*60*30*7);
   CCS7 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F7 = zeros(m,1);
   M7 = zeros(m,1);
   N7 = zeros(m,1);
   I7 = zeros(m,1);    
   CCS7_eng = zeros(m,1); 
   F7(:,1) =  y(:,4);
   M7(:,1) = y(:,5);
   N7(:,1) =  y(:,6);
   I7(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS7_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y7 = [F7(:,1), M7(:,1), N7(:,1), I7(:,1)];
   Z7 = zeros(m,4);
   end
   if (i == 8)
   [t,y]=solve_vdp_pertur(5,Disturbance,3);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance before grown-up)
   ty8=t/(6.5*60*60*30*7);
   CCS8 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F8 = zeros(m,1);
   M8 = zeros(m,1);
   N8 = zeros(m,1);
   I8 = zeros(m,1);    
   CCS8_eng = zeros(m,1); 
   F8(:,1) =  y(:,4);
   M8(:,1) = y(:,5);
   N8(:,1) =  y(:,6);
   I8(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS8_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y8 = [F8(:,1), M8(:,1), N8(:,1), I8(:,1)];
   Z8 = zeros(m,4);
   end
   if (i == 9)
   [t,y]=solve_vdp_pertur(9,Disturbance,3);%%Solve ODE (Scenario:X(-1)Y(-1), short-term disturbance before grown-up)
   ty9=t/(6.5*60*60*30*7);
   CCS9 =y(:,1)+y(:,2)+y(:,3)+y(:,4)+y(:,5)+y(:,6)+y(:,7)+y(:,8)+y(:,9)+y(:,10);
   [m,n] = size(y); 
   S(1,i) = m;
   F9 = zeros(m,1);
   M9 = zeros(m,1);
   N9 = zeros(m,1);
   I9 = zeros(m,1);    
   CCS9_eng = zeros(m,1); 
   F9(:,1) =  y(:,4);
   M9(:,1) = y(:,5);
   N9(:,1) =  y(:,6);
   I9(:,1) = y(:,10)*0.2;%0.2:p_larva
   CCS9_eng(:,1) = y(:,4) +y(:,5) + y(:,6) + y(:,10)*0.2;
   Y9 = [F9(:,1), M9(:,1), N9(:,1), I9(:,1)];
   Z9 = zeros(m,4);
   end
end

figure(1)
    set(gcf, 'Position', [1500 100 900 1200])
    %%%%%%%%%%%%%%%%%%%(a):Long-term%%%%%%%%%%%%%
    %%Colony size for Scenario Y(-1)
    subplot('Position',pos11);
    plot(ty1,CCS1,'LineWidth',3)
    axis([0,15,0,10000])  
    set(gca,'FontSize',15);
    ylabel('Colony size','FontSize',15,'Interpreter','latex')    
    title('S$_Y$(-1)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(0)
    subplot('Position',pos12);
    plot(ty2,CCS2,'LineWidth',3)
    axis([0,15,0,10000]) 
    set(gca,'FontSize',15);
    title('S$_Y$(0)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(+1)
    subplot('Position',pos13);
    plot(ty3,CCS3,'LineWidth',3)   
    axis([0,15,0,10000]) 
    set(gca,'FontSize',15);
    title('S$_Y$(+1)','FontSize',15,'Interpreter','latex');

    %%Task allocation rate of engaged workers for Scenario Y(-1)
    subplot('Position',pos14);
    for X= 1:S(1,1)
        for T = 1:4
            if (CCS1_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z1(X,T) = Y1(X,T)/CCS1_eng(X,1);
            end
           if (CCS1_eng(X,1) < 1)
               Z1(X,T) = 0;
           end
        end
    end
    area(ty1, Z1)
    set(gca,'FontSize',15);
    ylabel({'Task allocation rate','in engaged workers'},'FontSize',15,'Interpreter','latex')
    axis([0,15,0,1]) 
    
    %%Task allocation rate of engaged workers for Scenario Y(0)
    subplot('Position',pos15);
    for X= 1:S(1,2)
        for T = 1:4
            if (CCS2_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z2(X,T) = Y2(X,T)/CCS2_eng(X,1);
            end
           if (CCS2_eng(X,1) < 1)
               Z2(X,T) = 0;
           end
        end
    end
    area(ty2, Z2)
    set(gca,'FontSize',15);
    axis([0,15,0,1]) 
    text(6.,-0.4,'(a)','FontSize',20, 'FontName','Times new Roman','Interpreter','latex')
    
    %%Task allocation rate of engaged workers for Scenario Y(+1)
    subplot('Position',pos16);
    for X= 1:S(1,3)
        for T = 1:4
            if (CCS3_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z3(X,T) = Y3(X,T)/CCS3_eng(X,1);
            end
           if (CCS3_eng(X,1) < 1)
               Z3(X,T) = 0;
           end
        end
    end
    area(ty3, Z3)
    set(gca,'FontSize',15);
    axis([0,15,0,1])  
    
     %%%%%%%%%%%%%%%%%%%(b) Short-term%%%%%%%%%%%%%%%%%
     %%Colony size for Scenario Y(-1)
    subplot('Position',pos17);
    plot(ty4,CCS4,'LineWidth',3)
    axis([4.9,6.5,0,10000])
    set(gca,'FontSize',15);
    ylabel('Colony size','FontSize',15,'Interpreter','latex')    
    title('S$_Y$(-1)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(0)
    subplot('Position',pos18);
    plot(ty5,CCS5,'LineWidth',3)
    axis([4.9,6.5,0,10000])
    set(gca,'FontSize',15);
    title('S$_Y$(0)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(+1)
    subplot('Position',pos19);
    plot(ty6,CCS6,'LineWidth',3)   
    axis([4.9,6.5,0,10000])
    set(gca,'FontSize',15);
    title('S$_Y$(+1)','FontSize',15,'Interpreter','latex');
    
    %%Task allocation rate of engaged workers for Scenario Y(-1)
    subplot('Position',pos110);
    for X= 1:S(1,4)
        for T = 1:4
            if (CCS4_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z4(X,T) = Y4(X,T)/CCS4_eng(X,1);
            end
           if (CCS4_eng(X,1) < 1)
               Z4(X,T) = 0;
           end
        end
    end
    area(ty4, Z4)
    set(gca,'FontSize',15);
    ylabel({'Task allocation rate','in engaged workers'},'FontSize',15,'Interpreter','latex')
    axis([4.9,6.5,0,1])
  
    %%Task allocation rate of engaged workers for Scenario Y(0)
    subplot('Position',pos111);
    for X= 1:S(1,5)
        for T = 1:4
            if (CCS5_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z5(X,T) = Y5(X,T)/CCS5_eng(X,1);
            end
           if (CCS5_eng(X,1) < 1)
               Z5(X,T) = 0;
           end
        end
    end
    area(ty5, Z5)
    set(gca,'FontSize',15);
    axis([4.9,6.5,0,1])
    text(5.6,-0.4,'(b)','FontSize',20, 'FontName','Times new Roman','Interpreter','latex')
    
    %%Task allocation rate of engaged workers for Scenario Y(+1)
    subplot('Position',pos112);
    for X= 1:S(1,6)
        for T = 1:4
            if (CCS6_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z6(X,T) = Y6(X,T)/CCS6_eng(X,1);
            end
           if (CCS6_eng(X,1) < 1)
               Z6(X,T) = 0;
           end
        end
    end
    area(ty6, Z6)
    set(gca,'FontSize',15);
    axis([4.9,6.5,0,1])
    
    
    %%%%%%%%%%%%%%%%%%%(c):Short-term before grown-up%%%%%%%%%%%%%%%%%
    %%Colony size for Scenario Y(-1)
    subplot('Position',pos113);
    plot(ty7,CCS7,'LineWidth',3)
    axis([0/7,5/7,0,100]) 
    set(gca,'FontSize',15);
    ylabel('Colony size','FontSize',15,'Interpreter','latex')    
    title('S$_Y$(-1)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(0)
    subplot('Position',pos114);
    plot(ty8,CCS8,'LineWidth',3)
    axis([0/7,5/7,0,100])
    set(gca,'FontSize',15);
    title('S$_Y$(0)','FontSize',15,'Interpreter','latex');
    
    %%Colony size for Scenario Y(+1)
    subplot('Position',pos115);
    plot(ty9,CCS9,'LineWidth',3)   
    axis([0/7,5/7,0,100])
    set(gca,'FontSize',15);
    title('S$_Y$(+1)','FontSize',15,'Interpreter','latex');
    
    %%Task allocation rate of engaged workers for Scenario Y(-1)
    subplot('Position',pos116);
    for X= 1:S(1,7)
        for T = 1:4
            if (CCS7_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z7(X,T) = Y7(X,T)/CCS7_eng(X,1);
            end
           if (CCS7_eng(X,1) < 1)
               Z7(X,T) = 0;
           end
        end
    end
    area(ty7, Z7)
    set(gca,'FontSize',15);
    ylabel({'Task allocation rate','in engaged workers'},'FontSize',15,'Interpreter','latex')
    axis([0/7,5/7,0,1])
    
    %%Task allocation rate of engaged workers for Scenario Y(0)
    subplot('Position',pos117);
    for X= 1:S(1,8)
        for T = 1:4
            if (CCS8_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z8(X,T) = Y8(X,T)/CCS8_eng(X,1);
            end
           if (CCS8_eng(X,1) < 1)
               Z8(X,T) = 0;
           end
        end
    end
    area(ty8, Z8)
    set(gca,'FontSize',15);
    axis([0/7,5/7,0,1])
    text(0.286,-0.6,'(c)','FontSize',20, 'FontName','Times new Roman','Interpreter','latex')
    text(0.2,-0.4,'t[Year]','FontSize',20, 'FontName','Times new Roman','Interpreter','latex')
    
    %%Task allocation rate of engaged workers for Scenario Y(+1)
    subplot('Position',pos118);
    for X= 1:S(1,9)
        for T = 1:4
            if (CCS9_eng(X,1) > 1) %%If CCS is extinct, the task allocation is not plotted 
                Z9(X,T) = Y9(X,T)/CCS9_eng(X,1);
            end
           if (CCS9_eng(X,1) < 1)
               Z9(X,T) = 0;
           end
        end
    end
    area(ty9, Z9)
    set(gca,'FontSize',15);
    axis([0/7,5/7,0,1])
    l=legend({'Foraging','Midden Work','Nest maintenance','Intra-nest tasks'},'Position',[0.45 -0.085 0.1 0.2],'Orientation','horizontal');
    set(l,'FontSize',15) 
     
     
     