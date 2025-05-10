% a1=serialport("COM4",9600)
% a2=serialport("COM3",9600)

% Box location
zm=20;
xb=441; yb=-38; zb=0;
xr=403; yr=-38; zr=0;
xy=365; yy=-38; zy=0;
xu=327; yu=-38; zu=0;

xh=[];

for q=1:detected
    if (objects_position_mm(q,4) == 1)
        xh(q,1) = xb; xh(q,2) = yb;
    elseif (objects_position_mm(q,4) == 2)
        xh(q,1) = xr; xh(q,2) = yr;
    elseif (objects_position_mm(q,4) == 3)centroids
        xh(q,1) = xy; xh(q,2) = yy;
    elseif (objects_position_mm(q,4) == 4)
        xh(q,1) = xu; xh(q,2) = yu;
    end
end

if (detected == 1)
    x1=objects_position_mm(1,2); y1=objects_position_mm(1,3); z1=0;
    m=[479 0 zm 0;
        x1 y1 zm 1;
        x1 y1 z1 1;
        x1 y1 zm 1;
        xh(1,1) xh(1,2) zm 0;

        479 0 zm 0;
        479 0 0 0];
elseif (detected == 2)
    x1=objects_position_mm(1,2); y1=objects_position_mm(1,3); z1=0;
    x2=objects_position_mm(2,2); y2=objects_position_mm(2,3); z2=0;

    m=[479 0 zm 0;
        x1 y1 zm 1;
        x1 y1 z1 1;
        x1 y1 zm 1;
        xh(1,1) xh(1,2) zm 0;

        x2 y2 zm 1;
        x2 y2 z2 1;
        x2 y2 zm 1;
        xh(2,1) xh(2,2) zm 0

        479 0 zm 0;
        479 0 0 0];
elseif (detected == 3)
    x1=objects_position_mm(1,2); y1=objects_position_mm(1,3); z1=0;
    x2=objects_position_mm(2,2); y2=objects_position_mm(2,3); z2=0;
    x3=objects_position_mm(3,2); y3=objects_position_mm(3,3); z3=0;
    
    m=[479 0 zm 0;
        x1 y1 zm 1;
        x1 y1 z1 1;
        x1 y1 zm 1;
        xh(1,1) xh(1,2) zm 0;

        x2 y2 zm 1;
        x2 y2 z2 1;
        x2 y2 zm 1;
        xh(2,1) xh(2,2) zm 0

        x3 y3 zm 1;
        x3 y3 z3 1;
        x3 y3 zm 1;
        xh(3,1) xh(3,2) zm 0

        479 0 zm 0;
        479 0 0 0];
elseif (detected == 4)
    x1=objects_position_mm(1,2); y1=objects_position_mm(1,3); z1=0;
    x2=objects_position_mm(2,2); y2=objects_position_mm(2,3); z2=0;
    x3=objects_position_mm(3,2); y3=objects_position_mm(3,3); z3=0;
    x4=objects_position_mm(4,2); y4=objects_position_mm(4,3); z4=0;
    
    m=[479 0 zm 0;
        x1 y1 zm 1;
        x1 y1 z1 1;
        x1 y1 zm 1;
        xh(1,1) xh(1,2) zm 0;

        x2 y2 zm 1;
        x2 y2 z2 1;
        x2 y2 zm 1;
        xh(2,1) xh(2,2) zm 0

        x3 y3 zm 1;
        x3 y3 z3 1;
        x3 y3 zm 1;
        xh(3,1) xh(3,2) zm 0

        x4 y4 zm 1;
        x4 y4 z4 1;
        x4 y4 zm 1;
        xh(4,1) xh(4,2) zm 0

        479 0 zm 0;
        479 0 0 0];
elseif (detected == 5)
    x1=objects_position_mm(1,2); y1=objects_position_mm(1,3); z1=0;
    x2=objects_position_mm(2,2); y2=objects_position_mm(2,3); z2=0;
    x3=objects_position_mm(3,2); y3=objects_position_mm(3,3); z3=0;
    x4=objects_position_mm(4,2); y4=objects_position_mm(4,3); z4=0;
    x5=objects_position_mm(5,2); y5=objects_position_mm(5,3); z5=0;

    m=[479 0 zm 0;
        x1 y1 zm 1;
        x1 y1 z1 1;
        x1 y1 zm 1;
        xh(1,1) xh(1,2) zm 0;

        x2 y2 zm 1;
        x2 y2 z2 1;
        x2 y2 zm 1;
        xh(2,1) xh(2,2) zm 0

        x3 y3 zm 1;
        x3 y3 z3 1;
        x3 y3 zm 1;
        xh(3,1) xh(3,2) zm 0

        x4 y4 zm 1;
        x4 y4 z4 1;
        x4 y4 zm 1;
        xh(4,1) xh(4,2) zm 0

        x5 y5 zm 1;
        x5 y5 z5 1;
        x5 y5 zm 1;
        xh(5,1) xh(5,2) zm 0

        479 0 zm 0;
        479 0 0 0];
end

d=[];
n=height(m);
for i=1:n
    k=ik_2dof(m(i,1),m(i,2),m(i,3));
    k=fix(k);
    d=[d;k];
end

for i=1:n
    theta1=d(i,1);
    str1=int2str(theta1);
    theta2=d(i,2);
    str2=int2str(theta2);
    theta3=d(i,3);
    str3=int2str(theta3);
    nc = m(i,4);
    str4=int2str(nc);
    str=append(str1,';',str2,';',str3,';',str4);
    writeline(a1,str);
    b=0;
    while b==0
        c=readline(a1);
        if (nc == 0)
            writeline(a2,'0');
        elseif (nc == 1)
            writeline(a2,'1');
        end
        b=str2double(c);
    end
end
