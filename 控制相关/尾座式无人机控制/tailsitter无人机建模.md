来源：　　垂直起降无人机的自适应PID控制器研究  李建伟 哈尔滨工业大学

# 尾座式无人机建模过程

### 总体定义如下图：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/199.png)

其中各部分定义如下：

X、Y、Z 分别为除重力外的合力在三个轴方向的分量

L、M、N 分别为三个轴上的力矩

u、v、w 分别为三个轴上的速度分量

p、q、r 分别为三个轴上的角速度分量

### 运动方程的推导

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/200.png)

上面最后一个式子是矢量求导得出的。**Note:**向心加速度等于角速度叉乘线速度。机体速度（V）的变化就是角速度（w）

因此加速度a等于（飞机速度和角速度与加速度关系）：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/201.png)

又因为Ｆ＝ｍａ，其中Ｆ为合力，在这个系统中包括气动力和重力，重力在体轴系下的分量可根据图2-7和图2-8求得:

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/202.png)

等式左面求解的(Fx)就是机体系xb下的重力分量（**Note**:重力占合力Ｆ的部分）。上图第一个为pitch角度，第二个为roll角度

然后计算出合力Ｆ与无人机速度和角速度之间的关系(F=ma)，结果如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/203.png)

##### 知识点：

１：动量矩（H）：描述物体转动状态的量，又称角动量。公式H= I w（Ｉ为转动惯量矩阵　ｗ为角速度）

２：转动力矩等于角速度叉乘角动量（H）

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/204.png)

即动量矩计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/205.png)

所以机体受力和角速度关系如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/206.png)

**总结**:根据2-12如果在下面的步骤中计算出在机体系下合力F(=L／M／N+重力)，则可以计算出角速度，然后根据2-6即可计算出速度(u v w)

### 将机体坐标系下的速度分量（u v w）通过欧拉角旋转到惯性坐标系下，如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/207.png)

### 气动力方程

合力F来自螺旋桨推力、固定翼机身气动力和舵面气动力。在垂直状态下可以忽略固定翼机身气动力。舵面气动力主要包括升力和阻力，计算公式如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/208.png)
![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/209.png)
