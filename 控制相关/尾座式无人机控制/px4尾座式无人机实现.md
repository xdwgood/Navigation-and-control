来源：          https://sci-hub.se/10.1109%2FIROS.2015.7353624

# 论文题目：Design and Implementation of an Unmanned Tail-sitter

### 知识点：

１：角速率（ｗ）乘速度等于速度导数（向心加速度），解释参考该链接：https://www.zhihu.com/question/67011446

２：角角速度＝力矩／转动惯量，参考链接：https://baike.baidu.com/item/%E8%BD%AC%E5%8A%A8%E6%83%AF%E9%87%8F/1994034?fr=aladdin

３：伯努利定理：流动速度增加，流体的静压将减小

### 参考文献：

４：J. Diebel, “Representing attitude: Euler angles, unit quaternions, androtation vectors,”Matrix, 2006.

５：F.H.Lutze. (2014) Lecture aoe 3104 vehicle performance.Website..Available:　http://www.dept.aoe.vt.edu/∼lutze/AOE3104/thrustmodels.pdf

９：D. Brescianini, M. Hehn, and R. D’Andrea, “Nonlinear quadrocopterattitude control,” ETH Zurich, Tech. Rep., 2013.

## 无人机动态

速度导数和力的关系如下，其中f分别代表重力、升力、舵面产生的升力、阻力、马达产生的推力，ｗ为角速率：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/312.png)

其中升力阻力计算如下下：（其中ｐ为空气密度、Ａ为机翼面积、ｖ为空速、ａ为攻角影响升力/阻力系数）

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/313.png)

由副翼产生的升力计算如下：(其中Ae为副翼面积、升力系数ce是偏转角度δ的函数)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/314.png)

推力大小是和马达转速＋空速相关的函数，如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/315.png)

旋转动量守恒为：(其中力矩ｍａ是升力（ｆｌ）、阻力（ｆｄ）和副翼产生的力(fe)组成，mt是推力产生的力矩。θ为转动惯量矩阵)(**Note**:知识点２)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/316.png)

四元数的时间导数为(其中Ｑ为四元数速率矩阵 [4])：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/317.png)

世界坐标系位置导数和机体速度关系如下(其中Ｒ为从机体坐标系到地球坐标系的旋转矩阵，该速度可以通过机体坐标系下的角速度求出，因此需要建立和世界坐标系关系)：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/318.png)

## 气流模型（建立螺旋桨后面空速和发动机总功率＋前部空速关系）

在本节中，我们将基于[5]的建模概念，为螺旋桨后面的气流提出一个模型。并将将气流建模为加速空气的汇流管，如下(其中１表示螺旋桨前部，２表示螺旋桨后部)：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/319.png)

假设螺旋桨前后的气流是不可压缩的，因此我们可以对不可压缩的流量应用伯努利定理。**Note**:我们无法将伯努利定律应用于整个螺旋桨，因为从螺旋桨的一侧到另一侧的压力会瞬间增加.我们正在寻找一个方程，该方程将风速v3与飞机v0的风速以及驱动螺旋桨的电动机所消耗的电功率相关联。

v3为螺旋桨后面的空速（作用在舵面上），v0为空速器测量，η为螺旋桨效率

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/320.png)

效率η计算可以参考原论文，图像显示如下(**Note**:当无人机从其初始静止位置提升空速时，总空速首先会略有下降)：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/321.png)

## 控制系统

用速度/位置控制环路产生的期望加速度和期望航向来定义期望姿态和推力，期望加速度和和航向输入到vtol控制器计算出期望姿态和推力。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/322.png)

### VTOL控制器

输入的是期望加速度，并减去空气动力学模型所产生的力／加速度，得到需要通过控制器获得的加速度。ades表示最后输入到vtol控制器中的设定加速度。

为了生成期望的姿态，则和以下俩个旋转相关：

1:如果飞机在水平方向上运动，yaw的角度决定了期望的飞行方向。但如果无人机在垂直方向上运动则yaw的角度不重要。我们用Ｑyaw表示yaw的旋转

2:用Qacc表示roll/pitch的旋转，该计算方法[9]使车辆的推力轴与所需的加速度矢量对齐

期望姿态计算如下，使用上面的俩个旋转四元数表示：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/323.png)

期望推力通过将期望的加速度矢量ades投影到当前推力方向单位矢量nt上，(F=ma),计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/324.png)

### 姿态和机体速率控制器

姿态误差计算如下（其中qest为当前姿态）：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/325.png)

期望的角速率计算如下（其中τq为一阶时间常数[9]，qerror,0为误差四元数第一个元素[q0]，qerror,1:3为[q1,q2,q3]）：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/326.png)

期望的扭矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/327.png)

最后得到期望力矩，然后根据无人机动态一节内容（旋转动量守恒），计算出转速和副翼偏转需求

### 个人总结：该文章很多细节没有给出（升力/阻力系数），只是提供了一种思路,用于实践有困难
