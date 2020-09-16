function I=j_function(sigma)
a_j1= -0.0421061;
b_j1=0.209252;
c_j1= -0.00640081;
a_j2=0.00181491;
b_j2=-0.142675;
c_j2=-0.0822054;
d_j2=0.0549608;
sigma_tp= 1.6363;
if sigma >=0 && sigma <=sigma_tp 
    I= a_j1 *sigma^3+ b_j1*sigma^2+c_j1*sigma;
elseif sigma>sigma_tp && sigma<10
    I= 1- exp(a_j2*sigma^3+ b_j2*sigma^2+c_j2*sigma+d_j2);
else
        I=1;
end