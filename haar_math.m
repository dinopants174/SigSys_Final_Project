clear all; close all;
orig = imread('hepburn.jpg'); %real pic format
%orig = rgb2gray(orig2);
x = im2double(orig);

[m, n] =size(x)
divisions_row = m/8;
divisions_column = n/8;

new = zeros(m,n);

haar = [1.0/8.0 1.0/8.0 1.0/4.0 0 1.0/2.0 0 0 0;
    1.0/8.0 1.0/8.0 1.0/4.0 0 -1.0/2.0 0 0 0;
    1.0/8.0 1.0/8.0 -1.0/4.0 0 0 1.0/2.0 0 0;
    1.0/8.0 1.0/8.0 -1.0/4.0 0 0 -1.0/2.0 0 0;
    1.0/8.0 -1.0/8.0 0 1.0/4.0 0 0 1.0/2.0 0;
    1.0/8.0 -1.0/8.0 0 1.0/4.0 0 0 -1.0/2.0 0;
    1.0/8.0 -1.0/8.0 0 -1.0/4.0 0 0 0 1.0/2.0;
    1.0/8.0 -1.0/8.0 0 -1.0/4.0 0 0 0 -1.0/2.0];

for j = 1:divisions_row
    for k = 1:divisions_column
        new(1+8*(j-1):8*(j),1+8*(k-1):8*(k)) = transpose(haar)*x(1+8*(j-1):8*(j),1+8*(k-1):8*(k))*haar;
    end
end

final = uint8(new*255);

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
total_coeff = m*n;
count_orig*100/total_coeff
figure; imshow(x)
figure; imshow(new)