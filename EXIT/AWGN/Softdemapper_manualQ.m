function [Out_Demapper]= Softdemapper_manualQ(y, sigma)

Out_Demapper= [];

for i = 1 : length (y)
    lci= [];    
    
    reall = (2/sigma^2)*real(y(i));
    
    imagi = (2/sigma^2)*imag(y(i));
    
    lci = [reall imagi];
    
    Out_Demapper = [Out_Demapper lci];
end

end
