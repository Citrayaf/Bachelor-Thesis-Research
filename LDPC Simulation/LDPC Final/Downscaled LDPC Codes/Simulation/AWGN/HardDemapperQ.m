function [Out_Demapper]= HardDemapperQ(y)


y = y*sqrt(2);
real_out_simbol = real(y);
imaginer_out_simbol = imag(y);

Out_Demapper= [];

for i = 1: length (y)
    out_demapper= [];    
    %Baris ke-1
    if (real_out_simbol (i)>=0) && (real_out_simbol(i)<10)
        if (imaginer_out_simbol(i)<=10) && (imaginer_out_simbol(i)>0)
            out_demapper(end+1,:)=[0 0];
        else
            out_demapper(end+1,:)=[0 1];
        end
    end
    
    if (real_out_simbol (i)>=-10) && (real_out_simbol(i)<0)
         if (imaginer_out_simbol(i)<=10) && (imaginer_out_simbol(i)>0)
            out_demapper(end+1,:)=[1 0];
         else
             out_demapper(end+1,:)=[1 1];
         end
    end
     Out_Demapper = [Out_Demapper out_demapper];
end
end
