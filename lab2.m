clc,clear,close all;
tic;


%%%%%%%%%%%运行过程可修改参数
N=10000;
SNRdb=0:15;



%%%%%%%%%%%矩阵
output1=zeros(3,N);              %%%%%输出二进制序列
output2=zeros(3,N);              %%%%%输出二进制序列
output3=zeros(3,N);              %%%%%输出二进制序列
star1=zeros(3,N);
star2=zeros(3,N);
star3=zeros(3,N);



%%%%%%%%%%%根据不同信噪比循环
for i=1:length(SNRdb)
    
%%%%%每次循环重新生成输入信号  
input=rand(3,N);              %%%%%输入二进制序列
input((input>0.5))=1;           %%%%%随机产生1
input((input<0.5))=0;           %%%%%随机产生0


%%%%%通信过程
[output1,~,~,~]=PAM8(N,SNRdb(i),input);
[output2,~,~,~]=PSK8(N,SNRdb(i),input);
[output3,~,~,~]=QAM8(N,SNRdb(i),input);



%%%%%计算误码率
errors1(i)=sum(abs(input-output1),'all')/3/N;
errors2(i)=sum(abs(input-output2),'all')/3/N;
errors3(i)=sum(abs(input-output3),'all')/3/N;

%errors1(i)=length(find(sum(abs(input-output1))>0))/3/N;
%errors2(i)=length(find(sum(abs(input-output2))>0))/3/N;
%errors3(i)=length(find(sum(abs(input-output3))>0))/3/N;


end



%%%%%%%%%%%误码率为0附时一个极小值才能做图
errors1(errors1==0)=1/3/N/10;
errors2(errors2==0)=1/3/N/10;
errors3(errors3==0)=1/3/N/10;

figure(1)
semilogy(SNRdb,errors1);
title('使用PAM8的误码率');            %%%%%添加标题
xlabel('SNR(dB)');                          %%%%%为x坐标轴添加标签
ylabel('BER');                              %%%%%为y坐标轴添加标签



figure(2)
semilogy(SNRdb,errors2);
title('使用PSK8的误码率');            %%%%%添加标题
xlabel('SNR(dB)');                          %%%%%为x坐标轴添加标签
ylabel('BER');                              %%%%%为y坐标轴添加标签



figure(3)
semilogy(SNRdb,errors3);
title('使用QAM8的误码率');            %%%%%添加标题
xlabel('SNR(dB)');                          %%%%%为x坐标轴添加标签
ylabel('BER');                              %%%%%为y坐标轴添加标签




figure(4)
semilogy(SNRdb,errors1);
hold on
semilogy(SNRdb,errors2);
hold on
semilogy(SNRdb,errors3);
grid on
title('PAM8,PSK8,QAM8的误码率对比');               %%%%%添加标题
xlabel('SNR(dB)');                               %%%%%为x坐标轴添加标签
ylabel('BER');                              %%%%%为y坐标轴添加标签
legend('PAM8','PSK8','QAM8')

toc;