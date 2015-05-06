function res = fft_compression(imagePath, threshold_factor, outputPath)
% This function takes as input the filename of the image you want to
% compress, the threshold factor which will be multiplied by the term in the
% Fourier series with the greatest magnitude, and the filename of the
% resulting output. The function ouputs the percent of terms in the Fourier
% series that have been attenuated because the magnitude of these terms is
% below the given threshold.
orig = im2double(imread(imagePath));
figure
imshow(orig)    %creates the matrix of the original image

Y = fft2(orig); %perform the fft on the original image
[rows, cols] = size(Y);
max_mag = max(max(abs(Y))); %determines the maximum magnitude of the terms in the Fourier Series
Y_compress = Y; %stores the original image in a matrix we will loop through and make sparser
count_orig = 0; %counts the terms in the Fourier series that are already 0
count = 0;  %counts the terms in the Fourier series that are attenuated to 0

for m = 1:rows
    for n = 1:cols
        if abs(Y(m,n)) < threshold_factor*max_mag
            Y_compress(m,n) = 0;    %attenuates to 0 terms in the Fourier series whose magnitude 
                                    %are below threshold
            count = count+1;
        end
        
        if round(abs(Y(m,n))) == 0  %counts how many terms in the Fourier series are practically 0,
                                    %without attenuation
            count_orig = count_orig+1;
        end
    end
end
compress = abs(ifft2(Y_compress)); %perform the ifft on the new, sparser matrix
figure
imshow(compress)
fin = uint8(255*compress);  %converts back so we can save it as a .jpg file
imwrite(fin, outputPath)

percent_attenuate = ((count-count_orig)/ (rows*cols)) * 100;    %calculates the percentage of terms in the fourier series that are attenuated
res = percent_attenuate;
end