学习来源：
https://github.com/rlabbe/Kalman-and-Bayesian-Filters-in-Python
作者：
Roger Labbe（github）


# 第十一章：扩展卡尔曼滤波算法（EKF）

小知识点

1：矩阵的偏导数称为雅可比行列式（Jacobian）

### KF和EKF总体流程

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/146.png)

如上图所示，与FK相比较，EKF主要对F和H矩阵进行替换，以进行非线性化处理。

### 跟踪飞机(第一个例子)

前提：我们计划跟踪飞机的x方向位置和速度，以及高度y，我们使用雷达进行测量跟踪（传感器提供R和角度），因此有状态矩阵x=[x  x导  y]

##### 设计过程模型（如何从A到F）

由于我们假设系统在x方向上为恒速系统，因此我们使用状态空间表达如下图：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/147.png)

现在我们使用矩阵指数的幂级数展开，计算F如下图：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/148.png)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/149.png)

##### 设计测量模型

1：把先验状态x转换到测量空间如下图，有开方操作所以非线性

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/150.png)

2：因为非线性，所以我们在xt时刻对上式求偏导数

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/151.png)

##### 设计Ｒ和Ｑ

𝐑=[𝜎2　𝑟𝑎𝑛𝑔𝑒]=[25]              𝐐=[𝐐𝚡  ０;0  𝐐𝚢]

### 机器人位置（第二个例子）

前提：我们使用第十章一样的情况,求解Ｆ的Jacobian矩阵如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/152.png)

设计Ｖ，为了表述过程噪声：(**Note**最终计算结果需要使用ukf章节进行推导，当求解速度和西它加贝塔的关系时，需使用𝑅=𝑑／𝛽以及𝑑=𝑣Δ𝑡，代入f3（𝜃＝𝜃+𝛽）对ｖ求导即得到第三行第一列元素ｔ／Ｒ)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/153.png)

最后给出预测等式如下所示：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/154.png)

##### 设计测量模型（Ｈ）

其中ｐx/py为已知地标位置，使用下面矩阵将三个先验状态转化到测量空间的Ｒ和　𝜙中

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/145.png)

显然该转换非线性，因此我们求该矩阵的Jacobian，即上图矩阵第一行为函数f1，分别对三个先验状态求偏导数，得到如下Jacobian：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/155.png)

测量噪声矩阵Ｒ的设计和UFK一章一致，即使用距离和角度方差定义Ｒ矩阵,使用以上定义即可实现EKF,code见原作者文章


##### 一点思考：

总的来说，EKF的扩展主要集中在：
１：求解矩阵的Jacobian
２：使用微分方程表达Ａ并进行泰勒展开，计算得到Ｆ，根据Ａ我们可以选择放弃高阶项，近似替代得到Ｆ

１和２都可以在求解系统过程模型中使用，另一方面除了系统过程模型非线性外，测量也存在非线性，通常我们使用Jacobian进行求解和表达Ｈ矩阵，在第七章中我们提到Runge Kutta和欧拉法都是求解线性常微分方程积分的方法，Jacobian（其实就是欧拉法）只求解一阶偏导数，Runge Kutta可以求解高阶导致，这意味着Runge Kutta法更适用大时间步长

### UFK VS EKF

UKF使用２ｎ＋１个sigma点，进行运算求解非线性情况，而EKF使用一点处的导数进行线性化处理，这是本质上的不同。一个尝试描述非线性另一个尝试掩盖非线性，高低自然而下（不考虑运算耗时/cpu负载等外部运算条件）。原作者建议我们使用UKF优先。
