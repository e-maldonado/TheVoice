 myRecObj = audiorecorder(44100, 16, 2);
recordblocking (myRecObj, 2); 
%  
% 
 audio = getaudiodata(myRecObj); 
audio= audio (:, 1);
%  figure
%  plot (audio);
 
 tr = fft (audio);
 tr= fftshift (tr);
 
 f= linspace (-44100/2, 44100/2, length (tr));
 f=f';
 figure
 plot (f, abs (tr))

 pos20 = max (find (f<20)) ;
 pos20k= max (find (f<20000));
 
maximus =  max (abs (tr (pos20:pos20k)));

posmax = max (find (abs (tr)== maximus));
f (posmax)