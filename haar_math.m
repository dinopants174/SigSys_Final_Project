clear all; close all;
orig = imread('hepburn.jpg'); % grayscale format
x = im2double(orig); % double-precision floating-point number

% First, we need to find the different number of divisions made to the image to get 8 by 8 blocks that will have the transform implemented on:
    
[m, n] = size(x)
divisions_row = m/8;
divisions_column = n/8;

new = zeros(m,n); % new matrix of the transformed image

haar = [1.0/8.0 1.0/8.0 1.0/4.0 0 1.0/2.0 0 0 0;
    1.0/8.0 1.0/8.0 1.0/4.0 0 -1.0/2.0 0 0 0;
    1.0/8.0 1.0/8.0 -1.0/4.0 0 0 1.0/2.0 0 0;
    1.0/8.0 1.0/8.0 -1.0/4.0 0 0 -1.0/2.0 0 0;
    1.0/8.0 -1.0/8.0 0 1.0/4.0 0 0 1.0/2.0 0;
    1.0/8.0 -1.0/8.0 0 1.0/4.0 0 0 -1.0/2.0 0;
    1.0/8.0 -1.0/8.0 0 -1.0/4.0 0 0 0 1.0/2.0;
    1.0/8.0 -1.0/8.0 0 -1.0/4.0 0 0 0 -1.0/2.0]; % Linear algebra approach, which is a matrix multiplication version of the Haar wavelet transform. This matrix is the equivalent of finding the average and difference of every pair in every row and every column
    
% The following code, which transforms every division created from the image matrix
for j = 1:divisions_row
    for k = 1:divisions_column
        new(1+8*(j-1):8*(j),1+8*(k-1):8*(k)) = transpose(haar)*x(1+8*(j-1):8*(j),1+8*(k-1):8*(k))*haar;
    end
end

        
final = uint8(new*255); % make a version of the final image that has grayscale format

% The following code finds the level of attenuation in the original image:
count_orig = 0;
count_not = 0;
for i = 1:length(orig(:,1))
    for j = 1:length(orig(1,:))
        if orig(j,i) == 0
            count_orig = count_orig + 1;
        else
            count_not = count_not +1;
        end
    end
end
            
% The following code finds the level of attenuation in the haar transformed image:
count_transformed = 0;
count_notzero = 0;
for i = 1:length(final(:,1))
    for j = 1:length(final(1,:))
        if final(j,i) == 0
            count_transformed = count_transformed + 1;
        else
            count_notzero = count_notzero +1;
        end
    end
end
            
total_coeff = m*n;
original_attenuation = count_orig*100/total_coeff
transformed_attenuation = count_transformed*100/total_coeff
figure; imshow(x)
figure; imshow(new)