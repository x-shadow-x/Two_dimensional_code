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
% Ileast = bwlabel(I,4);   % �궨ͼ�����ͨ��
% nummax = max(Ileast(:)); % �ֿ���
% col=length(I(:,1));      % ����
% row=length(I(1,:));      % ����
% Area_candidate = struct('top',{},'left',{},'bottom',{},'right',{});%��ʼ���ṹ��
% for n=1:nummax
%     Area_candidate(n).top=col;
%     Area_candidate(n).left=row;
%     Area_candidate(n).bottom=0;
%     Area_candidate(n).right=0;
% end
% 
% %�ж�������ͨ�����С��Ӿ��εı߽��ֵ
% for a=1:col
%         for b=1:row
%             if Ileast(a,b)~=0
%                Area_candidate(Ileast(a,b)).top = min ( Area_candidate(Ileast(a,b)).top ,a);%�õ�������ͨ��ı߽�
%                Area_candidate(Ileast(a,b)).left = min ( Area_candidate(Ileast(a,b)).left ,b);
%                Area_candidate(Ileast(a,b)).bottom = max ( Area_candidate(Ileast(a,b)).bottom ,a);
%                Area_candidate(Ileast(a,b)).right = max ( Area_candidate(Ileast(a,b)).right ,b);
%             end
%         end
% end
% %�½��Ŀվ����ϵó�ͼ��
% I_out=zeros(size(I));
% for n=1:nummax
%     I_out(Area_candidate(1,n).top:Area_candidate(1,n).bottom , Area_candidate(1,n).left:Area_candidate(1,n).right) =1 ;%������
% end
% figure,
% imshow(I_out)

% clc; clear all; close all;
% I = imread('C:\Users\Administrator\Desktop\54321.jpg');
% jd = [1,1,1]; % ��ɫ
% %njd = [0.8 0.8 0.8]*255; % ��ɫ
% njd = [0,0,0]; % ��ɫ
% tol = 1e-4; % ��ֵ
% figure;
% subplot(1, 2, 1); imshow(I, []); title('ԭͼ��');
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
% subplot(1, 2, 2); imshow(I, []); title('��ɫ���ɫͼ��');








% %==============================��ͼ�г��˰�ɫ�������ɫȫ����Ϊ��ɫ======================================
clc; clear all; close all;
I = imread('C:\Users\Administrator\Desktop\111.png');
II = I;
njd = [0,0,0]; % ��ɫ
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




subplot(1, 2, 1); imshow(I); title('ԭͼ��');

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
subplot(1, 2, 2); imshow(I, []); title('���˱���ɫ');
im=im2bw(I); 
im2=imfill(im,'holes');

B =[1 1 1
     1 1 1
     1 1 1];
 A2=imdilate(im2,B);%ͼ��A1���ṹԪ��B����
 for i =1:10
     A2 = imdilate(A2,B);
 end
 
 B=strel('square',3);%�����ͺ��ͼ����и�ʴ
 for i =1:10
     A2=imerode(A2,B);
 end
 
figure,
imshow(A2);title('���͸�ʴ');    
im3=bwperim(A2); 
figure,
imshow(im3);
%   %=======================================================================
%   
%  BW=A2;
% thresh=[0.01,0.17];    
% sigma=2;%�����˹����    
% f = edge(double(BW),'canny',thresh,sigma);    
% figure,imshow(f,[]);    
% title('canny ��Ե���');    
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
% % ��ȡͼ��
% I  = imread('C:\Users\Administrator\Desktop\54321.jpg');
% %rotI = imrotate(I,33,'crop'); % ��ת33�ȣ�����ԭͼƬ��С
% %fig1 = imshow(rotI);
% rotI = rgb2gray(I);
% % ��ȡ��
% BW = edge(rotI,'canny');
% figure, imshow(BW); 
% % ����任
% [H,theta,rho] = hough(BW); % �����ֵͼ��ı�׼����任��HΪ����任����theta,rhoΪ�������任�ĽǶȺͰ뾶ֵ
% figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
%     'InitialMagnification','fit');
% xlabel('\theta (degrees)'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(hot) 
% % ��ʾ����任�����еļ�ֵ��
% P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:)))); % �ӻ���任����H����ȡ5����ֵ��
% x = theta(P(:,2));
% y = rho(P(:,1));
% plot(x,y,'s','color','black'); 
% % ��ԭͼ�е���
% lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
% figure, imshow(rotI), hold on
% max_len = 0;
% for k = 1:length(lines)
%     % ���Ƹ�����
%     xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');    
%     % �����ߵ���㣨��ɫ�����յ㣨��ɫ��
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');    
%     % �����ߵĳ��ȣ�����߶�
%     len = norm(lines(k).point1 - lines(k).point2);
%     if ( len > max_len)
%         max_len = len;
%         xy_long = xy;
%     end
% end
% % �Ժ�ɫ�߸�����ʾ�����
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

