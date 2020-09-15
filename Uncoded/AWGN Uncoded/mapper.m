
function [out_simbol,code_bit,code_simbol]=mapper(bit,mode)
out_simbol=[];
switch mode
    case 'bpsk'
        % Mapping bit input
        for i=1:length(bit)
            out_simbol(end+1,1)=(1-2*bit(i));
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:1
            code_bit(isimbol+1,:)=de2bi(isimbol);
            code_simbol(isimbol+1,1)=(1-2*isimbol);
        end
        
    case 'c-bpsk'
        % Mapping bit input
        for i=1:length(bit)
            out_simbol(end+1,1)=(1/sqrt(2))*((1-2*bit(i))+1i*(1-2*bit(i)));
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:1
            code_bit(isimbol+1,:)=de2bi(isimbol);
            code_simbol(isimbol+1,1)=(1/sqrt(2))*((1-2*isimbol)+1i*(1-2*isimbol));
        end
        
    case 'qpsk'
        % Mapping bit input
        for i=1:2:length(bit)
            out_simbol(end+1,1)=((1-2*(bit(i)))+sqrt(-1)*(1-2*bit(i+1)))/sqrt(2); %qpsk
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:3
            code_bit(isimbol+1,:)=de2bi(isimbol,2);
            code_simbol(isimbol+1,1)=((1-2*(code_bit(isimbol+1,1)))+sqrt(-1)*(1-2*code_bit(isimbol+1,2)))/sqrt(2); %qpsk
        end
        
    case '16qam'
        % Mapping bit input
        for i=1:4:length(bit)
            out_simbol(end+1,1)=((1-2*(bit(i)))*(2-(1-2*(bit(i+2))))+...
                sqrt(-1)*(1-2*(bit(i+1)))*(2-(1-2*(bit(i+3)))))/sqrt(10); %16qam
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:15
            code_bit(isimbol+1,:)=de2bi(isimbol,4);
            code_simbol(isimbol+1,1)=((1-2*(code_bit(isimbol+1,1)))*(2-(1-2*(code_bit(isimbol+1,3))))+...
                sqrt(-1)*(1-2*(code_bit(isimbol+1,2)))*(2-(1-2*(code_bit(isimbol+1,4)))))/sqrt(10);
        end
        
    case '64qam'
       % Mapping bit input

        for i=1:6:length(bit)
            out_simbol(end+1,1)=((1-2*(bit(i)))*(4-(1-2*(bit(i+2)))*(2-(1-2*(bit(i+4)))))+...
                sqrt(-1)*(1-2*(bit(i+1)))*(4-(1-2*(bit(i+3)))*(2-(1-2*(bit(i+5))))))/sqrt(42); %64qam
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:63
            code_bit(isimbol+1,:)=de2bi(isimbol,6);
            code_simbol(isimbol+1,1)=((1-2*(code_bit(isimbol+1,1)))*(4-(1-2*(code_bit(isimbol+1,3)))*(2-(1-2*(code_bit(isimbol+1,5)))))+...
                sqrt(-1)*(1-2*(code_bit(isimbol+1,2)))*(4-(1-2*(code_bit(isimbol+1,4)))*(2-(1-2*(code_bit(isimbol+1,6))))))/sqrt(42);
        end
       
        
    case '256qam'
        % Mapping bit input
        for i=1:8:length(bit)
            out_simbol(end+1,1)= ((1-2*bit(i))*(8-(1-2*bit(i+2))*(4-(1-2*bit(i+4))*(2-(1-2*bit(i+6)))))+...
                sqrt(-1)*(1-2*bit(i+1))*(8-(1-2*bit(i+3))*(4-(1-2*bit(i+5))*(2-(1-2*bit(i+7))))))/sqrt(170); %256
        end
        % Mapping buku
        code_bit=[];
        code_simbol=[];
        for isimbol=0:255
            code_bit(isimbol+1,:)=de2bi(isimbol,8, 'left-msb');
            code_simbol(isimbol+1,1)=((1-2*code_bit(isimbol+1,1))*(8-(1-2*code_bit(isimbol+1,3))*(4-(1-2*code_bit(isimbol+1,5))*(2-(1-2*code_bit(isimbol+1, 7)))))+...
                sqrt(-1)*(1-2*code_bit(isimbol+1, 2))*(8-(1-2*code_bit(isimbol+1,4))*(4-(1-2*code_bit(isimbol+1,6))*(2-(1-2*code_bit(isimbol+1,8))))))/sqrt(170);
        end
        
             
 
end
