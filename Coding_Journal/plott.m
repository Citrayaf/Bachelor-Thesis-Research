%AWGN
%uncoded
% SNR=[-6 -5 -4 -3 -2 -1 0 1 2 3 4 5];
% ber=[0.2406875 0.210895833 0.1865 0.157479167 0.130202381 0.103235714 0.079130952 0.056702381 0.037459524 0.022959524 0.01237619 0.005983333 ];
% % DS
% SNR=[-6 -5 -4 -3 -2 -1 0 1 ];
% ber=[0.225833333 0.1745 0.132666667 0.06125 0.016666667 0.000966667 6.88889E-05 5.88889E-06];
% % Urut
% SNR=[-6 -5 -4 -3 -2 -1 0 1 2];
% ber=[0.224833333 0.170583333 0.1305 0.06075 0.027916667 0.006475 0.001533333 0.000208333 4.16667E-06];
% % Acak
% SNR=[-6 -5 -4 -3 -2 -1 0 1];
% ber=[0.216916667 0.183416667 0.122833333 0.05675 0.009833333 0.000416667 1.76667E-05 0.0000005];
% 
% semilogy(SNR,ber, '*-', 'linewidth',1);
% 
% 
% Figure1=figure(1);
% FigW=6;
% FigH=5.6;
% set(Figure1,'defaulttextinterpreter','latex',...
%     'PaperUnits','inches','Papersize',[FigW,FigH],...
%     'Paperposition',[0,0,FigW,FigH],'Units','Inches',...
%     'Position',[0,0,FigW,FigH])
% set(gca,...
%     'FontSize',10,...
%     'FontName','Arial');
% 
% grid on;
% 
% % Create xlabel
% xlabel({'SNR (dB)'});
% ylabel({'BER'});

%Singlepath
%uncoded
% SNR=[0 5 10 15 20 25 30];
% ber=[0.150854167 0.065654167 0.023548333 0.007516667 0.002370139 0.000761742 0.000242262 ];

% %DS
% ber=[0.094933333 0.03585 0.011802222 0.003417778 0.00122 0.00044 0.000109524 ];
% 
% %urut
% ber=[0.09595 0.0368 0.012157778 0.003723333 0.001255556 0.000485 0.000120238 ];
% 
% %Acak
% ber=[0.084633333 0.028559524 0.00918 0.002814444 0.000942222 0.000314444 8.80952E-05];
% 
% semilogy(SNR,ber, '*-', 'linewidth',1);

% SiamMask
Acc1 = 0.619;
Robustness1 = 0.336;
EAO1 = 0.3644;
% ECO
Acc2 = 0.484;
Robustness2 = 0.276;
EAO2 = 0.28;

% CCOT:
Acc3 = 0.494;
Robustness3 = 0.318;
EAO3 = 0.267;

% MD Net:
Acc4 = 0.541;
Robustness4 = 0.337;
EAO4 = 0.257;

% DeepSRDCF
Acc5 = 0.528;
Robustness5 = 0.326;
EAO5 = 0.276;

% SAMF
Acc6 = 0.502;
Robustness6 = 0.438;
EOA6 =  0.227;

% scatter(1,EAO1);
% scatter(2,EAO2);
% scatter(3,EAO3);
% scatter(4,EAO4);
% scatter(5,EAO5);
scatter(6,EOA6);



% Figure1=figure(1);
% FigW=6;
% FigH=5.6;
% set(Figure1,'defaulttextinterpreter','latex',...
%     'PaperUnits','inches','Papersize',[FigW,FigH],...
%     'Paperposition',[0,0,FigW,FigH],'Units','Inches',...
%     'Position',[0,0,FigW,FigH])
% set(gca,...
%     'FontSize',10,...
%     'FontName','Arial');
% 
% grid on;
% 
% % Create xlabel
% % xlabel({'Robustness'});
% % ylabel({'Accuracy'});
% 
% xlabel({''});
% ylabel({'EAO'});
