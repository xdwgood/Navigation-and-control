学习来源：
https://github.com/rlabbe/Kalman-and-Bayesian-Filters-in-Python
作者：
Roger Labbe（github）


第一章：g-h-filter

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/111.png)
上图中我们假设A和B表示俩种传感器对同一状态进行测量所得到的结果，其中A的精度较高B较低，这个图直观的告诉我们：

我们在进行状态估计的时候不应该放弃任何相关信息,即使它可能很糟糕！!(帮助我们缩小估计错误)

什么是g-h滤波?

g-h滤波通过调整我们对某一状态的测量值和预测值的比例，来估计出当前系统这一状态的最优值
参数g：调整我们更偏向测量值还是预测值，g越大我们越相信测量值
参数h：调整系统响应速度