orig = im2double(imread('hepburn.jpg'));
figure
imshow(orig)
imwrite(orig, 'orig_imag.jpg')

Y = fft2(orig);
[rows, cols] = size(Y);
g = max(max(abs(Y)));
Y_compress = Y;
for m = 1:rows
    for n = 1:cols
        if abs(Y(m,n)) < 0.0001*g
            Y_compress(m,n) = 0;
        end
    end
end
Y_compress = abs(Y_compress).*exp(sqrt(-1)*angle(Y_compress));
compress = abs(ifft2(Y_compress));
figure
imshow(compress)
test = uint8(255*compress);
imwrite(test, 'compress_imag_0.005.jpg')