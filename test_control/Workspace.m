clc; 
%% Programmed by Duong Hoang Khoi

% for the1 = 0:10:280
    for the2 = -90:10:90
        for the3 =-145:10:145
            if (((the2<=0)&&(the2>-91)&&(the3<146)...
  &&(the3>-91))||((the2>=0)&&(the2<91)&&(the3>-146)...
  &&(the3<91)))
            x = 24.6*cosd(the2 + the3) + 21.7*cosd(the2) + 16.7;
            y = 24.6*sind(the2 + the3) + 21.7*sind(the2);
            z = 0;
            plot3(x,y,z,'.r')
            xlabel('x')
            ylabel('y')
            zlabel('z')
            hold on
            grid on
            title('Workspace')
            end
        end
    end
% end
