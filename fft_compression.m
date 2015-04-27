orig = im2double(imread('hepburn.jpg'));
figure
imshow(orig)

Y = fft2(orig);
[rows, cols] = size(Y);
g = max(max(abs(Y)));
Y_compress = Y;
count_orig = 0;
count = 0;

for m = 1:rows
    for n = 1:cols
        if abs(Y(m,n)) < 0.005*g
            Y_compress(m,n) = 0;
            count = count+1;
        end
        
        if round(abs(Y(m,n))) == 0
            count_orig = count_orig+1;
        end
    end
end
Y_compress = abs(Y_compress).*exp(sqrt(-1)*angle(Y_compress));
compress = abs(ifft2(Y_compress));
figure
imshow(compress)
test = uint8(255*compress);
imwrite(test, 'compress_imag_0.005.jpg')

percent_attenuate = ((count-count_orig)/ (rows*cols)) * 100