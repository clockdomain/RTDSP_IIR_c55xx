%[y1 Fs1] = audioread('../data/input.wav')
[y2 Fs2] = audioread('../data/output.wav');

%psd(spectrum.periodogram,y1,'Fs',Fs1);
%hold on 
psd(spectrum.periodogram,y2,'Fs',Fs2);
%hold on 

%t = 0:1/Fs:(length(y1)-1)/Fs;
%y3 = y1 - y2;
%plot(t, y2, 'b');
%hold on 
%plot(t, y3, 'r--');