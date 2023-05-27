# BAM_online_analysis

BAM(Blab Alphaomega for Monkey), is used for loading AlphaOmega online data and perform simple analyses during experiments. The current version supports a maximum of two electrodes.

Developer: LiYipeng-Moon 

## How to use

1. Connect online analysis PC to AlphaOmega via a network switch. Power up AO, prepare your experiment task and subject
2. For passive viewing paradigm in monkeylogic, please check [PassiveViewing_in_ML](https://github.com/liyipeng-moon/PassiveViewing_in_ML). 
3. Modify the parameter in the code below and run it to generate 'default_params.mat'.
    >  generate_params.m

4. Open 'BAM_Online_Loading.mlapp', once 'Let's do some science' is shown, click BLAB logo and you will start saving and analyzing.
5. You can choose desired electrode and function(add and describe it in mat file), and modify some parameter in real time.
   

## Update Journal:

### wait to add：

1. Clear Channel Data
2. refine psth
3. Put waveform in plot function

2023.05.27\
增加了示意图片，使用dataset自带的图片，使用dataset指定的颜色绘图
实现了绘图方法的改变，现在可以在Bar PSTH之间丝滑切换了
增加了User Defined Function，使用horizontal bar作为示意

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