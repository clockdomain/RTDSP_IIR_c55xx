fs = 8000;

Rp = 0.1;

Rs = 60;

[N,Wn] = ellipord(800/(fs/2), 1200/(fs/2), Rp, Rs);

[b, a] = ellip(N, Rp, Rs, Wn);

 

% Passband centered at 800 Hz

% NOTE: bandwidth should be 400 Hz

[num1, den1] = iirlp2bs(b, a, 0.25, [600/(fs/2) 1000/(fs/2)]);

 

% Passband centered at 3300 Hz

[num2, den2] = iirlp2bs(b, a, 0.25, [3100/(fs/2) 3500/(fs/2)]);

 

% Cascaded combination:

num = conv(num1, num2);

den = conv(den1, den2);

exportCoefs ('num.txt', num); 
exportCoefs ('den.txt', den); 

% Analyze filter:

fvtool(num, den) 