来源：　　　https://sci-hub.se/10.1109%2FICRA.2016.7487466.

# 论文题目：尾座式无人机的完全姿态控制

该论文使用**风动测量**获得动力学参数并完成建模，得到了没有明显停顿的自主飞行状态切换(Ｈ－Ｖ转换)

## 第一部分：系统总览

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/219.png)

## 第二部分：系统总览

### 2.1机翼／动力配置／飞控硬件/飞行包线

机翼跨度（Ｓ）为1m　　　弦长为0.45ｍ　　　机翼选型为PW75   副翼占弦长的30%　　副翼转动范围正负30度

### 2.2坐标系

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/300.png)

### 2.3驱动原理

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/301.png)

## 第三部分：建模

采用刚体运动原理和空气动力学建模技术与风洞数据相结合的方法,进行模型建立。以下内容概述了作用在机翼上的最重要的空气动力，然后是风洞试验的结果。 

### 3.1空气动力学

下图展示了作用在一半机翼上最重要的力和力据,其中FTi代表螺旋桨i产生的力, FLi和FDi是一侧翼型产生的升力和阻力，而Myi是沿by的力矩。然后传输到机体坐标系表示为Fxi,Fzi,Myi,a为攻角

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/302.png)

### 3.2风洞试验

通过风洞实验拟合并确定，不同的马达转速／副翼偏转角度／空速／攻角机翼可以产生多少力矩。下面俩个图展示了在俯仰方向（by方向）上的力矩和以上因素关系。

风洞实验结果如下，得到拟合的均方根误差（RMSE）为0.065N/m。 其中下图中空速为０，模拟悬停状态，wi为马达转速，δi为副翼偏转角度

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/303.png)

下图为模拟固定翼巡航飞行状态，攻角设为５度，风速假设为16m/s，RMSE为0.057N/m

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/304.png)

综上得出一个机翼在三维方向上力/力矩计算如下所示，其中cFx0,cFx2,cMy0,cMy1,cFz0,cFz1为论文中参考文献17提出模型为基础的，从风洞实验中估计出来的恒定常数。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/305.png)

俩个马达（１，２）一起产生的力和力矩在系统中，计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/306.png)

上图中：lm表示了从任意（因为对称）一侧机翼中部到车辆重心沿by的距离(指参考坐标系图中by)

假设无人机是刚体，**最后进行如下建模**:其中ｘ是位置，ｖ是速度（均在地球坐标系下）ｇ是重力加速度，Ｒ是旋转矩阵（从机体到世界），Ω是机体坐标系下角速度，J是转动惯量 

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/307.png)

## 第四部分：控制器综合

### 4.1控制总体结构图

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/308.png)

**注释**: 图最左侧为求得姿态和角速度误差输入控制器后，得出期望的三维旋转力矩，结合机翼产生的力和空速，控制器进行运算输出控制信号到马达和副翼。

### 4.2控制

因为pitch和roll的控制更重要，因此我们优先控制pitch和roll,然后在控制航向。基于此设计控制公式如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/309.png)

其中kR和kw为角度和角速率增益，Rref和Ωref为设定的角度和角速度。

### 4.3控制器分配

作用在系统上的力矩和力不仅受到执行器的影响，还受到系统当前状态的影响，例如系统的速度v及其迎角α。因此，必须采用基于状态的控制分配以创建所需的力矩。

根据姿态控制器输出的期望力矩Ｍ和位置控制器输出的Fx，通过下图计算生成副翼偏转角和马达转速：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/310.png)

其中ω1,ω2为马达转速δ1,δ2为副翼偏转角度

## 第五部分：实验验证

使用px4和Wingtra飞机
