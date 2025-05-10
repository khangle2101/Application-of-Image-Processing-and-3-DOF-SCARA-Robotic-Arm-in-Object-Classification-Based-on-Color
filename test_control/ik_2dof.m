function out = ik_2dof(Px,Py,Pz)
    % l1*c1  + l2*c12 = x
    % l1*s1  + l2*s12 = y
    % Find the1
    % Px = 170;
    % Py = 400;
    % Pz = 0;
    D2 = 146;
    D4 = 160;
    D6 = 173;
    D7 = 0;
    l1 = D4;
    l2 = D6;
    k=0;
    z = [Pz;Pz];
    x = Px-D2; y = Py;
    a1 = 2*y*l1; b1 = 2*x*l1; d1 = x*x + y*y + l1*l1 - l2*l2;
    
    the1 = basic_01(a1, b1, d1);
    the2 = atan2(y-l1*sin(the1), x - l1*cos(the1)) - the1;
    
    the = [the1 the2]*180/pi;
    the = [the z];

    % if (the(1,1)>90 || the(1,1)<-90)
    %     out = the(2,1:3);
    %     k=2;
    % end
    % if (the(1,2)>100 || the(1,2)<-100)
    %     out = the(2,1:3);
    %     k=2;
    % end
    % 
    % if (the(2,1)>100 || the(2,1)<-100)
    %     out = the(1,1:3);
    %     k=1;
    % end
    % if (the(2,2)>100 || the(2,2)<-100)
    %     out = the(1,1:3);
    %     k=1;
    % end
    % if (k==0)
    %     out=the(1,1:3);
    % end

    if (((the(1,1)<=0)&&(the(1,1)>-91)&&(the(1,2)<146)...
            &&(the(1,2)>-91))||((the(1,1)>=0)&&(the(1,1)<91)&&(the(1,2)>-146)...
  &&(the(1,2)<91)))
        out = the(1,1:3);
    elseif (((the(2,1)<=0)&&(the(2,1)>-91)&&(the(2,2)<146)...
            &&(the(2,2)>-91))||((the(2,1)>=0)&&(the(2,1)<91)&&(the(2,2)>-146)...
  &&(the(2,2)<91)))
        out = the(2,1:3);
    else
        out = 0;
    end
    detected = 0;
end