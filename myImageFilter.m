function [img1] = myImageFilter(img0, h)

% Function used to convolve greyscale image with specified filter (h).
% Outputs image of same size as input image

% find sizes of images and filter
[row,col] = size(img0);
[filterrow, filtercol] = size(h);
convolved = zeros(filterrow, filterrow); % flip image

% initalize output 
img1 = zeros(row, col);

% pad array with replicating terms
padded_img = padarray(img0, [(filterrow-1)/2, (filtercol-1)/2], 'replicate');

% for loops over given dimensions and returns convolved image
for g = 1:1:filterrow
    for l = 1:1:filterrow
        convolved(g,l) = h(filterrow+1-g, filterrow+1-l);
    end
end

for i = 1:row
    for j = 1:col
        val = double((padded_img(i:i+filterrow-1, j:j+filtercol-1))).*convolved;
        img1(i,j) = sum(val(:));
    end
end

end
