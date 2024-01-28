# BAM_online_analysis

BAM(Blab Alphaomega for Monkey), is used for loading AlphaOmega online data and perform simple analyses during (visual) experiments. The current version supports a maximum of 16 electrodes, you can enable the exact channel you need

Developer: LiYipeng-Moon\
Contact: moonl@pku.edu.cn

## How to use

1. Connect online analysis PC to AlphaOmega via a network switch. Power up AO, prepare your experiment task and subject
2. For passive viewing paradigm in monkeylogic, please check [PassiveViewing_in_ML](https://github.com/liyipeng-moon/PassiveViewing_in_ML)
3. Modify the parameter in the code below and run it to generate 'default_params.mat'.
    >  generate_params.m

4. Open 'BAM_Online_Loading.mlapp', once 'Let's do some science' is shown, click BLAB logo and you will start saving and analyzing.
5. You can choose desired electrode and function(I put hbar example in the fN folder, fN_UD_generating_example and fN_UD_updating_example, and you can change it to scatter or anything you want), and modify some parameter in real time.
   
### Wait to add：

1. Put waveform in plot function.
2. Write a general framework for any kind of analysis.


## Update Journal


2024.01.27\
修改了PSTH和Bar切换过程中的崩溃问题
修改了程序重启后txt文档被覆盖的问题

2024.01.15\
修改了GUI布局，并修改了PSTH的显示问题
兼容了listdlg2

2024.01.09\
改成了基于TTL判断眼动的分析模式，这使得离线分析时的事件更加干净
得益于TTL的原理，眼动判断更加准确实时
有关TTL判断眼动的细节，请见刺激程序的改动日志
修改了fN_new_session的问题

2024.01.02\
改变眼动轨迹成为滚动模式
文件读写改成while try的模式，更加稳定
改使用物理地址，更加稳定

2023.12.14\
上传全新版本文件，同步更新刺激程序。
第一次上猴子测试

2023.12.10\
删除了基于TCP传刺激信息的方法，改成了使用共享文件夹的方案
完善了图片示例的方案

2023.06.16\
解决大部分由于TCP问题所导致的BUG，并使用TCP所传输的TrialData绘图

2023.06.15\
使用Network TCP的的方法传输刺激信息，只需要ML该刺激即可

2023.05.31\
修改了鼠标操作的按键模式
调整了axis生成的方法，使得title颜色不会由于更换绘图方法而刷新

2023.05.30\
改变了眼动判断触发的模式，更加稳定了
添加了Clear功能，并且把功能集成到fig的点击上
添加了Enable功能，并且把功能集成在fig的右键上

2023.05.27\
增加了示意图片，使用dataset自带的图片，使用dataset指定的颜色绘图
实现了绘图方法的改变，现在可以在Bar PSTH之间丝滑切换了
增加了User Defined Function，使用horizontal bar作为示意
把PSTH改成了BIN的模式

2023.05.26\
根据房间选择IP，需要制定房间

2023.05.01-2023-05.16\
搭建好了南侧的实验室

2023.04.07\
增加了Spike波形信息的基本绘图

2023.04.05\
解决了LFP NAN的问题，调整了LFP的单位\
画图由每次的plot变成set axis的方式，这要求每一种分析方法都要预先分配axis\
提前画图以加快时间，忽略画图所导致的数据损失\
简略的PSTH图\

2023.04.04\
有关事件相关的功能在每次读取数据过程中完成，因此处理时间随着试次数的变化是常数\
每一个条件的反应都按试次数*反应的方式存了下来，可以应用于后续的更多分析\
可以指定特定类别的展示颜色

2023.03.29\
使图像更新更加平滑，且可以对外部参数改变进行反应

2023.03.17\
初步做好了有关类别的Bar功能和LFP功能

2023.03.13\
fN_pre_register_data对每一个通道的内存数量进行考察，尤其是Sorted Spike通道

2023.03.10\
fN_miniun_prep对不同Sorted Unit进行重新分配\
在ML电脑和在线分析电脑之间通过交换机同步文件

## 2023.03
__推翻现有所写的框架，把分析功能和读取功能合并到一起，命名为BAM2__

2023.02.26\
adding a recenter function for eye signal\
2023.02.25\
seems that the unit id in bam_data.electrode is not refreshed during experiment...\