# BAM_online_analysis

BAM(Blab Alphaomega for Monkey), is used for loading AlphaOmega online data and perform simple analyses during experiments. The current version supports a maximum of two electrodes.

Developer: LiYipeng-Moon 

## How to use

1. Connect online analysis PC to AlphaOmega via a network switch. Power up AO, prepare your experiment task and subject
2. For passive viewing paradigm in monkeylogic, please check [PassiveViewing_in_ML](https://github.com/liyipeng-moon/PassiveViewing_in_ML). 
3. Modify the parameter in the code below and run it to generate 'default_params.mat'.
    >  generate_params.m

4. Open 'BAM_Online_Loading.mlapp', once 'Start' is enable, click it and you will get saved data. You can select desired electrode and function in real time.
   

## Wait to fix:

~~__fN_pre_register_data__. check the maximum memory usage for each digital channel, especially SEG channel()~~

~~__fN_miniun_prep__. Change electrode channel initialization and storing.~~

~~sync file between online-analysis PC and Monkeylogic PC~~

~~adding a recenter function for eye signal~~

~~seems that the unit id in bam_data.electrode is not refreshed during experiment, fixing...~~