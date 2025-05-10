xh=411; yh=-76; zm=50;

x1=354; y1=102; z1=30;
x2=420; y2=79; z2=7;
x3=425; y3=108; z3=30;
x4=300; y4=106; z4=12;
x5=300; y5=163; z5=12;

% m=[479 0 zm 0;
%    x1 y1 zm 1; 
%    x1 y1 z1 1;
%    x1 y1 zm 1; 
%    xh yh zm 0;
% 
%    x2 y2 zm 1; 
%    x2 y2 z2 1;
%    x2 y2 zm 1; 
%    xh yh zm 0
% 
%    x3 y3 zm 1; 
%    x3 y3 z3 1;
%    x3 y3 zm 1; 
%    xh yh zm 0
% 
%    x4 y4 zm 1; 
%    x4 y4 z4 1;
%    x4 y4 zm 1; 
%    xh yh zm 0
% 
%    x5 y5 zm 1; 
%    x5 y5 z5 1;
%    x5 y5 zm 1; 
%    xh yh zm 0
% 
%    479 0 zm 0;
%    479 0 0 0];

m=[479 0 zm 0;
   x1 y1 zm 1; 
   x1 y1 z1 1;
   x1 y1 zm 1; 
   xh yh zm 0;
   479 0 zm 0];

d=[];
n=height(m);
for i=1:n
    k=ik_2dof(m(i,1),m(i,2),m(i,3));
    k=fix(k);
    d=[d;k];
end