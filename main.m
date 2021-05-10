clc;clear;close all;

%% 从图像处理结果的txt中导入各个图像出现的特征点及其序号
% 相机a5在左，a4在右
% 输出结果：points_left, points_right
% points_left以及points_right是cell数组，里面存放了各个图像内提取出的特征点及其序号

img_location = '.\registration_image\';
idx = 15:1:25; % [1,10]或[15, 25]
idx_bias = 14;

points_right = {};
for i = idx
    fid = fopen(strcat(img_location,'a4\image_',num2str(i,'%.2d'),'_a4.txt'),'r');
    markers = [];
    while ~feof(fid)
        str = fgetl(fid);   % 读取一行, str是字符串
        split_list = strsplit(str,{':',' '});
        if strcmp(split_list{1},'matrix_coordinate')
            markers = [markers; [str2double(split_list{2}),str2double(split_list{4}),str2double(split_list{5})]];
        end
    end
    fclose(fid);
    points_right{i-idx_bias,1} = markers;
end

points_left = {};
for i = idx
    fid = fopen(strcat(img_location,'a5\image_',num2str(i,'%.2d'),'_a5.txt'),'r');
    markers = [];
    while ~feof(fid)
        str = fgetl(fid);   % 读取一行, str是字符串
        split_list = strsplit(str,{':',' '});
        if strcmp(split_list{1},'matrix_coordinate')
            markers = [markers; [str2double(split_list{2}),str2double(split_list{4}),str2double(split_list{5})]];
        end
    end
    fclose(fid);
    points_left{i-idx_bias,1} = markers;
end

%% 加载标定参数

load('.\CameraParams.mat');

%% demo: 特征点序号可视化
% 展示points_left及points_right的用法。

img_idx = 25; % 选择范围: [1, 25]
view_type = 'stereo'; % 选择范围: {'right', 'left', 'stereo'}
format = '.jpg';

if strcmp(view_type,'right')||strcmp(view_type,'stereo')
    if strcmp(view_type,'stereo')
        subplot(1,2,2);
    end
    view = 'a4';
    points = points_right{img_idx-idx_bias};
    img = imread(strcat(img_location,view,'\image_',num2str(img_idx,'%.2d'),'_',view,format));
    img = insertText(img, points(:,2:3), points(:,1),'FontSize',8);
    img = insertMarker(img, points(:,2:3), 'o', 'Color', 'red', 'Size', 5);
    imshow(img);
end

if strcmp(view_type,'left')||strcmp(view_type,'stereo')
    if strcmp(view_type,'stereo')
        subplot(1,2,1);
    end
    view = 'a5';
    points = points_left{img_idx-idx_bias};
    img = imread(strcat(img_location,view,'\image_',num2str(img_idx,'%.2d'),'_',view,format));
    img = insertText(img, points(:,2:3), points(:,1),'FontSize',8);
    img = insertMarker(img, points(:,2:3), 'o', 'Color', 'red', 'Size', 5);
    imshow(img);
end



