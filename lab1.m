clc,clear,close all;
tic;


%%%%%%%%%%%运行过程可修改参数
SNRdb=20;
N=10000;           %%%%%%%码元个数
RB=500;          %%%%%%%码元速率5000symbol/s
N0=10;            %%%%%%%作图显示码元个数


%%%%%%%%%%%矩阵
output1=zeros(3,N);              %%%%%输出二进制序列
output2=zeros(3,N);              %%%%%输出二进制序列
output3=zeros(3,N);              %%%%%输出二进制序列
star1=zeros(3,N);
star2=zeros(3,N);
star3=zeros(3,N);



    
%%%%%生成输入信号  
input=rand(3,N);              %%%%%输入二进制序列
input((input>0.5))=1;           %%%%%随机产生1
input((input<0.5))=0;           %%%%%随机产生0


%%%%%通信过程
[~,encode1,message1,star1]=PAM8(N,SNRdb,input);
[~,encode2,message2,star2]=PSK8(N,SNRdb,input);
[~,encode3,message3,star3]=QAM8(N,SNRdb,input);

%%%%%采样率
fs=length(encode1)/N;
ts=1/fs;
T=1/RB;
times=ts:ts:N0;
[f1,spec1]=drawSpectrum(times,encode1(1:N0*fs),RB);
[f11,spec11]=drawSpectrum(times,message1(1:N0*fs),RB);
[f2,spec2]=drawSpectrum(times,encode2(1:N0*fs),RB);
[f22,spec22]=drawSpectrum(times,message2(1:N0*fs),RB);
[f3,spec3]=drawSpectrum(times,encode3(1:N0*fs),RB);
[f33,spec33]=drawSpectrum(times,message3(1:N0*fs),RB);



%%%%%作图
%%%%%PAM
figure(1)
plot(times,encode1(1:N0*fs));
title('PAM8时域信号');                       %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签


figure(2)
plot(times,message1(1:N0*fs));
title('经过AWGN信道的PAM8时域信号');         %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签

figure(3)
scatter(star1(1,:),star1(2,:),'.');
axis([-9 9 -1.5 1.5])
title('使用PAM8的接收信号星座图');        %%%%%添加标题
xlabel('I');                              %%%%%为x坐标轴添加标签
ylabel('Q');                              %%%%%为y坐标轴添加标签




%%%%%PSK
figure(4)
plot(times,encode2(1:N0*fs));
ylim([-1.5 1.5])
title('PSK8时域信号');                       %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签

figure(5)
plot(times,message2(1:N0*fs));
title('经过AWGN信道的PSK8时域信号');         %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签

figure(6)
scatter(star2(1,:),star2(2,:),'.');
axis([-1.5 1.5 -1.5 1.5])
title('使用PSK8的接收信号星座图');        %%%%%添加标题
xlabel('I');                              %%%%%为x坐标轴添加标签
ylabel('Q');                              %%%%%为y坐标轴添加标签

%%%%%QAM
figure(7)
plot(times,encode3(1:N0*fs));
title('QAM8时域信号');                       %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签

figure(8)
plot(times,message3(1:N0*fs));
title('经过AWGN信道的QAM8时域信号');         %%%%%添加标题
xlabel('T/S');                              %%%%%为x坐标轴添加标签
ylabel('AMPLITUDE');                        %%%%%为y坐标轴添加标签

figure(9)
scatter(star3(1,:),star3(2,:),'.');
axis([-5 5 -1.5 1.5])
title('使用QAM8的接收信号星座图');        %%%%%添加标题
xlabel('I');                              %%%%%为x坐标轴添加标签
ylabel('Q');                              %%%%%为y坐标轴添加标签




%%%%%%%%%%%%%%%%频谱
figure(10)
plot(f1,spec1);
title('PAM8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签

figure(11)
plot(f11,spec11);
title('经过AWGN信道的PAM8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签

figure(12)
plot(f2,spec2);
title('PSK8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签

figure(13)
plot(f22,spec22);
title('经过AWGN信道的PSK8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签


figure(14)
plot(f3,spec3);
title('QAM8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签

figure(15)
plot(f33,spec33);
title('经过AWGN信道的QAM8频谱图');                       %%%%%添加标题
xlabel('f/hz');                              %%%%%为x坐标轴添加标签
ylabel('Spectrum');                        %%%%%为y坐标轴添加标签


toc;