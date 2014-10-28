% clear; clc
% I=imread('C:\Users\Administrator\Desktop\321.jpg');
% bw=rgb2gray(I);
% temp = bw;
% 
% bw=im2bw(I,graythresh(bw));
% bw=double(bw);
% figure,
% imshow(bw);
% [a ,map]= size(bw);
% I=im2bw(a,0.75);
% I=1-I;
% Ileast = bwlabel(I,4);   % 标定图像的连通域
% nummax = max(Ileast(:)); % 分块数
% col=length(I(:,1));      % 行数
% row=length(I(1,:));      % 列数
% Area_candidate = struct('top',{},'left',{},'bottom',{},'right',{});%初始化结构体
% for n=1:nummax
%     Area_candidate(n).top=col;
%     Area_candidate(n).left=row;
%     Area_candidate(n).bottom=0;
%     Area_candidate(n).right=0;
% end
% 
% %判定各个连通域的最小外接矩形的边界的值
% for a=1:col
%         for b=1:row
%             if Ileast(a,b)~=0
%                Area_candidate(Ileast(a,b)).top = min ( Area_candidate(Ileast(a,b)).top ,a);%得到各个连通域的边界
%                Area_candidate(Ileast(a,b)).left = min ( Area_candidate(Ileast(a,b)).left ,b);
%                Area_candidate(Ileast(a,b)).bottom = max ( Area_candidate(Ileast(a,b)).bottom ,a);
%                Area_candidate(Ileast(a,b)).right = max ( Area_candidate(Ileast(a,b)).right ,b);
%             end
%         end
% end
% %新建的空矩阵上得出图像
% I_out=zeros(size(I));
% for n=1:nummax
%     I_out(Area_candidate(1,n).top:Area_candidate(1,n).bottom , Area_candidate(1,n).left:Area_candidate(1,n).right) =1 ;%填充矩形
% end
% figure,
% imshow(I_out)

% clc; clear all; close all;
% I = imread('C:\Users\Administrator\Desktop\54321.jpg');
% jd = [1,1,1]; % 黑色
% %njd = [0.8 0.8 0.8]*255; % 灰色
% njd = [0,0,0]; % 黑色
% tol = 1e-4; % 阈值
% figure;
% subplot(1, 2, 1); imshow(I, []); title('原图像');
% for i = 1 : size(I, 1)
%     for j = 1 : size(I, 2);
%         temp = double(I(i, j, :)/255);
%         temp = temp(:).';
%         aa = temp;
%         temp1 = temp-jd;
%         tempsum = temp1(1)+ temp1(2)+temp1(3);
%         if tempsum == 0
%         else
%             I(i, j, :) = njd;
%         end
%     end
% end
% subplot(1, 2, 2); imshow(I, []); title('红色变灰色图像');








% %==============================将图中除了白色以外的颜色全部置为黑色======================================
clc; clear all; close all;
I = imread('C:\Users\Administrator\Desktop\111.png');
II = I;
njd = [0,0,0]; % 黑色
[m,n,z] = size(I);
for i =1:m
    for j = 1:20
        I(i, j, 1) = 0;
        I(i, j, 2) = 0;
        I(i, j, 3) = 0;
    end
end

for i =1:m
    for j = n-20:n
        I(i, j, 1) = 0;
        I(i, j, 2) = 0;
        I(i, j, 3) = 0;
    end
end

for i =1:20
    for j = 1:n
        I(i, j, 1) = 0;
        I(i, j, 2) = 0;
        I(i, j, 3) = 0;
    end
    jj = 0;
end

for i =m-20:m
    for j = 1:n
        I(i, j, 1) = 0;
        I(i, j, 2) = 0;
        I(i, j, 3) = 0;
    end
    ik = 1;
end




subplot(1, 2, 1); imshow(I); title('原图像');

for i = 1 : m
    for j = 1 : n
        sum = (255-I(i,j,1))+(255-I(i,j,2))+(255-I(i,j,3));
        if sum < 100
            ;
        else
            I(i, j, :) = njd;
        end
    end
end
subplot(1, 2, 2); imshow(I, []); title('过滤背景色');
im=im2bw(I); 
im2=imfill(im,'holes');

