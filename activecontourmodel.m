clear all;
close all;
clc;

f = imread('circle.png');

f = imfilter(f,ones(13,13)/13^2);

[R,C] = size(f);
%% Initialize the Active contour model.
pts = zeros(40,2);
pts(1:10,1) = 1;
pts(1:10,2) = floor(1:C/10:C);

pts(11:20,1) = floor(1:R/10:R);
pts(11:20,2) = C;

pts(21:30,1) = R;
pts(21:30,2) = floor(C:-C/10:1);

pts(31:40,1) = floor(R:-R/10:1);
pts(31:40,2) = 1;

Npts = size(pts,1);

[vis_im] = vis_acm(f,pts);
imshow(vis_im);

%% For each iteration calculate the Total Energy.

stepSize = 5;
alpha = 1;
beta = 2;

%% Image Gradient.
gx = imfilter(single(f),[-1 1]);
gy= imfilter(single(f),[-1 1]');

iteration =100000;
totalEnergy = 0;
for index = 1:iteration
    pts_old = pts;
    extEnergyOld = externalEnergyComputation(gx,gy,pts);
    internalEnergyOld = internal_energy(pts);
    teOld = internalEnergyOld - extEnergyOld;
    disp(teOld);
    
     j = randi(Npts);
     s1 = randi([-stepSize stepSize]);
     s2= randi([-stepSize stepSize]);
     
     if(s1 <0 )
         pts(j,1) = max(pts(j,1)+s1,1);
     else
         pts(j,1) = min(pts(j,1)+s1,R);
     end
     
     if(s2 < 0)
         pts(j,2) = max(pts(j,2)+s2,1);
     else
         pts(j,2) =min(pts(j,2)+s2,C);
     end
    
    newExtEnergy =  externalEnergyComputation(gx,gy,pts);
    newIntEnergy = internal_energy(pts);
    teNew = newIntEnergy - newExtEnergy;
    disp(teNew);
    
    if(teNew < teOld)
        pts_old = pts;
        extEnergyOld= newExtEnergy;
        internalEnergyOld = newIntEnergy;
        teOld = teNew;
    else
        pts= pts_old;
    end
    extStr = sprintf('External Energy: %f, Internal Energy: %f, Total Energy: %f',extEnergyOld,internalEnergyOld,teOld);
    disp(extStr);
    
end
   
[vis_im_last] = vis_acm(f,pts);
figure,imshow(vis_im_last);


