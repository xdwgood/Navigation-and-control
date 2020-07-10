来源：　　　https://www.cse.sc.edu/~terejanu/files/tutorialUKF.pdf

# 介绍

UKF通过取随机变量的ｎ个状态分布来线性化随机变量的非线性函数。由于该技术考虑了随机变量的传播，因此该技术比泰勒级数线性化更为准确

# UFK算法

### 1.1选择Sigma点

一共选取２ｎ＋１个Sigma点,选取规则如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/191.png)

### 1.2模型预测步骤

把上一步生成的sigma点，输入到非线性过程传递函数ｆ（ｘ）中(11)，将得到的结果乘上对应权重，并求和得到先验预测状态Xfk(12),并计算该状态的协方差矩阵(13)，计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/192.png)

然后将simga点也输入到非线性测量传递函数ｈ（ｘ）中，然后计算均值和协方差，如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/193.png)

### 1.3更新步骤

最优估计值、卡尔曼增益和后验协方差计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/194.png)

# 平方根UKF

为了保证矩阵在实际计算中稳定，因此我们采用Cholesky分解对矩阵进行处理（cholupdate函数） ，具体操作见论文