B =[1 1 1
     1 1 1
     1 1 1];
 A2=imdilate(im2,B);%图像A1被结构元素B膨胀
 for i =1:10
     A2 = imdilate(A2,B);
 end
 
 B=strel('square',3);%对膨胀后的图像进行腐蚀
 for i =1:10
     A2=imerode(A2,B);
 end
 
figure,
imshow(A2);title('膨胀腐蚀');    
im3=bwperim(A2); 
figure,
imshow(im3);
%   %=======================================================================
%   
%  BW=A2;
% thresh=[0.01,0.17];    
% sigma=2;%定义高斯参数    
% f = edge(double(BW),'canny',thresh,sigma);    
% figure,imshow(f,[]);    
% title('canny 边缘检测');    
% 
% [H, theta, rho]= hough(f,'RhoResolution', 1); 
% %[H, theta, rho]= hough(f); 
% %imshow(theta,rho,H,[],'notruesize'),axis on,axis normal    
% %xlabel('\theta'),ylabel('rho');    
%     
% peak=houghpeaks(H,5);    
% hold on    
%     
% lines=houghlines(f,theta,rho,peak,'FillGap',2,'MinLength',4);    
% figure,imshow(f,[]),title('Hough Transform Detect Result'),hold on    
% for k=1:length(lines)    
%     xy=[lines(k).point1;lines(k).point2];    
%     plot(xy(:,1),xy(:,2),'LineWidth',4,'Color',[0,0,1]);    
% end    


% clc
% clear
% close all 
% % 读取图像
% I  = imread('C:\Users\Administrator\Desktop\54321.jpg');
% %rotI = imrotate(I,33,'crop'); % 旋转33度，保持原图片大小
% %fig1 = imshow(rotI);
% rotI = rgb2gray(I);
% % 提取边
% BW = edge(rotI,'canny');
% figure, imshow(BW); 
% % 霍夫变换
% [H,theta,rho] = hough(BW); % 计算二值图像的标准霍夫变换，H为霍夫变换矩阵，theta,rho为计算霍夫变换的角度和半径值
% figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
%     'InitialMagnification','fit');
% xlabel('\theta (degrees)'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(hot) 
% % 显示霍夫变换矩阵中的极值点
% P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); % 从霍夫变换矩阵H中提取5个极值点
% x = theta(P(:,2));
% y = rho(P(:,1));
% plot(x,y,'s','color','black'); 
% % 找原图中的线
% lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
% figure, imshow(rotI), hold on
% max_len = 0;
% for k = 1:length(lines)
%     % 绘制各条线
%     xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');    
%     % 绘制线的起点（黄色）、终点（红色）
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');    
%     % 计算线的长度，找最长线段
%     len = norm(lines(k).point1 - lines(k).point2);
%     if ( len > max_len)
%         max_len = len;
%         xy_long = xy;
%     end
% end
% % 以红色线高亮显示最长的线
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

Img = edge(A2,'prewitt');   %利用prewitt算子提取边缘%
imshow(Img);            %显示提取边缘的图片%
[H, T, R] = hough(Img);       %hough变换%
imshow(sqrt(H), []);           %hough变换的结果%
P = houghpeaks(H, 15, 'threshold', ceil(0.3*max(H(:))));
%寻找最大点%
lines = houghlines(Img, T, R, P,'FillGap',10,'MinLength',60 );%返回找到的直线%
points = zeros(4,2);%存储找到的直线的端点
figure, imshow(I), hold on
   max_len = 0;
   for k = 1:length(lines)
      xy = [lines(k).point1; lines(k).point2];
      
      plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
      plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
      plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   end
   
point_1 = lines(1).point1;%先为四个控制点的其中两个赋值
point_2 = lines(1).point2;%先为四个控制点的其中两个赋值
point_3 = lines(1).point1;%仅仅是初始化
point_4 = lines(1).point2;%仅仅是初始化
points(1,1) = lines(1).point1(1);
points(1,2) = lines(1).point1(2);
points(2,1) = lines(1).point2(1);
points(2,2) = lines(1).point2(2);


len = norm(lines(1).point1 - lines(1).point2);
len = len/4;

