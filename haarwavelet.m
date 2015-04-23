clear all; close all;
x = imread('hepburn.jpg');
x = im2double(x);

%imwrite(x, 'orig_hepburn_cc.jpg')

figure; imshow(x);

y = haar_2d(x);

z = haar_2d_inverse(y);
figure; imshow(y);
figure; imshow(z);

test = x-z;

final = uint8(255*z);
imwrite(final, 'compress_hepburn_cc.jpg')

count = 0;
count2 = 0;

for i = 1:length(y(:,1))
    for j = 1:length(y(1,:))
        if y(j,i) == 0
            count = count + 1;
        else
            count2 = count2 +1;
        end
    end
end
total_coeff = 512*512;
count;
count2;
count*100/total_coeff; %percent attenuation
    