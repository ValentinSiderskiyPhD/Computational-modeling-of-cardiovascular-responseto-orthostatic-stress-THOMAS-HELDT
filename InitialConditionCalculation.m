%From Davis, 1991

%Initial pressures are estimated by a linear algebraic solution devloped
%by Sah.  A DC circuit is solved under the assumption that all sate
%variables are constant. Each ventricle is treated twice for the purpose of
%the DC approximation: the diastolic capacitance is used for the
%ventricular inflow calculatin, and the systolic capacitance is used in the
% outflow calculation. A system of X linear equations, depicting
% conservation of flow rate, in X unknows is solved using a modified Gauss-
% Jordan reduction to obtain the X-2 initial pressures for a specicfice set
% of parameters.


%% Assumption that the same volume of blood goes from left to right ventricle
% calculated in the units of systolic to diastolic beats.

T_tot = 1;

%Bazett formula
T_sys = 0.3*sqrt(T_tot);
T_dia = T_tot-T_sys;


syms P_lv_dia P_lv_sys P_rv_dia P_rv_sys  P_up P_pv P_kid P_sp P_ll ...
    P_pa P_sup P_inf P_ab P_a P_v

R_a = 0.011;
R_v = R_ro; %TODO verifty
C_v = 100; %TODO verifty
V_tot = 6000;
V_tot_init = 2000; %TODO verify 
P_th = -4;
eqn1 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == C_rv_dia*(P_rv_dia-P_th)-C_rv_sys*(P_rv_sys-P_th);
eqn2 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_sys*(P_lv_sys-P_a)/R_lo;
eqn3 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_tot*(P_a-P_v)/R_a;
eqn4 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_dia*(P_v-P_rv_dia)/R_v;
eqn5 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_sys*(P_rv_sys-P_pa)/R_ro;
eqn6 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_tot*( P_pa-P_pv )/R_p;
eqn7 = C_lv_dia*( P_lv_dia -P_th) - C_lv_sys*(P_lv_sys-P_th) == T_dia*(P_pv-P_lv_dia)/R_pv;
eqn8 = V_tot-V_tot_init == C_lv_dia*(P_lv_dia-P_th)+C_a*(P_a-P_th/3)+C_v*P_v + C_rv_sys*(P_rv_sys-P_th)+C_pa*(P_pa-P_th)+C_pv*(P_pv-P_th);

sol = solve([eqn1, eqn2, eqn3, eqn4, eqn5, eqn6, eqn7, eqn8],[ P_lv_dia, P_lv_sys, P_rv_dia,P_rv_sys, P_a,P_v,P_pa,P_pv ]);

P_lv_init = double(sol.P_lv_dia);
P_a_init = double(sol.P_a);
P_rv_init = double(sol.P_rv_dia);
P_pa_init = double(sol.P_pa);
P_pv_init = double(sol.P_pv);

%to be calculated
P_up_init = 30;
P_kid_init = 30;
P_sp_init = 30;
P_ll_init = 30;
P_sup_init = 30;
P_inf_init = 30;
P_ab_init = 30;
