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
