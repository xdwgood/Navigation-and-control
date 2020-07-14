来源：          https://sci-hub.se/10.1016%2Fj.mechatronics.2018.10.001

# 论文名称：　Design and implementation of a real-time hardware-in-the-loop testing platform for a dual-rotor tail-sitter unmanned aerial vehicle

### 知识点

１：角加速度乘转动惯量等于力矩

２：

## 第一部分：系统建模

1.1机体坐标系（ｂ）和世界坐标系（ｗ）定义如下：其中机体坐标系中xb指向tail机头／pitch方向

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/328.png)

1.2基本的刚体运动方程如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/329.png)

其中，Ｒt表示从世界坐标系到机体坐标系（上图第一个式子中位置是在世界坐标下表示的），FBd表示干扰力，ＭBd为干扰力矩，Ｊ为转动惯量矩阵，𝛀为角速度，参考知识点１，**Note**−𝛀𝐉𝛀含义尚不明确,FB和ＭB表示外部力和力矩的分量，𝐐=[𝑒0，𝐞]𝐓。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/330.png)

其中Ｔ表示螺旋桨和马达产生的力和力矩，aero表示空气动力学产生的力和力觉，G重力

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/331.png)

如上图所示，在机体坐标系下螺旋桨产生的推力只在ｘ方向上存在。

推力产生的力矩如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/332.png)

以第二行为例，绕ｙ轴方向的扭矩其实就是俯仰方向，俩个力相加乘lzm,lzm和一些距离参数计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/333.png)

**Note**:上式中，正常情况下第一行俩项都为０，如果电机安装在pitch方向重心上lzm也为０，因此理想状态悬停状态下电机差速只能产生roll方向力矩。FT和MT的值是通过三维查表(three-dimensional look-up table)确定的。进行风洞实验以收集查找表的主要数据。


在上图类型的车辆中，应考虑空气动力学表面上的局部流动条件，并基于组件分解方法对其进行建模。空气动力学表面相应地由许多段组成，每段产生了气动中心的升力，阻力和力矩。

空气动力学中心的空速计算如下：其中最后一项为螺旋桨涡流贡献的速度，这个速度只在第二个区域存在。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/334.png)

螺旋桨涡流贡献的速度计算如下，其中Tp是螺旋桨产生的推力，Ａ是螺旋桨盘面积，lp是计算点和螺旋桨盘距离，Rp是螺旋桨盘半径，

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/335.png)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/336.png)

滑流区域的攻角和侧滑角定义如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/337.png)

滑流区域的空速定义如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/338.png)

各个区域的升力、阻力和侧向力计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/339.png)

在机体坐标系下表示如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/340.png)

综上，由空气动力学产生的力和力矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/341.png)

每一段的力矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/342.png)

总的空气动力学产生的力矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/343.png)


重力计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/344.png)


# 剩余内容主要为风动实验手段和hitl设计



简化版本论文，来源：　　https://sci-hub.se/10.2514%2F6.2017-0811

# 论文题目：Dynamic Modeling and Hardware-in-Loop Simulation for a Tail-Sitter Unmanned Aerial Vehicle in Hovering Flight

## 建模

无人机形状和坐标系如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/345.png)

运动的基本刚体方程为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/346.png)

其中Ｒ表示从世界坐标系到机体坐标系旋转矩阵，e0为四元数第一部分，ｅ为四元数剩于部分，Fd和Md为干扰力和力矩，𝐉是转动惯量矩阵，𝛀是角速度，Fb和Mb表示在机体坐标系下外部的力和力矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/347.png)

其中，𝐅𝐜𝐬和𝐌𝐜𝐬表示控制表面的影响

### 飞机空气动力学

为了确定飞机的流动状况，根据风速，飞行速度（地面速度）和螺旋桨涡流速度来计算空气动力学中心（a.c.）的空速：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/348.png)

其中Vbody = R ×　Ｖw,gps(世界坐标系下gps的低速).可以根据螺旋桨的动量理论和连续性方程来计算螺旋桨滑流引起的速度Vinduce，表达式如下(各参数定义见上文)：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/335.png)

滑流区域的迎角定义为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/349.png)

从数据库中获得，给定迎叫和空速的情况下，阻力系数／升力系数／力矩系数表示如下图：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/350.png)

因此左侧和右侧升力／阻力计算如下：其中Ｓ为机翼面积，ｑ为动态压力

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/351.png)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/352.png)

最后，𝐅𝐚𝐞𝐫𝐨　和 𝐌𝐚𝐞𝐫𝐨计算如下，其中　𝑙𝑥　和　𝑙𝑦　分别表示沿x轴和y轴从空气动力学中心到重心的距离

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/353.png)


### 推力

由推力（俩个马达）生成的力和力矩计算如下，其中𝑙𝑟是车身框架中推力轴与x轴之间的距离，具体的值通过风动实验得到基础数据，制作成查找表（look-up table）。

在悬停状态下主要是建立马达旋转速度＋空速和力／力矩的表格关系

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/354.png)

经过风动实验后，结果如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/355.png)

其中实验装置如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/356.png)


### 控制面

pitch轴的等效偏转方向／幅度为特殊符号ｅ，yaw轴的等效偏转为特殊符号a，特殊符号１、２分别为右侧和左侧偏转量，计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/357.png)

控制面产生的力和力矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/358.png)

其中，lx和ly分别表示沿x轴和y轴从空气动力学中心到重心的距离，**Note**:个人理解力矩计算可能有问题，𝐶𝐿𝛿𝑒应该是在特定偏转角度下的升力系数


### 重力：和上文描述一致
