# BAM_online_analysis(Developing)

BAM(Blab Alphaomega for Monkey), is used for loading AlphaOmega online data and perform simple analyses during experiments. The current version supports a maximum of 16 electrodes (64 units) and combines loading function and analysis function into one app, but we can't got data once we get into a new dataset:(

Developer: LiYipeng-Moon

## How to use

1. Connect online analysis PC to AlphaOmega via a network switch. Power up AO, prepare your experiment task and subject.
2. Modify the parameter in the code below and run it to generate 'default_params.mat'.
    >  generate_params.m
3. Open 'BAM.mlapp', once lamp turns blue, click 'BLAB LOGO' and you will get saved data.
4. Make sure that you start running this app __before__ starting MonkeyLogic
   

## Wait to fix:

sync file between online-analysis PC and Monkeylogic PC

~~__fN_pre_register_data__. check the maximum memory usage for each digital channel, especially SEG channel()~~

~~__fN_miniun_prep__. Change electrode channel initialization and storing.~~

~~adding a recenter function for eye signal~~

~~seems that the unit id in bam_data.electrode is not refreshed during experiment, fixing...~~