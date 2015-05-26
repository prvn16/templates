clear all
close all
clc
%%
I = imread('orig.png');
I = double(rgb2ind(I,colormap('jet')));
%I = squeeze(I(:,:,1) + I(:,:,2) + I(:,:,3));
I = imresize(I, [256, 256]);
I = I-min(min(min(I)));
I = 200*I./max(max(max(I)));
I = I + 25;


hh = figure(1);
imagesc(I); colormap jet; colorbar
print(hh,'-dpng','p.png')



%%

h = daubcqf(2);
WI = mdwt(I,h);

% Find first-level decompositions
WI1 = zeros(size(WI));
WI1(1:2,1:2) = WI(1:2,1:2);
I1 = midwt(WI1,h);

WW = mdwt(fix(I),h);
WW = WW-min(min(WW));
WW = WW./max(max(WW));
hh = figure(1);
imagesc(WW); colormap gray; 
print(hh,'-dpng','w.png')


%%

hh = figure(1);
imagesc(I1); colormap jet; colorbar
print(hh,'-dpng','p1.png')

%%
close all
% Find second-level decompositions
ll = 5;

WI2 = zeros(size(WI));


WI2(1:2^(ll),2^(ll-1)+1:2^(ll)) = WI(1:2^(ll),2^(ll-1)+1:2^(ll));
WI2(2^(ll-1)+1:2^(ll),1:2^(ll)) = WI(2^(ll-1)+1:2^(ll),1:2^(ll));
I2 = midwt(WI2,h);

hh = figure(1);
imagesc(I2); colormap jet; colorbar
print(hh,'-dpng','p5.png')

%%
break
%%
clear all
close all

h = daubcqf(2);
% test levels

ww = zeros(128,128);
ww(4,4) = 1;
ii = midwt(ww,h);
imagesc(ii); colormap gray

%%
clear all
close all
h = daubcqf(2);

WW = zeros(128,128);

ll = 3;
WWn = zeros(size(WW));

WWn(1:2^(ll),2^(ll-1)+1:2^(ll)) = 1;
WWn(2^(ll-1)+1:2^(ll),1:2^(ll)) = 1;

WWn(1:10,1:10)