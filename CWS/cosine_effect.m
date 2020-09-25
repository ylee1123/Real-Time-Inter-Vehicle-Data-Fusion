% Cosine effect compensation
% myloc : my location (x,y) coordinate
% measloc : measured location (x,y) coordinate
% stored_loc : history (previous position)


function [cosa_para,target_direction] = cosine_effect(myloc,measloc,stored_loc)

%     myloc=[-1 -2];
%     measloc=[0 -2-sqrt(3)];
%     stored_loc=[1 1];
%        
%   Based on the currenct location information, calculate the direction angle of the vehicle.
%   Then calculate the value of cosine effect and direction of the target
%   vehicle's 
%


cosa_para = 0;
target_direction= 0;


x_diff=abs(measloc(1)-myloc(1));
y_diff=abs(measloc(2)-myloc(2));
beta_angle = 0;

    if x_diff == 0
        beta_angle = 0;
    else
        beta_angle=atan(y_diff/x_diff)*180/pi;
    end

    if measloc(1)-myloc(1) > 0 && measloc(2)-myloc(2) > 0
        beta_angle = beta_angle;
    end
    if measloc(1)-myloc(1) > 0 && measloc(2)-myloc(2) < 0
        beta_angle = 360-beta_angle;
    end
    if measloc(1)-myloc(1) < 0 && measloc(2)-myloc(2) > 0
        beta_angle = 180-beta_angle;
    end
    if measloc(1)-myloc(1) < 0 && measloc(2)-myloc(2) < 0
        beta_angle = beta_angle + 180;
    end
    
    if measloc(1)-myloc(1)==0 &&  measloc(2)-myloc(2) > 0
        beta_angle=90;
    end
    if measloc(1)-myloc(1)==0 &&  measloc(2)-myloc(2) < 0
        beta_angle=270;
    end    
    if measloc(1)-myloc(1)>0 &&  measloc(2)-myloc(2) == 0
        beta_angle=0;
    end
    if measloc(1)-myloc(1)<0 &&  measloc(2)-myloc(2) == 0
        beta_angle=180;
    end    
    if measloc(1)-myloc(1)==0 &&  measloc(2)-myloc(2) == 0
        beta_angle=0;
    end    
  
    
x_diff1=abs(stored_loc(1)-measloc(1));
y_diff1=abs(stored_loc(2)-measloc(2));
alpha_angle=0;
    if x_diff1 == 0
        alpha_angle = 0;
    else
        alpha_angle=atan(y_diff1/x_diff1)*180/pi;
    end

    if measloc(1)-stored_loc(1) > 0 && measloc(2)-stored_loc(2) > 0
       alpha_angle = alpha_angle;
    end
    if measloc(1)-stored_loc(1) > 0 && measloc(2)-stored_loc(2) < 0
        alpha_angle = 360-alpha_angle;
    end
    if measloc(1)-stored_loc(1) < 0 && measloc(2)-stored_loc(2) > 0
        alpha_angle = 180-alpha_angle;
    end
    if measloc(1)-stored_loc(1) < 0 && measloc(2)-stored_loc(2) < 0
        alpha_angle = alpha_angle + 180;
    end
    
    if measloc(1)-stored_loc(1)==0 &&  measloc(2)-stored_loc(2) > 0
        alpha_angle=90;
    end
    if measloc(1)-stored_loc(1)==0 &&  measloc(2)-stored_loc(2) < 0
        alpha_angle=270;
    end    
    if measloc(1)-stored_loc(1)>0 &&  measloc(2)-stored_loc(2) == 0
        alpha_angle=0;
    end
    if measloc(1)-stored_loc(1)<0 &&  measloc(2)-stored_loc(2) == 0
        alpha_angle=180;
    end    
    if measloc(1)-stored_loc(1)==0 &&  measloc(2)-stored_loc(2) == 0
        alpha_angle=inf;
    end  

   angle_diff= beta_angle-alpha_angle;
  angle_para=cos(angle_diff*pi/180);


    cosa_para = abs(1/angle_para);
    target_direction = alpha_angle;


end