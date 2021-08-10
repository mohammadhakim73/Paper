function [mpc,slack]=defining_mpc(NB,Loads)
    mpc = loadcase('case'+NB);
    NB = str2num(NB);

    slack = find(mpc.bus(:,2)==3);
    
    %% Set Constrants for Bus State Variables
%     mpc.bus(:,12)=1.05*ones(NB,1);
%     mpc.bus(:,13)=0.95*ones(NB,1);
    
    mpc.branch(8:10,9) = 1; % setting all transformers tap to 1
    
    %% Changing Loads
%     mpc.bus(:,3:4) = mpc.bus(:,3:4) + mpc.bus(:,3:4).*Load_coef;
    mpc.bus(:,3:4) = Loads;

    clc;

end