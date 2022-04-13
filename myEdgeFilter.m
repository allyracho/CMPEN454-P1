function [img1] = myEdgeFilter(img0, sigma)

% Function which finds the edge intensities and orientation of input image.

% define the gaussian and sobel functions
H = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
sobel_x = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
sobel_y = [-1, -1, -1; 0, 0, 0;1, 2, 1];

% call the function myimageFilter to smooth image
conv_img0 = myImageFilter(img0, H);

% find gradient magnitude and angles
imgx = myImageFilter(conv_img0, sobel_x); % sobel: x-derivative
imgy = myImageFilter(conv_img0, sobel_y); % sobel: y-derivative
mag = sqrt((imgx.^2) + (imgy.^2)); % magnitude of gradient
angle = atan2(imgy, imgx) .* (180/pi); % convert radians to degrees
result = mag; % copy magnitude


% non-maximum supression
angle(angle<0) = angle(angle<0) + 180;
[row, col] = size(angle);

for i= 2:row-1
    for j= 2:col-1
        % angle 0
        if (0 <= angle(i,j) < 22.5) || (157.5 < angle(i,j) <= 180)
            angle(i,j) = 0;
            if mag(i, j+1)>mag(i, j) || mag(i, j-1) > mag(i, j)
                result(i,j) = 0;
            end
        % angle 45
        elseif (22.5 <= angle(i,j)) && (angle(i,j) < 67.5)
            angle(i,j) = 45;
            if mag(i-1, j+1)>mag(i, j) || mag(i+1, j-1) > mag(i, j)
                result(i,j) = 0;
            end
        % angle 90
        elseif (67.5 <= angle(i,j)) && (angle(i,j) < 112.5)
            angle(i,j) = 90;
            if mag(i-1, j)>mag(i, j) || mag(i+1, j) > mag(i, j)
                result(i,j) = 0;
            end
        % angle 135
        elseif (112.5 <= angle(i,j)) && (angle(i,j) <= 157.5)
            angle(i, j) = 135;
            if mag(i-1, j-1)>mag(i, j) || mag(i+1, j+1) > mag(i, j)
                result(i,j) = 0;
            end
        else
        end
    end
end

img1 = result;
        

end
    
                
        
        
