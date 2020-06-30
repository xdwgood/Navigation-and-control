论文来源：　　https://arxiv.org/pdf/1802.00714.pdf

INDI相关资料来源：　https://github.com/paparazzi/paparazzi/pull/1207

小知识点：

１:**飞行包线(flight envelope)**：指特定型号的飞机的运行参数和功能。 构成飞行包线的各种参数包括飞机的最大高度，最大和最小速度，飞机可以承受的最大g力，爬升率，滑行率以及其他定义飞机飞行特性的因素。一般大的飞行包线意味着飞机有更灵活的飞行能力（eg：战斗机），小的飞行包线表示飞机可控制范围有限（eg:民航客机）

2:攻角/迎角(angle of attack)：是指纵轴与来流之间的夹角

3:航迹角(Flight Path Angle): 飞机相对地面运动的路线叫做航迹线，航迹的运动方向叫做航迹角/NED下的水平方向和因风影响后相对地面速度的方向的夹角(**Note**:解释如下图)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/210.png)


# 论文第一部分介绍

对于tail无人机最大的挑战有三个：(1)导航　　(2)角度控制　　(3)速度控制

**角度控制的困难主要体现在**：tail飞机有大的飞行包线，这通常意味着有失速状态（stalled　conditions），以及建模复杂。（eg:低空速下通常无法准确确定迎角）

### 重心要求：

tail飞机的pitch角度严重依赖于重心位置，通常水平飞行重心相对于空气动力表面需要更向前，而悬停飞行相反。所以需要重心相对于纵向稳定性的位置方面做出妥协。 由于前向飞行中的空气动力力矩比悬停时大得多，与悬停时的不稳定性相比，这种飞行状态下的不稳定性预计要难得多。 因此，重心位于中性点以向前飞行。 另外，重心越靠后放置，离襟翼越近，襟翼产生的俯仰力矩越小。

### 增量非线性动态反演(Incremental Nonlinear Dynamic Inversion)

INDI是一种由角加速度测量驱动的方法。所有力矩(输入力矩和外部力矩)共同产生的角加速度可以通过从陀螺仪测量中得出。假设外部力矩不会快速变化，则只需估算控制效果即可计算出输入增量，从而产生所需的角加速度增量。 然后，角加速度是一个受控变量，它可用于以简单的比例增益控制角速率。

**Note**:使用INDI进行姿态控制的开源库：https://github.com/paparazzi/paparazzi

INDI介绍：通过测量角加速度（这是通过从陀螺仪获得并过滤得到的），我们可以测量出实际的角加速度与所需的角加速度相差多少。通过将此乘以执行器效率的倒数，我们得到输入的正确增量，这将导致所需的角加速度增量。主要好处是可以快速补偿干扰，并且可以更好地控制非线性动力学。

# 姿态控制

在论文中坐标系定义如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/211.png)

重心问题：该论文中强调垂直飞行时候需要重心靠下，水平飞行需要在中心位置，如果没有主动重心调整机械则这是一个矛盾的存在。该论文认为我们更在乎的是水平飞行的效率，并且水平飞行气动力较大因此不容易控制，综上重心会靠近中心位置。

### INDI所需参数定义

uc：执行器  **左右襟翼，右左马达（左flap为１，右flap为２，右马达为３，左马达为４）**        **roll为１ pitch为２ yaw为３**

Ω：表示角速率   Ｔ（specific force比力）推力

输入的增量导致角加速度和推力的增量，具体取决于控制有效性矩阵G.

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/212.png)

上图中uc（发送到执行器）为计算的设定控制值＝当前控制输入＋控制影响矩阵（Ｇ）ｘ（需求的角加速度和需求的推力－当前角加速度和推力），其中需求的角加速度和推力来自位置／速度环INDI输出。

在pitch方向Ｇ设定如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/213.png)

**Note**:G21表示：左flap对pitch的影响（其中数字下标定义见：INDI所需参数定义开始部分）.且G22=-G21

在yaw方向Ｇ设定如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/214.png)

**Note**:G32=G31

在roll方向Ｇ设定如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/215.png)

马达改变影响Ｚ轴加速度设定为-0.0011

推力对油门的影响，Ｇ定义如下（２.2表示rad/s2在pitch方向每增加百分之一推力）

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/216.png)

**Note**:G24=G23

### 总结控制影响矩阵Ｇ定义如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/217.png)

### 该论文使用加权最小二乘（Weighted Least Squares）控制分配算法，进行控制器分配

基本分配如下[100,1000,0.1,10]，其中对应为roll,pitch.yaw,thrust

# 侧滑(Sideslip)

侧滑角定义如下：飞行器飞行速度矢量V与其纵向对称平面之间的夹角，如下图：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/218.png)