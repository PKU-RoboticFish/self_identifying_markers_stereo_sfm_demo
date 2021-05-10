# self_identifying_markers_stereo_sfm_demo

## \feature_detection\\*.exe

里面有生成好的图案检测程序CheckboardLocalization.exe，或者可以使用CheckboardLocalizationNoDisplay.exe。

**运行条件**：

1. exe程序目录下应有linkTable_new.txt，此文件在为每个特征点添加label时需要用到。
2. template11.bmp无需顾及，exe程序会检测有无此文件，并在缺少该文件时自动生成。
3. 对应于不同的图片及被拍摄物体尺寸，应变换选择图像中容许的棋盘格点最大间隔maxMatrixR（定义在crossMarkDetector.hpp中）。所使用的海康微视相机分辨率1920*1200，工作距离30~50cm，图案的一格边长为5mm，所用的最大间隔是100pix。修改最大间隔后，应使用重新编译生成的exe程序。

**使用格式**：

在cmd中

```
.\CheckboardLocalization.exe ${img_path}
```

**输出内容**

在图像的相同目录下生成一个txt文档，里面包含有检测出的格点标签、亚像素精度坐标。之后matlab程序会读取txt文档中记录的检测结果。

相较于CheckboardLocalization**NoDisplay**.exe，CheckboardLocalization.exe在生成结果的同时，还会弹出一个窗口展示输出结果，同时在exe目录下生成imgDisplay.bmp供参考。

## \feature_detection\feature_detection.bat

这是一个批处理文件，用来使用CheckboardLocalizationNoDisplay.exe对..\registration_image中的所有图像进行检测。双击即可bat文件即可执行。

脚本内容很简单：

```bash
set PROC_HOME=%~dp0
Forfiles /p ..\registration_image\ /s /m *.jpg /c "cmd /c cd %PROC_HOME% && .\CheckboardLocalizationNoDisplay.exe @path"
pause
```

要点：

1. 对文件进行批处理，用forfiles命令就ok了，/s参数还可以实现对子文件夹的递归遍历。具体的参数含义可参见https://www.cnblogs.com/zhm1985/articles/14307600.html
2. 要先cd到exe目录，再执行exe。
3. %~dp0的含义是批处理所在目录，参见https://blog.csdn.net/xieyunc/article/details/80471107
4. @path表示文件的完整的路径，参见https://www.cnblogs.com/landv/p/6661461.html

## .\main.m

展示了如何将exe程序处理得到的txt结果导入到matlab工作环境中。内含一个在图片上表示序号的demo