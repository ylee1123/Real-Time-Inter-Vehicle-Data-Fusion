% size of encapsulated message
% detected_obj : number of detected objects
% class : predefined classes e.g., class=16 in our work.


function output=pcksize2(detected_obj,class)

output=500+detected_obj*(2*class+28)+13;


end