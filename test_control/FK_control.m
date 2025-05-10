Theta1=int2str(inTheta1);
Theta2=int2str(inTheta2);
Theta3=int2str(inTheta3);
str=append(Theta1,';',Theta2,';',Theta3);
writeline(a1,str);
b=0;
while b==0
    c=readline(a1);
    b=str2double(c);
end