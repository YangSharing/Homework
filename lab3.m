clc,clear,close all;
tic;

%%%%%可修改参数
SNRdb=10;
len=200;


size=3*len;
N=size^2;
map=zeros(size,size,3);
rebuild_map=zeros(size,size,3);
input=zeros(3,N);


%%%%%%%%%%%生成初始图片
r=zeros(1,1,3);r(1)=1;
g=zeros(1,1,3);g(2)=1;
b=zeros(1,1,3);b(3)=1;
pic=[r+g,    r,     r+g+b;
     g,      r+b,   b;
     r+g+b,  g+b,   0*r;  ];

%%%%%%%%%%%生成图片的矩阵和输入信号初始码元
for i=1:size
    for j=1:size
     col=ceil(i/len);
     row=ceil(j/len);
     map(i,j,:)=pic(col,row,:);
     input(:,(i-1)*size+j)=reshape(map(i,j,:),3,1);
    end
end
figure(1);
imshow(map);
title("发送");



%%%%%%%%%%%图片传输通信系统
[output,~,~,~]=QAM8(N,SNRdb,input);


%%%%%%%%%%%重构图片并显示
for i=1:size
    for j=1:size
     rebuild_map(i,j,:)=reshape(output(:,(i-1)*size+j),1,1,3);
    end
end
figure(2);
imshow(rebuild_map);
title("接收")



toc;

