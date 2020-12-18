%用于在图像上显示聚类/bp结果
I=imread('41.jpg');
load('label.mat');
%load('ans1.mat');
% for i=1:length(ans1)
%     if ans1(i)>6
%         ans1(i)=6;
%     elseif ans1(i)<1
%         ans1(i)=1;
%     end
% end
I2=I;

% [m,n]=size(label);
m=2184;n=1034;
for i=1:m
    for j=1:n
        if label(i,j)==1&&I(i,j,1)~=255
            I2(i,j,1)=255;
            I2(i,j,2)=222;
            I2(i,j,3)=173;
        end
        if  label(i,j)==2&&I(i,j,1)~=255
            I2(i,j,1)=139;
            I2(i,j,2)=139;
            I2(i,j,3)=122;
        end
        
        if  label(i,j)==3&&I(i,j,1)~=255
            I2(i,j,1)=255;
            I2(i,j,2)=185;
            I2(i,j,3)=15;
        end
        if  label(i,j)==4&&I(i,j,1)~=255
            I2(i,j,1)=139;
            I2(i,j,2)=36;
            I2(i,j,3)=0;
        end
        
        if  label(i,j)==5&&I(i,j,1)~=255
            I2(i,j,1)=135;
            I2(i,j,2)=206;
            I2(i,j,3)=235;
        end
        
        if  label(i,j)==6&&I(i,j,1)~=255
            I2(i,j,1)=105;
            I2(i,j,2)=105;
            I2(i,j,3)=105;
        end
        
        
%         if label(i,j)==6&&I(i,j,1)~=255
%            ans1((i-1)*1034+j)
%             I2(i,j,1)=105;
%             I2(i,j,2)=105;
%             I2(i,j,3)=105;
%         end
        
        
        
    end
end


figure,imshow(I2);
