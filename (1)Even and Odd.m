%Assignment 1: Even and odd parts of a signal
clc
clear
% a) Defines a signal X[n]
n = -30 : 30;                                   % Plotting curves in range from -30 to 30 
X=0.8.^(n).*((n>=-5)&(n<=20));                  % Define X[n]
% b) Finding x[-n],then the even &  odd parts of x[n]
% Even part = (X[n]+X[-n])/2
% Odd part = (X[n]-X[-n])/2
Neg_X=0.8.^(-n).*((n>=-20)&(n<=5));             % Define X[-n]
e=0.5* (X + Neg_X);                             % Define Even part of X[n] 
o=0.5* (X - Neg_X);                             % Define Odd part of X[n]
% c) Sketch x[n] & x[-n], even part of x[n] & odd  part of x[n]
% stem is used to Plot discrete sequence data
% subplot is used to Create axes in tiled positions
% Sketch X[n]
subplot(4,1,1)
stem(n,X)
title('X[n]');
xlabel('n')
ylabel('x[n]')
% Sketch X[-n]
subplot(4,1,2)
stem(n,Neg_X)
title('X[-n]');
xlabel('n')
ylabel('x[-n]')
% Sketch Even X[n]
subplot(4,1,3)
stem(n,e)
title('Even part of X[n]');
xlabel('n')
ylabel('Even(x[n])')
% Sketch Odd X[n]
subplot(4,1,4)
stem(n,o)
title('Odd part of X[n]');
xlabel('n')
ylabel('ODD(x[n])')

