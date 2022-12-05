function [output,encode,message,star]=QAM8(N,SNRdb,input)


%%%%%%%%%%%%%%%%%%%%%%%参数
fc=2;             %%%%%%%载波频率
w=2*pi*fc;        %%%%%%%圆频率
q=(2^0.5)/2;      %%%%%%%常数:根号2
ts=0.01;           %%%%%%%颗粒度，最小采样时间间隙
fs=1/ts;          %%%%%%%分辨率，即采样率，颗粒度的倒数

   
SNR=10^(SNRdb/10);      %%%%%信噪比
Es=(10+2)/2/2;                 %%%%%平均符号能量
%n0=Es/SNR;              %%%%%高斯白噪声功率谱
n0=Es*fs/fc/SNR;              %%%%%高斯白噪声功率谱
sigma=n0/2;             %%%%%根据信噪比求噪声方差



%%%%%%%%%%%%%%%%%%%%%%%矩阵
output=zeros(3,N);              %%%%%输出二进制序列
noise=sqrt(sigma)*randn(1,N*fs);%%%%%%高斯噪声

a=zeros(1,N);                   %%%%%IQ发生器,a,b,I,Q,cos,sin
b=zeros(1,N);
I=zeros(1,N);                   
Q=zeros(1,N);
c=zeros(1,fs);
s=zeros(1,fs);

encode=zeros(1,N*fs);           %%%%%调制信息
message=zeros(1,N*fs);          %%%%%叠加了噪声的信道传输信息
decode=zeros(1,N*fs);           %%%%%解调信息
times=ts:ts:N;                  %%%%%时间区间
temp=zeros(1,N*fs);             %%%%%暂存
starMap=[-1, 3, 1,-3,-1, 3, 1,-3
         -1,-1,-1, 1, 1, 1, 1,-1];

signalMap=[ 0,0,1; 0,1,0; 0,1,1; 1,0,0; 
            1,0,1; 1,1,0; 1,1,1; 0,0,0; ]';





%%%%%%%%%%%%%%%%%%%设置载波sinwt和coswt
for i=1:fs
    c(i)=cos(w*i/fs);
    s(i)=sin(w*i/fs);
end



%%%%%%%%%%%%%%%将input的二进制序列进行映射
%%%%%%%%%%%%%%%将映射结果输入IQ发生器
input0=input(1,:)*4+input(2,:)*2+input(3,:);
index=find(input0==0); a(index)=-3; b(index)=-1;
index=find(input0==1); a(index)=-1; b(index)=-1;
index=find(input0==2); a(index)= 3; b(index)=-1;
index=find(input0==3); a(index)= 1; b(index)=-1;
index=find(input0==4); a(index)=-3; b(index)= 1;
index=find(input0==5); a(index)=-1; b(index)= 1;
index=find(input0==6); a(index)= 3; b(index)= 1;
index=find(input0==7); a(index)= 1; b(index)= 1;




%%%%%%%%%%%%%%%%使用IQ发生器生成QPSK调制信号过程

for i=1:N
    encode(:,(i-1)*fs+1:fs*i)=a(i)*c-b(i)*s;
end

%调制信号引入高斯白噪声
%message=awgn(encode,SNRdb,pow2db(Es));
message=encode+noise;

%%%%%%%%%%%%%%%%估计信道h,对衰落的信号进行信道解码
decode=message;



%%%%%%%%%%%%%%%%相干解调过程（乘载波并求积分，算出I，Q的预计值）

 for i=1:N
    temp(1,((i-1)*fs+1):fs*i)=decode(((i-1)*fs+1):fs*i).*c;
    m=0;
    for k=((i-1)*fs+1):(fs*i-1)
    m=m+ts*(temp(1,k)+temp(1,k+1))/2;
    end
    I(i)=m*2;
 end
 

 for i=1:N
    temp(1,((i-1)*fs+1):fs*i)=decode(((i-1)*fs+1):fs*i).*s; 
    m=0;
    for k=((i-1)*fs+1):(fs*i-1)
        m=m+ts*(temp(1,k)+temp(1,k+1))/2;
    end
    Q(i)=-m*2;
 end
 
 star=[I;Q];



%%%%%%%%%%%%%%%%由解码的I,Q值寻找最短距离得出output

for i=1:N
    dst=zeros(1,8);
    dst=sum(abs(star(:,i)-starMap));
    index=find(dst==min(dst),1);
    output(:,i)=signalMap(:,index);
end



%%%%%%%%%%%%%%%误码率
%errorsI=sum(abs(I-a))/N;
%errorsQ=sum(abs(Q-b))/N;
%errors=sum(sum(sum(abs(input-output))))/3/N;
%g_h=sum(sum(sum(abs(h.*g))))/16/N/fs;



%函数完
end