clear
clc

%% 6*4 grid color
R = [243 56 214 115 200 70 80 194 160 175 193 98 122 231 94 87 85 187 157 133 52 8 224 103]./255;
G = [243 61 126 82 200 148 91 150 160 54 90 122 122 199 60 108 85 86 188 128 52 133 163 189]./255;
B = [242 150 44 68 200 73 166 130 160 60 99 157 121 31 108 67 85 149 64 177 52 161 46 170]./255;
%% 6*4 grid color for true dark black
R = [243 56 214 115 200 70 80 194 160 175 193 98 122 231 94 87 85 187 157 133 0 8 224 103]./255;
G = [243 61 126 82 200 148 91 150 160 54 90 122 122 199 60 108 85 86 188 128 0 133 163 189]./255;
B = [242 150 44 68 200 73 166 130 160 60 99 157 121 31 108 67 85 149 64 177 0 161 46 170]./255;
%% plot RGB
plotcolorpatch(R, G, B)
set(gcf,"Visible","on")
% saveas(gcf,'資料整理\Air_image\Air_image.bmp','bmp')
saveas(gcf,'資料整理\Air_image\Air_image_TrueDarkBlack.bmp','bmp')
%% SAVE RGB value
fpath = 'C:\Users\lingoiapple\OneDrive - 國立台灣大學\JJJ\11 碩一 上下 2021-2022\study_水下攝影測量\水下攝影測量\04 計畫\模擬資料\mat data\';
% save(strcat(fpath, "Colorchecker00_original_RGBValue.mat"),"R","G","B")
save(strcat(fpath, "Colorchecker00_original_RGBValue_BLACK.mat"),"R","G","B")
%% sRGB to linear RGB 
threshold = 0.04045;
sRGB = [R G B];
%Turn into linear RGB
for i = 1:72
    if sRGB(1,i) > threshold
        linearRGB(1,i) = ((sRGB(1,i)+0.055)/1.055)^2.4;
    else
        linearRGB(1,i) = sRGB(1,i)/12.92
    end
end
R_linear = linearRGB(1:24);
G_linear = linearRGB(25:48);
B_linear = linearRGB(49:72);

%{
Color checker:

4 8 12 16 20 24
3 7 11 15 19 23
2 6 10 14 18 22
1 5 9  13 17 21

%}
%%  SAVE linear RGB value
fpath = 'C:\Users\lingoiapple\OneDrive - 國立台灣大學\JJJ\11 碩一 上下 2021-2022\study_水下攝影測量\水下攝影測量\04 計畫\模擬資料\mat data\';
% save(strcat(fpath, "Colorchecker00_original_linear_RGBValue.mat"),"R_linear","G_linear","B_linear")
save(strcat(fpath, "Colorchecker00_original_linear_RGBValue_BLACK.mat"),"R_linear","G_linear","B_linear")

%%
function plotcolorpatch(R,G,B)
Nr_R = reshape(R, 4, 6);
Nr_G = reshape(G, 4, 6);
Nr_B = reshape(B, 4, 6);
x = 0 : 6;
y = 0 : 4;
% 網格xy首末
x1 = [x(1) x(end)]';
y1 = [y(1) y(end)]';
% 繪製網格
figure
%填色至各網格
for i = 1:4
    for j = 1:6
        xx = [0 1 1 0] + j - 1;
        yy = [0 0 1 1] + i - 1;
        patch('xData', xx, 'yData', yy, 'FaceColor', [Nr_R(i,j) Nr_G(i,j) Nr_B(i,j)]);
    end
end

axis equal
xlim(x1)
ylim(y1)
end