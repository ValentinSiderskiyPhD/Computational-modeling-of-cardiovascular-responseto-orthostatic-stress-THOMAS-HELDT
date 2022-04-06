%step size range
stepsize_min = 6.1e-4;
stepsize_max = 0.01; % seconds

%solver Runge-Kutta

% Resistance values
R_lo    = 0.006;% left ventricular overflow Ref 23 
R_up1   = 3.9;  % Est.  upper body 1
R_kid1  = 4.1;  % Est.  kidney
R_sp1   = 3.0;  % Est.  splanchnic
R_ll1   = 3.6;  % Est.  lower limbs
R_up2   = 0.23; % 3     upper body 2
R_kid2  = 0.3;  % Est.  kidney
R_sp2   = 0.18; % 3     splanchnic
R_ll2   = 0.3;  % 3     lower limbs
R_sup   = 0.06; % 3     superior vena cava
R_ab    = 0.01; % Est.  abdominal vena cava
R_inf   = 3;    % Est.  inferior vena cava
R_ro    = 0.003;% 23    right ventricular outflow
R_p     = 0.08; % 53    pulmonary
R_pv    = 0.01; % 23    pulmonary vain

%Volume (ZPFV=zero pressure filling volume),  and complince values, 

%Right ventricle,
C_rv_sys    = 1.2;  %ml/mmHg Ref 20
C_rv_dia   = 20;
ZPFV_rv     = 50;   %ml 
E_rv_sys = 1/C_rv_sys;
E_rv_dia = 1/C_rv_dia;

%Pulmonary arteries
C_pa        = 4.3;  %ml/mmHg Ref 3 
ZPFV_pa     = 90;   %ml Ref 21

%Pulmonary veins
ZPFV_pv     = 490;  %ml Ref 3
C_pv        = 8.4;  % Ref 3

%Left ventricle
ZPFV_lv     = 50;   %ml Ref Est
C_lv_sys    = 0.4;  %ml/mmHg Ref 20
C_lv_dia   = 20;
E_lv_sys = 1/C_lv_sys;
E_lv_dia = 1/C_lv_dia;

%Systemic arteries
ZPFV_a     = 715;  %ml Ref 20
C_a        = 2.0;  %ml/mmHg Ref 20

%Systemic Veins
%%Upper Body
ZPFV_up  = 650;  %ml Ref 3
C_up     = 8;    %ml/mmHg Ref Est. Upper body
%%Kidney
ZPFV_kid   = 150;  % ml Ref Est.
C_kid      = 15;   %ml/mmHg Ref Est.
%%Splanchnic
ZPFV_sp   = 1300; % ml Ref 75
C_sp      = 55;   %ml/mmHg Ref 75
%%Lower Limbs
ZPFV_ll  = 350;  %ml Ref 3
C_ll     = 19;   %ml/mmHg Ref 34

%Abdominal Veins
ZPFV_ab     = 250;  %ml Ref 19
C_ab        = 25;   %ml/mmHg Ref 19

%Inferior vena cava
ZPFV_inf    = 75;   %ml Ref 19
C_inf       = 2;    %ml/mmHg Ref 19

%Superior vena cava
ZPFV_sup    = 10;   %ml Ref 19
C_sup       = 15;   %ml/mmHg Ref 19

%Gain values of the cardiopulumanry reflex
G_R_p_ub    = -0.06;%PRU/mmHg sympathetic Ref 54 
G_R_p_k     = -0.06;%PRU/mmHg sympathetic Ref 54
G_R_p_s     = -0.06;%PRU/mmHg sympathetic Ref 54
G_R_p_ll    = -0.06;%PRU/mmHg sympathetic Ref 54
G_C_ub      = 13.5; %PRU/mmHg sympathetic Ref 54
G_C_k       = 2.7;  %PRU/mmHg sympathetic Ref 54
G_C_s       = 54.0; %PRU/mmHg sympathetic Ref 54
G_C_ll      = 20.0; %PRU/mmHg sympathetic Ref 54

%Gain values of the arterial baroreflex
G_RR_sym    = 9.0;  %ms/mmHg, RR interval sympathetic, Ref 22
G_RR_par    = 9.0;  %ms/mmHg, RR interval parasympathetic, Ref 22

