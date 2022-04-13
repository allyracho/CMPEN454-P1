function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)

% Function which applies hough transform to an edge magnitude image. 

% find size of input image
[rows, cols] = size(Im);

% state max/range of theta and rho
thetaMax = 2*pi;
thetaRes = thetaRes * (180/pi);
rhoMax = sqrt((rows*rows)+(cols*cols));
rhoScale = (ceil(-rhoMax):rhoRes:ceil(rhoMax));
thetaScale = (-90:thetaRes:90);

% initalize 'vote' matrix
H = zeros(numel(rhoScale), numel(thetaScale));

% for loop over each pixel: if pixel>threshold find 
% corresponding rho and theta, inc vote matrix (H) by 1

[index_x, index_y] = find(Im > threshold);

for i = 1:numel(index_x)
    for theta = 1:numel(thetaScale)
        rho = (index_y(i)*cosd(thetaScale(theta)) + index_x(i)*sind(thetaScale(theta)));
        rho = floor(rho/rhoRes)*rhoRes;
        thetaCur = floor(thetaScale(theta)/thetaRes)*thetaRes;
        rhoInd = find(rhoScale == rho);
        thetaInd = find(thetaScale == thetaCur);
        H(rhoInd, thetaInd) = H(rhoInd, thetaInd) + 1;
    end
end

thetaScale = thetaScale .* (pi/180);

end