Img = edge(A2,'prewitt');   %����prewitt������ȡ��Ե%
imshow(Img);            %��ʾ��ȡ��Ե��ͼƬ%
[H, T, R] = hough(Img);       %hough�任%
imshow(sqrt(H), []);           %hough�任�Ľ��%
P = houghpeaks(H, 15, 'threshold', ceil(0.3*max(H(:))));
%Ѱ������%
lines = houghlines(Img, T, R, P,'FillGap',10,'MinLength',60 );%�����ҵ���ֱ��%
points = zeros(4,2);%�洢�ҵ���ֱ�ߵĶ˵�
figure, imshow(I), hold on
   max_len = 0;
   for k = 1:length(lines)
      xy = [lines(k).point1; lines(k).point2];
      
      plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
      plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
      plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   end
   
point_1 = lines(1).point1;%��Ϊ�ĸ����Ƶ������������ֵ
point_2 = lines(1).point2;%��Ϊ�ĸ����Ƶ������������ֵ
point_3 = lines(1).point1;%�����ǳ�ʼ��
point_4 = lines(1).point2;%�����ǳ�ʼ��
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
        %����������˵����ǰֱ���ڵ�һ��ֱ�ߵĶԱ�
        point_3 = lines(i).point1;%Ϊ�ĸ����Ƶ������������ֵ
        point_4 = lines(i).point2;%Ϊ�ĸ����Ƶ������������ֵ
        points(3,1) = lines(i).point1(1);
        points(3,2) = lines(i).point1(2);
        points(4,1) = lines(i).point2(1);
        points(4,2) = lines(i).point2(2);

    end
end    

%====================�����ĸ���======================
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
%         if leftbot > points(i,2)%�ҳ�ʣ�µ������������λ�ñȽϸߵĵ�
%             leftbot_index = i;
%             leftbot = points(i,2);
%         elseif leftbot == points(i,2)
%             if points(leftbot_index,1) > points(i,1)
%                 leftbot_index = i;%���ʣ��������߶���ͬ�����½ǵĵ�ȡ�����߼�������С��ƫ���ĵ�
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
temp = -0.00001;%�Ƚ�temp��ʼ��Ϊ�ܴ�ĸ���
index = 0;
for i =1:4
    if i~=min_y_index
        if points(min_y_index,1)-points(i,1) == 0 %б�ʲ�����
            if temp < 0
                temp = 100000;
                index = i;
            end
        else  %б�ʴ��ڵ�����¾ͼ���б��
            k(i) = (points(min_y_index,2)- points(i,2))/(points(min_y_index,1)-points(i,1));
            if k(i) >= 0
                if temp >= 0%�����ǰ�����tempΪ�Ǹ�����k(i)Ϊ��������Ƚ�temp��k(i)������С�߸�ֵ��temp
                    if temp > k(i)
                        temp  = k(i)
                        index = i;
                    end
                else % �����ǰ�����tempΪ������k(i)Ϊ����,�򲻹�k(i)���,��Ҫ�滻
                    temp = k(i);
                    index = i;
                end
                
            else k(i) < 0
                if temp > 0 %����������k(i)Ϊ����,��ԭ�������tempΪ���������������k(i)��С�����滻
                    ;
                else %������������k(i)Ϊ��������ԭ�������tempҲΪ��������Ƚϣ�����С�߸�ֵ��temp
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
%�ҵ�ʣ�������������λ�ý���ĵ�
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
%ȡ�ĸ��㣬���������ϣ����ϣ����£�����,������ȡ��������ĸ���
w=round(sqrt((dot(1,1)-dot(2,1))^2+(dot(1,2)-dot(2,2))^2));     %��ԭ�ı��λ���¾��ο�
h=round(sqrt((dot(1,1)-dot(3,1))^2+(dot(1,2)-dot(3,2))^2));     %��ԭ�ı��λ���¾��θ�

