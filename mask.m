myRecObj = audiorecorder(44100, 16, 2);
recordblocking (myRecObj, 4); 
 

audio = getaudiodata(myRecObj);
 play (myRecObj);
 sound (audio, 44100);


 [ l m ] = size (audio);
 mascara1 = linspace (1, 0, l );
 mascara2 = linspace (0, 1, l );
 mascara1 = (exp (mascara1)-1 )/(exp(1)-1);
 mascara2 = (exp (mascara2)-1 )/(exp(1)-1);
 
 cool = zeros (l, 2);
 for i=1:l
     cool(i, 1)= mascara1(i) * audio (i, 1);
     cool(i, 2)= mascara2(i) * audio (i, 1);
 end
 
 sound (cool, 44100);