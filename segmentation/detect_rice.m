
%{
% 2 Februari 2020
  this code is fully created by Pulung Hendro Prastyo
  Universitas Gadjah Mada, Yogyakarta
%}

clc; clear; close all; warning off all;

se = strel('disk',12);
se1 = strel('disk',5);
se2 = strel('disk',2);

% read  RGB image
im = imread('rice1.jpg');
%im = imread('ronaldo.png');
figure,imshow(im);

% Converting RGB image to grayscale image
im_gray = rgb2gray(im);
figure,imshow(im_gray);

tophatFiltered = imtophat(im_gray,se);
figure,imshow(tophatFiltered)

%ADD TOP HAT
x= imadd(im_gray,imtophat(im_gray,se));
figure,imshow(x)

%ADD BOTTOM HAT
y=imbothat(im_gray,se);
figure,imshow(y)

%image enhancement
J = imsubtract(imadd(im_gray,imtophat(im_gray,se)),imbothat(im_gray,se));
figure,imshow(J)

%sharpening
b = imsharpen(J,'Radius',2,'Amount',1);
figure, imshow(b)

%Segmentasi dengan Otsu thresholding. Binery Image 
level = graythresh(b);
bw = im2bw(b,level); 
figure, imshow(bw)


%image fill
img_fill = imfill(bw,'holes');
figure,imshow(img_fill);

%opening
img_opening = imopen(img_fill,se1);
figure,imshow(img_opening);


%logic
img_logic= logical(1-img_opening);
figure,imshow(img_logic);

%mean
f = ones(3,3)/9;
img1 = filter2(f, img_logic);
figure,imshow(img1);


%Erosi
%ImgErose = imerode(img_fill,se1);
%figure,imshow(ImgErose);

%dilation
%ImgDilate = imdilate(ImgErose,se2);
%figure,imshow(ImgDilate);

%opening
%img_opening = bwareaopen(ImgErose,40);
%figure,imshow(img_opening);

%logic
%img_logic= logical(1-ImgErose);
%figure,imshow(img_logic);

%median
%img_m = medfilt2(img_fill, [9 9]);
%figure, imshow(img_m)