G_LV_es     = -0.007;   %ml/mmHg Contractility,Left Ventricle end-systolic, sympathetic Ref. 20
G_RV_es     = -0.027;   %ml/mmHg Contractility,Right Venticle end-systolic, sympathetic Ref. 20
G_R_ub      = -0.01;    %PRU Perifpheral Resistance, Upper Body, sympathetic Ref. 20
G_R_k       = -0.01;    %PRU Perifpheral Resistance, Kidney, sympathtic Ref. 20
G_R_s       = -0.01;    %PRU Perifpheral Resistance, Splanchnic, sympathetic Ref. 20
G_R_ll      = -0.01;    %PRU Perifpheral Resistance, Lower Limbs, sympathetic Ref. 20

G_C_ub      = 5.3;      %PRU Perifpheral Resistance, Upper Body, sympathetic Ref. 63
G_C_k       = 1.3;      %PRU Perifpheral Resistance, Kidney, sympathtic Ref. 63
G_C_s       = 13.3;     %PRU Perifpheral Resistance, Splanchnic, sympathetic Ref. 63
G_C_ll      = 6.7;      %PRU Perifpheral Resistance, Lower Limbs, sympathetic Ref. 63


%Respiration
RR = 12; %breaths per minute. 
freq = 2*pi*RR/60;
P_th_high = -4;
P_th_low  = -6;
P_th_bias = (P_th_high+P_th_low)/2;


P_max1 = 40.0; %mmHg Ref. 27 
P_max2 = 7.00; %mmHg Ref. 27
P_max3 = 5.0;  %mmHg Ref. 27

% Based on Davis, 1991 
%TODO

%From 2004 thesis Table 4.1

P_lv_init = 8; %mmHg
P_up_init =77; % radial artery
P_pv_init = 9; %pulmnary vein
P_kid_init = 77;
P_sp_init = 77;
P_ll_init = 77;
P_pa_init = 10;
P_rv_init = 1;
P_sup_init = 9;
P_inf_init = 9;
 P_ab_init = 9;
P_a_init = 80; %mmHg
%% Equations
%d(Pa)/dt = (1/C_a)[ (Pa-Piv)/R_lo + (Pup-Pa)/Rup1 + (Pkid-Pa)/Rkid1 + (Psp-Pa)/Rsp1 + (Pll-Pa)/Rll1 ] + d(Pth)/dt

%P_th = sine 12 breaths per minute, range -4 to -6

%d(P_lv)/dt = 1/(C_lv)[ (P_a-P_lv)/R_lo + (P_pv-P_lv)/R_pv + (P_th-P_lv)*d(C_lv)/dt ] + d/dt(Pth)/dt

%d(P_lp)/dt = 1/(C_pv) [ (P_lv - P_pv)/R_pv + (R_pa-Ppv)/R_p] + d(Pth)/dt

%% Referances

%3.Beneken JEW and DeWitt B.A physical approach to hemody-namic aspects of 
% the human cardiovascular system. In:PhysicalBases of Circulatory Transport:
% Regulation and Exchange, editedby Guyton AC and Reeve EB. Philadelphia, PA:
% Saunders, 1966,p. 1–45

%19.Croston RC, Rummel JA, and Kay FJ.Computer model ofcardiovascular control
%system response to exercise.J Dyn SystMeas Contr, 1973, p. 301–307.

%20.Davis TL.Teaching Physiology Through Interactive Simulation of Hemodynamics(master’s thesis).
%Cambridge, MA: Massachu-setts Institute of Technology, 1991.

%21.Davis TL and Mark RG.Teaching physiology through simula-tion of hemodynamics.
%Comput Cardiol17: 649–652, 1990.

% 23.Defares JG, Osborne JJ, and Hara HH.Theoretical synthe-sis of the cardio
% vascular system. Study I: the controlled system.Acta Physiol Pharm Neerl12:
% 189–265, 1963.

%34.Henry JP, Slaughter OL, and Greiner T.A medical massagesuit for continuous
%wear.Angiology6: 482–494, 1955.

%75.Ursino M.Interaction between carotid baroregulation and the pulsating  heart:
%a  mathematical  model.J  Appl  Physiol275:H1733–H1747, 1998

