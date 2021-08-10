clc;
close all;

% clear
% n = load('.\Data60sec.csv');
Vm = n(:,2:15);
Va = n(:,16:29);

times.times = n(:,1);
times.interval = 0.1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times.frequency = 1/times.interval;

%% Seperating Data in 5 min intervals
interval = times.interval; % interval of sampled data
State_Estimation_Duration = 300; % 5 min
Points_in_Window = State_Estimation_Duration/interval;

%% Making Samples
sample_index = randperm(numel(times.times)-(Points_in_Window-1),100);
samples = {};
for i=1:numel(sample_index)
    samples{i,1} = times.times(sample_index(i):sample_index(i)+4);
end

%% Defining Attack Start and Attack Duration
for i=1:numel(sample_index)
    Attack_Start = randperm(Points_in_Window,1);
    Attack_Duration = randperm(Points_in_Window/10,1)*10;
    while (Attack_Duration > Points_in_Window-Attack_Start)
        Attack_Duration = randperm(Points_in_Window/10,1)*10;
    end
    Attack_Times.Attack_Start(i,1)=Attack_Start;
    Attack_Times.Attack_Duration(i,1)=Attack_Duration;
end
clear Attack_Start Attack_Duration

%% Attack Injection
% In this section we will use MATPOWER Data models
AttackedBus = 10;
NeiAttackedBus = [9,11];










% 
% % willNaN = randperm(2868,50);A(willNaN)=NaN; % packet fail
% % A = fillmissing(A,'linear'); % data recovery after packet fail
% 
% 
% time = 500:8000;
% Bus4 = n(time,5)+randn(numel(time),1)/1000;
% Bus7 = n(time,8)+randn(numel(time),1)/1000;
% Bus9 = n(time,10)+randn(numel(time),1)/1000;
% Bus10 = n(time,11)+randn(numel(time),1)/1000;
% Bus14 = n(time,15)+randn(numel(time),1)/1000;
% 
% % Bus9(1000:1500) = Bus9(1000:1500)+ones(501,1)/10;
% Bus10(1000:1500) = Bus10(1000:1500)+randn(501,1)/10;
% 
% 
% fs = 1/60;
% [wcoh1,wcs1,f1] = wcoherence(Bus9,Bus4,fs);
% [wcoh2,wcs2,f2] = wcoherence(Bus9,Bus7,fs);
% [wcoh3,wcs3,f3] = wcoherence(Bus9,Bus10,fs);
% [wcoh4,wcs4,f4] = wcoherence(Bus9,Bus14,fs);
% 
% % ylim([1 3])
% %% Cases
% 
% wcs1 = abs(wcs1);
% wcs2 = abs(wcs2);
% wcs3 = abs(wcs3);
% wcs4 = abs(wcs4);
% wcoh1 = abs(wcoh1);
% wcoh2 = abs(wcoh2);
% wcoh3 = abs(wcoh3);
% wcoh4 = abs(wcoh4);
% 
% [U1,S1,V1] = svd(wcs1);
% [U2,S2,V2] = svd(wcs2);
% [U3,S3,V3] = svd(wcs3);
% [U4,S4,V4] = svd(wcs4);
% [U5,S5,V5] = svd(wcoh1);
% [U6,S6,V6] = svd(wcoh2);
% [U7,S7,V7] = svd(wcoh3);
% [U8,S8,V8] = svd(wcoh4);
% 
% DDD1 = [];
% DDD2 = [];
% DDD3 = [];
% DDD4 = [];
% DDD5 = [];
% DDD6 = [];
% DDD7 = [];
% DDD8 = [];
% for i=1:121
%    DDD1 = [DDD1;S1(i,i)];
%    DDD2 = [DDD2;S2(i,i)];
%    DDD3 = [DDD3;S3(i,i)];
%    DDD4 = [DDD4;S4(i,i)];
%    DDD5 = [DDD5;S5(i,i)];
%    DDD6 = [DDD6;S6(i,i)];
%    DDD7 = [DDD7;S7(i,i)];
%    DDD8 = [DDD8;S8(i,i)]; 
% end
% 
% %% normalizing
% DDD1 = DDD1/max(DDD1);
% DDD2 = DDD2/max(DDD2);
% DDD3 = DDD3/max(DDD3);
% DDD4 = DDD4/max(DDD4);
% DDD5 = DDD5/max(DDD5);
% DDD6 = DDD6/max(DDD6);
% DDD7 = DDD7/max(DDD7);
% DDD8 = DDD8/max(DDD8);
% %% Log_transformation
% % c = 1;
% % DDD1 = log_trans(DDD1,c);
% % DDD2 = log_trans(DDD2,c);
% % DDD3 = log_trans(DDD3,c);
% % DDD4 = log_trans(DDD4,c);
% 
% %% Power_transformation
% % c = 1;
% % landa = 0.3;
% % DDD1 = power_trans(DDD1,c,landa);
% % DDD2 = power_trans(DDD2,c,landa);
% % DDD3 = power_trans(DDD3,c,landa);
% % DDD4 = power_trans(DDD4,c,landa);
% 
% [PPP1,pro1] = Shanon_Entropy(DDD1);
% [PPP2,pro2] = Shanon_Entropy(DDD2);
% [PPP3,pro3] = Shanon_Entropy(DDD3);
% [PPP4,pro4] = Shanon_Entropy(DDD4);
% [PPP5,pro5] = Shanon_Entropy(DDD5);
% [PPP6,pro6] = Shanon_Entropy(DDD6);
% [PPP7,pro7] = Shanon_Entropy(DDD7);
% [PPP8,pro8] = Shanon_Entropy(DDD8);
% [PPP1,PPP2,PPP3,PPP4,PPP5,PPP6,PPP7,PPP8]
% 
% figure(3);
% plot(DDD1);hold on; plot(DDD2);hold on;plot(DDD3);hold on; plot(DDD4);
% legend('wcs-9,4','wcs-9,7','wcs-9,10','wcs-9,14')
% figure(4);
% plot(DDD5);hold on;plot(DDD6);hold on;plot(DDD7);hold on; plot(DDD8);
% legend('wcoh-9,4','wcoh-9,7','wcoh-9,10','wcoh-9,14')
% 
% figure(5);
% plot(pro1);hold on;plot(pro2);hold on;plot(pro3);hold on;plot(pro4);
% legend('wcs-9,4','wcs-9,7','wcs-9,10','wcs-9,14')
% figure(6);
% plot(pro5);hold on;plot(pro6);hold on;plot(pro7);hold on;plot(pro8);
% legend('wcoh-9,4','wcoh-9,7','wcoh-9,10','wcoh-9,14')
% 
% % function out = log_trans(inp,c)
% %     out = c*log10(1+inp);
% % end
% % 
% % function out = power_trans(inp,c,landa)
% %     out = c*(inp).^(landa);
% % end
% 
% function [out,Probability] = Shanon_Entropy(inp)
%     summation = sum(inp);
%     out = inp/summation;
%     Probability = -1*out.*log(out);
%     out = 10 * sum(Probability);
% end
