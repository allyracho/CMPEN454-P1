function [rhos, thetas] = myHoughLines(H, nLines)

% Function which uses Hough transform) to detect lines.  
% Outputs the found lines on the image.

% find size of H and pad array 
copy = H;
paddedcopy = padarray(copy, [1, 1], 'replicate');
[row, col] = size(copy);

rhos = zeros(nLines, 1);
thetas = zeros(nLines, 1);

%non-maximal supression: all neighbors
for i = 2:row - 1
    for j = 2:col - 1
        if any(find((paddedcopy(i-1:i+1, j-1:j+1) > paddedcopy(i, j)))) > 0
            copy(i-1, j-1) = 0;
        end
    end
end


% peaks 
for i = 1:nLines
    maxInd = max(copy(:));
    [rhoMaxInd, thetaMaxInd] = find(copy==maxInd);
    rhos(i) = rhoMaxInd(1);
    thetas(i) = thetaMaxInd(1);
    copy(rhoMaxInd(1), thetaMaxInd(1)) = 0;
end

end
        