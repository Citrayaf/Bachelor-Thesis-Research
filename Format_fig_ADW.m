Figure1=figure(1); 
FigW=6; 
FigH=5.6; 
set(Figure1,'defaulttextinterpreter','latex',... 
    'PaperUnits','inches','Papersize',[FigW,FigH],... 
    'Paperposition',[0,0,FigW,FigH],'Units','Inches',... 
    'Position',[0,0,FigW,FigH]) 
set(gca,... 
    'FontSize',10,... 
    'FontName','Arial');       
ylabel({'BER'});

% Create xlabel
xlabel({'SNR (dB)'}); 
hold on

%Dock nya dicentang