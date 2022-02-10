clear
I= imread('cow.bmp');
Ig = rgb2gray(I);
sigma=2; Thrshold=100;

dy = fspecial('prewitt');
dx = dy';
%%%%%% 
Ix = conv2(Ig, dx, 'same');   
Iy = conv2(Ig, dy, 'same');

Ix2 = Ix.*Ix;  
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;


g = fspecial('gaussian',5*sigma, sigma);

%%%%% 
SIx2 = conv2(Ix2, g, 'same');  
SIy2 = conv2(Iy2, g, 'same');
SIxy = conv2(Ixy, g,'same');
%%%%%%%%%%%%%%
k = 0.04;
R = (SIx2.*SIy2 - SIxy.*SIxy) - k*(SIx2 + SIy2).^2;
%normalize to 0 - 1000
R=(1000/max(max(R)))*R;

sze = 5; 
R2 = ordfilt2(R,sze^2,ones(sze));
R3 = (R==R2)&(R>Thrshold); 

[r, c]=find(R3);

imshow(I);
hold on
plot(c,r,'r.','MarkerSize', 4);