clc,clear
%parpool local 8;
[A,R] = geotiffread('4.tiff');
info = geotiffinfo('4.tiff');
% Lat=zeros(2258256,1);
% Lon=zeros(2258256,1);
Lat=[];Lon=[];
k=0;
% for i=1:2184
%     for j=1:1034
%         [x,y] = pix2map(info.RefMatrix, i, j);
%         [lat,lon] = projinv(info, x,y);
%         k=k+1;
%         Lat(k)=lat;
%         Lon(k)=lon;
%     end
% end

%需要把背景搞定


for i=1:2184
    [x,y] = pix2map(info.RefMatrix, i, 1);
    [lat,lon] = projinv(info, x,y);
    Lat=[Lat,lat];
end
for j=1:1034
    [x,y] = pix2map(info.RefMatrix, 1, j);
    [lat,lon] = projinv(info, x,y);
    Lon=[Lon,lon];
end


%a=textread('1.txt');
[a,b,c,d]=textread('1.txt','%s%f%f%d');
train_data=[b c];train_label=d;
%test_data=[36.0479721162912,120.295861721293];
mdl = ClassificationKNN.fit(train_data,train_label,'Distance','euclidean');
label=zeros(2184,1034);

% label = predict(mdl,test_data)
% I=imread('41.jpg');


for i=1:2184
    for j=1:1034
        test_data=[Lon(j),Lat(i)];
%         if I(i,j,1)~=255
            label(i,j) = predict(mdl,test_data);
%         end
    end
end


%Class = knnclassify(test_data,train_data,train_label, 3,  'euclidean', 'nearest')