for i =2:length(lines)
    if (norm(lines(1).point1 - lines(i).point1)>len)&&(norm(lines(1).point1 - lines(i).point2)>len)&&(norm(lines(1).point2 - lines(i).point1)>len)&&(norm(lines(1).point2 - lines(i).point2)>len)
% if (lines(1).point1(1)~=lines(i).point1(1)||lines(1).point1(2)~=lines(i).point1(2))&(lines(1).point1(1)~=lines(i).point2(1)||lines(1).point1(2)~=lines(i).point2(2))&...
%         (lines(1).point2(1)~=lines(i).point1(1)||lines(1).point2(2)~=lines(i).point1(2))&(lines(1).point2(1)~=lines(i).point2(1)||lines(1).point2(2)~=lines(i).point2(2))
        %条件成立是说明当前直线在第一条直线的对边
        point_3 = lines(i).point1;%为四个控制点的另外两个赋值
        point_4 = lines(i).point2;%为四个控制点的另外两个赋值
        points(3,1) = lines(i).point1(1);
        points(3,2) = lines(i).point1(2);
        points(4,1) = lines(i).point2(1);
        points(4,2) = lines(i).point2(2);

    end
end    

%====================分配四个点======================
% min_y = 100000;
% min_y_index = 0;
% rightup_index = 0;
% for i = 1:4
%     if min_y > points(i,2)
%         min_y_index = i;
%         min_y = points(i,2);
%     end
% end
% point_1(1) = points(min_y_index,1);
% point_1(2) = points(min_y_index,2);
% 
% for i = 1:4
%     if (i~=min_y_index) && (points(i,1)>=points(min_y_index,1))
%         rightup_index = i;
%         point_2(1) = points(i,1);
%         point_2(2) = points(i,2);
%     end
% end
% 
% leftbot = 100000;
% leftbot_index = 0;
% itemp = 1;
% for i = 1:4
%     if (i~=rightup_index) && (i~=min_y_index)
% 
%         if leftbot > points(i,2)%找出剩下的两个点中相对位置比较高的点
%             leftbot_index = i;
%             leftbot = points(i,2);
%         elseif leftbot == points(i,2)
%             if points(leftbot_index,1) > points(i,1)
%                 leftbot_index = i;%如果剩下两个点高度相同则左下角的点取这两者间横坐标较小即偏做的点
%             end
%         end
%     end
% end
% point_3(1) = points(leftbot_index,1);
% point_3(2) = points(leftbot_index,2);
% 
% for i = 1:4
%     if (i~=leftbot_index) && (i~=rightup_index) && (i~=min_y_index)
%         point_4(1) = points(i,1);
%         point_4(2) = points(i,2);
%     end
% end

min_y = 100000;
min_y_index = 0;
k = zeros(4);
for i = 1:4
    if min_y > points(i,2)
        min_y_index = i;
        min_y = points(i,2);
    end
end
point_1(1) = points(min_y_index,1);
point_1(2) = points(min_y_index,2);
temp = -0.00001;%先将temp初始化为很大的负数
index = 0;
for i =1:4
    if i~=min_y_index
        if points(min_y_index,1)-points(i,1) == 0 %斜率不存在
            if temp < 0
                temp = 100000;
                index = i;
            end
        else  %斜率存在的情况下就计算斜率
            k(i) = (points(min_y_index,2)- points(i,2))/(points(min_y_index,1)-points(i,1));
            if k(i) >= 0
                if temp >= 0%如果当前保存的temp为非负数，k(i)为正数，则比较temp和k(i)，将较小者赋值给temp
                    if temp > k(i)
                        temp  = k(i)
                        index = i;
                    end
                else % 如果当前保存的temp为负数，k(i)为正数,则不管k(i)多大,都要替换
                    temp = k(i);
                    index = i;
                end
                
            else k(i) < 0
                if temp > 0 %如果计算出的k(i)为负数,而原来保存的temp为正数则无论算出的k(i)多小都不替换
                    ;
                else %如果计算出来的k(i)为负数，而原来保存的temp也为负数，则比较，将较小者赋值给temp
                    if temp > k(i)
                        temp = k(i)
                        index = i;
                    end
                end
            end
        end
    end
end

point_2(1) = points(index,1);
point_2(2) = points(index,2);