y=[dot(1,1) dot(2,1) dot(3,1) dot(4,1)];        %�ĸ�ԭ����
x=[dot(1,2) dot(2,2) dot(3,2) dot(4,2)];

%�������µĶ��㣬��ȡ�ľ���,Ҳ����������������״
%�����ԭͼ���Ǿ��Σ���ͼ���Ǵ�dot��ȡ�õĵ���ɵ������ı���.:)
Y=[dot(1,1) dot(1,1) dot(1,1)+h dot(1,1)+h];     
X=[dot(1,2) dot(1,2)+w dot(1,2) dot(1,2)+w];

B=[X(1) Y(1) X(2) Y(2) X(3) Y(3) X(4) Y(4)]';   %�任����ĸ����㣬�����ұߵ�ֵ
%�����ⷽ���飬���̵�ϵ��
A=[x(1) y(1) 1 0 0 0 -X(1)*x(1) -X(1)*y(1);             
   0 0 0 x(1) y(1) 1 -Y(1)*x(1) -Y(1)*y(1);
   x(2) y(2) 1 0 0 0 -X(2)*x(2) -X(2)*y(2);
   0 0 0 x(2) y(2) 1 -Y(2)*x(2) -Y(2)*y(2);
   x(3) y(3) 1 0 0 0 -X(3)*x(3) -X(3)*y(3);
   0 0 0 x(3) y(3) 1 -Y(3)*x(3) -Y(3)*y(3);
   x(4) y(4) 1 0 0 0 -X(4)*x(4) -X(4)*y(4);
   0 0 0 x(4) y(4) 1 -Y(4)*x(4) -Y(4)*y(4)];

fa=inv(A)*B;        %���ĵ���õķ��̵Ľ⣬Ҳ��ȫ�ֱ任ϵ��
a=fa(1);b=fa(2);c=fa(3);
d=fa(4);e=fa(5);f=fa(6);
g=fa(7);h=fa(8);

rot=[d e f;
     a b c;
     g h 1];        %��ʽ�е�һ������x,Matlab��һ����ʾy�������Ҿ���1,2�л�����

pix1=rot*[1 1 1]'/(g*1+h*1+1);  %�任��ͼ�����ϵ�
pix2=rot*[1 N 1]'/(g*1+h*N+1);  %�任��ͼ�����ϵ�
pix3=rot*[M 1 1]'/(g*M+h*1+1);  %�任��ͼ�����µ�
pix4=rot*[M N 1]'/(g*M+h*N+1);  %�任��ͼ�����µ�

height=round(max([pix1(1) pix2(1) pix3(1) pix4(1)])-min([pix1(1) pix2(1) pix3(1) pix4(1)]));     %�任��ͼ��ĸ߶�
width=round(max([pix1(2) pix2(2) pix3(2) pix4(2)])-min([pix1(2) pix2(2) pix3(2) pix4(2)]));      %�任��ͼ��Ŀ��
imgn=zeros(height,width);

delta_y=round(abs(min([pix1(1) pix2(1) pix3(1) pix4(1)])));            %ȡ��y����ĸ��ᳬ����ƫ����
delta_x=round(abs(min([pix1(2) pix2(2) pix3(2) pix4(2)])));            %ȡ��x����ĸ��ᳬ����ƫ����
inv_rot=inv(rot);

for i = 1-delta_y:height-delta_y                        %�ӱ任ͼ���з���Ѱ��ԭͼ��ĵ㣬������ֿն�������ת�Ŵ�ԭ��һ��
    for j = 1-delta_x:width-delta_x
        pix=inv_rot*[i j 1]';       %��ԭͼ�������꣬��Ϊ[YW XW W]=fa*[y x 1],�������������[YW XW W],W=gy+hx+1;
        pix=inv([g*pix(1)-1 h*pix(1);g*pix(2) h*pix(2)-1])*[-pix(1) -pix(2)]'; %�൱�ڽ�[pix(1)*(gy+hx+1) pix(2)*(gy+hx+1)]=[y x],����һ�����̣���y��x�����pix=[y x];
        
        if pix(1)>=0.5 && pix(2)>=0.5 && pix(1)<=M && pix(2)<=N
            imgn(i+delta_y,j+delta_x)=gray_img(round(pix(1)),round(pix(2)));     %���ڽ���ֵ,Ҳ������˫���Ի�˫������ֵ
        end  
    end
end

figure;
imshow(uint8(imgn));
title('���ս��');
       
   
   
   
   
   
   