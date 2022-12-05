function [f1,spec1]=drawSpectrum(t0,y,RB)

dt0=1/RB;
time=t0*dt0;
N=length(time);

dt=time(1);
fs=1/dt;
df=fs/(N-1);
f=(0:N-1)*df;

Y=fft(y(1:N))*2/N;
figure(10)

f1=f(1:N/2);
spec1=abs(Y(1:N/2));


end