min_x = 10000;
index2 = 0;
%找到剩下两个点中相对位置较左的点
for i = 1:4
    if (i~=index) && (i~=min_y_index)
        if points(i,1) < min_x
            min_x = points(i,1);
            index2 = i;
        end
    end
end
       
for i = 1:4
    if(i~=index2) && (i~=index) && (i~=min_y_index)
        if points(i,2) < points(index2,2)
            point_3(1) = points(i,1);
            point_3(2) = points(i,2);
            point_4(1) = points(index2,1);
            point_4(2) = points(index2,2);
        else
            point_3(1) = points(index2,1);
            point_3(2) = points(index2,2);
            point_4(1) = points(i,1);
            point_4(2) = points(i,2);
        end
    end
end

%=============================================================================








gray_img= rgb2gray(II);

[M N] = size(gray_img);
dot=zeros(4,2);
dot(1,1) = point_1(1);dot(1,2) = point_1(2);
dot(2,1) = point_2(1);dot(2,2) = point_2(2);
dot(3,1) = point_3(1);dot(3,2) = point_3(2);
dot(4,1) = point_4(1);dot(4,2) = point_4(2);
%取四个点，依次是左上，右上，左下，右下,这里我取的是书的四个角
w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));     %从原四边形获得新矩形宽
h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));     %从原四边形获得新矩形高

y=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];        %四个原顶点
x=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];

%这里是新的顶点，我取的矩形,也可以做成其他的形状
%大可以原图像是矩形，新图像是从dot中取得的点组成的任意四边形.:)
Y=[dot(1,1) dot(1,1) dot(1,1)+h dot(1,1)+h];     
X=[dot(1,2) dot(1,2)+w dot(1,2) dot(1,2)+w];

B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';   %变换后的四个顶点，方程右边的值
%联立解方程组，方程的系数
A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
   0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
   x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
   0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
   x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
   0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
   x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
   0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];

fa=inv(A)*B;        %用四点求得的方程的解，也是全局变换系数
a=fa(1);b=fa(2);c=fa(3);
d=fa(4);e=fa(5);f=fa(6);
g=fa(7);h=fa(8);

rot=[d e f;
     a b c;
     g h 1];        %公式中第一个数是x,Matlab第一个表示y，所以我矩阵1,2行互换了

pix1=rot*[1 1 1]'/(g*1+h*1+1);  %变换后图像左上点
pix2=rot*[1 N 1]'/(g*1+h*N+1);  %变换后图像右上点
pix3=rot*[M 1 1]'/(g*M+h*1+1);  %变换后图像左下点
pix4=rot*[M N 1]'/(g*M+h*N+1);  %变换后图像右下点

height=round(max([pix1(1) pix2(1) pix3(1) pix4(1)])-min([pix1(1) pix2(1) pix3(1) pix4(1)]));     %变换后图像的高度
width=round(max([pix1(2) pix2(2) pix3(2) pix4(2)])-min([pix1(2) pix2(2) pix3(2) pix4(2)]));      %变换后图像的宽度
imgn=zeros(height,width);

delta_y=round(abs(min([pix1(1) pix2(1) pix3(1) pix4(1)])));            %取得y方向的负轴超出的偏移量
delta_x=round(abs(min([pix1(2) pix2(2) pix3(2) pix4(2)])));            %取得x方向的负轴超出的偏移量
inv_rot=inv(rot);

for i = 1-delta_y:height-delta_y                        %从变换图像中反向寻找原图像的点，以免出现空洞，和旋转放大原理一样
    for j = 1-delta_x:width-delta_x
        pix=inv_rot*[i j 1]';       %求原图像中坐标，因为[YW XW W]=fa*[y x 1],所以这里求的是[YW XW W],W=gy+hx+1;
        pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]'; %相当于解[pix(1)*(gy+hx+1) pix(2)*(gy+hx+1)]=[y x],这样一个方程，求y和x，最后pix=[y x];
        
        if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
            imgn(i+delta_y,j+delta_x)=gray_img(round(pix(1)),round(pix(2)));     %最邻近插值,也可以用双线性或双立方插值
        end  
    end
end

figure;
imshow(uint8(imgn));
title('最终结果');
       
   
   
   
   
   
   