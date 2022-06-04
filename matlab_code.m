%DIP PROJECT
%KIDNEY STONE DETECTION USING MATLAB
%TEAM :-15
%TEAM MEMBERS :-N SRILASYA,MANOJ KUMAR.B,HAARISH NARAYAN.B,SANTHAKUMARI.S
%AND NITHISH KUMAR.S.
clc
clear all
close all
warning off
% import the ultrasound image of the kidney
[filename,pathname]=uigetfile('.','Pick a MATLAB code file');
filename=strcat(pathname,filename);
a=imread(filename);
imshow(a);
% convert the image RGB to GRAY
b=rgb2gray(a);
figure;
%histogram of the image
imshow(b);
impixelinfo;
%binarized the image
c=b>20;
figure;
imshow(c);
%fill the holes
d=imfill(c,'holes');
figure;
imshow(d);
% removal of unwanted parts
e=bwareaopen(d,1000);
figure;
imshow(e);
%REPMAT function
PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));
figure;
imshow(PreprocessedImage);
%adjust the image
PreprocessedImage=imadjust(PreprocessedImage,[0.3 0.7],[])+50;
figure;
imshow(PreprocessedImage);
%convert RGB to GRAY image
uo=rgb2gray(PreprocessedImage);
figure;
% histogram of the image
imshow(uo);
%median filter
mo=medfilt2(uo,[5 5]);
figure;
imshow(mo);
%removal of less intensity part
po=mo>250;
figure;
imshow(po);
%obtain the dimension of the image
[r c m]=size(po);
x1=r/2;
y1=c/3;
row=[x1 x1+200 x1+200 x1];
col=[y1 y1 y1+40 y1+40];
%ROI polynomial function
BW=roipoly(po,row,col);
figure;
%mask the kidney stone area
imshow(BW);
k=po.*double(BW);
figure;
imshow(k);
M=bwareaopen(k,4);
[ya number]=bwlabel(M);
if(number>=1)
 disp('Stone is Detected in the kidney');
else
 disp('No Stone is detected in the kidney');
end