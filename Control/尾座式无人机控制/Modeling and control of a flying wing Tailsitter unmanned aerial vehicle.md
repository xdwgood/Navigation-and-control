# 论文名称：　尾座式无人机的建模与控制

### 作者： Romain Chiappinelli

## 摘要

tailsitter是一类特殊的固定翼无人机，旨在弥合旋翼机和传统固定翼飞机之间的差距。这些系统能够执行特技和静止机动，包括垂直起飞和着陆，以及高效的水平飞行。然而，由于两种不同的飞行模式，这种飞行能力带来了控制挑战。在多旋翼飞行期间，机翼失速，只有推力支撑飞机的重量。后面的控制面板叫升降舵它产生影响由于推力产生的滑流。在平飞期间，飞机以相当大的向前速度飞行，从机翼产生升力以及从升降副翼产生控制权。在这项研究中，基于组件分解方法，为整个飞行包线范围开发了一个实时模拟器。模拟器包括平板空气动力学模型，其中包括控制面偏转的影响、地面接触模型以及半经验推进器模型。在这个模拟环境中开发和实现了一个基于四元数的控制器，并在真实平台上进行了测试。通过实验证明实际飞行任务所需的自主机动，包括垂直起飞和爬升、过渡到水平飞行、返回过渡、静止飞行、垂直下降和着陆。比较模拟和飞行实验的结果，并用于定性评估模拟器的性能。


## 第一章：介绍

### 1.1:背景知识和动机

无人驾驶飞行器 (UAV) 被提议用于搜索和救援、监控、农业管理、航空摄影和 3D 测绘等多种应用。今天的无人机市场主要分为旋翼机和固定翼飞机。旋翼机具有垂直起降（VTOL）、悬停飞行能力和高机动性。相比之下，固定翼飞机能够高效快速地平飞，适合远程和耐力应用；但需要跑道或其他设备，例如发射器和网，用于起飞和着陆。此外，传统的固定翼飞机不能悬停飞行。结合这两类飞机的优势的想法导致了一种称为 VTOL 飞机或混合动力飞机的新类别。VTOL 飞机的早期设计出现在 1950 年代，Convair Pogo 是第一个被报道的有人驾驶尾翼。由于飞行员难以执行从垂直飞行到水平飞行的过渡，该项目在几次成功飞行后被取消。更成功的设计，例如 Harrier Jump Jet 或倾转旋翼波音 V22 Osprey，如图 1-2 所示，今天仍在使用。然而，这些设计从未用于民用应用。


虽然它们不太适合运输人员或货物，但这些概念作为无人机可能更有希望。建模、控制理论和硬件小型化的进步都是自主 VTOL 飞机开发的使能技术，导致无人机学术研究对 VTOL 飞机的兴趣增加。

### 1.2：平台选择

今天提出了几种混合设计，其中许多是自制的。在这项研究中，目标不是设计飞机，而是研究动力学和控制。这就是选择市场上可用机身的原因。基于可用平台的成熟度和可靠性，仅考虑两种 VTOL 机身：

A： X-Vert VTOL from Horizon Hobby（俩个马达尾座式）
B： FireFLY6 from BirdsEyeView Aerobotics

X-Vert tailsitter 是一款经济实惠的平台，翼展约为 0.5 m。这是一架带有两个推进器的飞翼飞机，可以起飞和降落且保持机头向上。为了完成从悬停飞行到水平飞行的过渡，整个飞机需要俯仰进入水平。该平台配备定制硬件和姿态控制器，能够执行从垂直飞行到水平飞行的转换以及从水平飞行到垂直飞行的返回转换。但是，如果选择这个平台，整个硬件和控制器都需要更换，因为嵌入式系统不是开源的。高的推重比允许飞机悬停和垂直飞行，推进器提供支撑飞机重量的力。在这种情况下，推进器吹出的气流，称为滑流，确保后控制面提供姿态控制的权限。在水平飞行期间，飞机几乎是水平定向的，其重量主要由机翼产生的升力支撑。在这第二种情况下，由于飞机的大量前进速度产生的气流，控制面是有效的。

FireFLY6 是使用开源 Pixhawk 硬件控制器的倾转旋翼设计。 它是一个翼展约 1.5 m 的飞翼，带有三个反向旋转的推进器对。 两个前推进器对可以倾斜以执行转换。 在垂直机动期间，这架飞机充当 Y 形六旋翼。

选择第一个机身是因为它的机械简单性和最少数量的执行器使这款尾翼成为优雅的学术工具。 一个吸引人的地方是，由于两种飞行方式在空气动力学上非常不同，因此尾翼在动力和控制方面面临更大的挑战。


### 1.3:文献综述

### 1.3.1:尾座式无人机

研究界报告了几种成功的尾翼无人机控制策略。tailsitter能够在不同的飞行状态下飞行，这会导致非常非线性的空气动力学，这对于用单个控制器进行控制是具有挑战性的。为了克服这个困难，衍生出随飞行模式而变化的姿态和高度控制器，例如在敏捷固定翼飞机上在室内测试的悬停和水平飞行线性控制器之间选择的切换逻辑，在室外测试的适应姿态控制的增益调度 在 18 公斤的尾翼或混合控制器上，它使用不同的动力学模型进行悬停、过渡和水平飞行，每个模型都有一个单独的控制器，最后一个控制器仅在模拟中进行了测试。开发了其他类型的基于自适应的控制器，例如在10文章中，它使用机载递归最小二乘法来估计将偏转与角加速度相关的线性函数。然后在这个估计的动力学模型上应用反推控制器，并能够在室外环境飞行测试期间控制飞机。最近，使用自适应方法从基础的函数中估计空气动力学，然后级联架构控制器能够跟踪室内环境中的路径。作为姿态误差的函数的预先计算的最佳身体速率被用于姿态控制器。

在文章12中使用了一种更经验的方法，其中基于一半飞机的风洞实验，力和力矩模型被实现为速度、迎角、电机转速和升降舵偏转数据的二次曲线拟合。然后将控制结构分成在 SO(3) 中运行的姿态控制器，它生成所需的力矩和执行器分配，混合执行器以实现这些力矩和所需的纵向力。这种方法能够跟踪室外环境中的路径。

另一种基于物理学的方法，使用四元数进行姿态控制在文章13中有所报道。 首先，根据位置误差、速度误差和空气动力学模型计算所需的加速度。 然后，选择所需的姿态以将推进器指向所需的加速度。 最后，期望的矩被计算为四元数误差和身体速率的 PD 定律。 报告了户外实验，但没有报告用于空气动力学系数的模型，也没有报告用于将控制面偏转与力矩相关联的模型。

在这项工作中，所实现的控制器源自一个基于四元数的控制器，该控制器是为特技飞行开发的，它不假设任何特定的操作点。因为它考虑了全范围的旋转运动，所以能够在大的姿态变化下表现良好。它的级联架构允许它以最少的修改应用于不同的平台。选择这种控制策略，因为它已经被证明，通过实验飞行测试，能够在特技飞行中控制固定翼飞机，包括平飞、悬停、过渡、激进的转身....在先前的工作中进行的从水平飞行到悬停的过渡与尾翼所需的过渡非常相似。


### 1.3.2:实时仿真

空气动力和力矩通常按流入速度的平方进行建模。 这仅允许使用**迎角 (AOA)** 的空气动力学系数函数。对于低迎角，升力系数通常线性建模，阻力系数建模为升力系数的二次函数,这是传统固定翼飞机的常见模型，可以捕获升力引起的阻力.已知升力系数是飞机纵横比的函数。 给出了不同纵横比范围的常用经验公式.对于固定翼飞机，经验升力系数公式也存在作为后掠角的函数.

为了覆盖整个飞行包线，空气动力学系数有时被建模为攻角的二阶正弦和余弦函数，例如文章19.然而，低和高迎角之间的失速效应在模型中没有表现出来。在文章11中，三阶三角函数用于捕捉失速影响。这些三阶三角函数的行为类似于平板模型。失速的影响也可以建模为 sigmoid 函数，以将线性范围与平板模型混合以获得高 AOA,众所周知，一旦失速，翼型的轮廓对其空气动力学性能的影响可以忽略不计.控制面偏转的影响通常是线性建模的，例如在19中或更一般地使用稳定性导数。

在 12 中提出了另一种由完全经验模型组成的方法。飞翼尾翼被分成左右翼，空气动力和力矩用二次多项式拟合为飞机速度、螺旋桨角速度和 控制面偏转。 尽管这种方法对于给定的平台可能非常准确，但它纯粹是基于实验，因此需要进行大量的风洞测试。

最相关的模拟器之一是来自 Selig文章22的模拟器。 该型号专为小型特技飞机设计。 它使用组件分解方法，其中机翼被分成几个具有自己表面的部分，并产生升力、阻力和俯仰力矩。 这三个量的空气动力系数是针对全攻角和操纵面偏转范围预先计算的，并在模拟过程中通过线性插值进行检索。

在这项研究中，选择部件分解方法来模拟机翼空气动力学。 平板理论基于航空航天机电一体化实验室文章23的先前工作，用于根据流入速度和最终的控制面偏转实时计算机翼每个部分的空气动力和力矩。


### 1.4:研究目标

1:为所选平台开发完整的飞行包线实时模拟器。将围绕薄平板空气动力学模型文章23建立一个模拟器，并将包括地面接触和结构空气动力学建模在内的相关组件纳入其中。

2：为所有飞行模式开发单一控制器。 为特技固定翼飞机（文章14）开发的基于四元数的控制器将被修改以在尾翼平台上实施。

3：展示控制器的自主能力。 控制器将在模拟环境中进行测试。它也将在真实环境和平台中测试。目的是通过实验证明单控制器是否适用于尾翼平台，包括过渡机动。

4：根据飞行实验数据对模拟器进行定性评估。 将比较来自模拟飞行测试和真实实验的数据并调查差异。


### 1.5:论文组织

本论文分为三个部分。 首先，实时模拟器记录在第 2 章，其中介绍了运动方程，然后是详细的动力学模型和半经验模型所需的测量。 然后，在第 3 章中介绍了控制策略，其中将飞行任务划分为基本机动，并详细介绍了控制架构。 在第 4 章中，介绍了模拟和真实平台上的飞行测试，并对模拟器性能进行了定性评估。 最后，第 5 章给出了结论以及对未来工作的建议。



## 第二部分：无人机仿真

本章描述了尾翼飞机的建模和相关的实时模拟器。 它分为五个部分。 第一部分介绍了模型开发中使用的框架和约定。 第二部分描述了刚性飞机的运动方程。 第三部分开发模拟器动力学，即模拟过程中作用在飞机上的力和力矩的模型。 第四部分介绍了一个封闭形式的空气动力学模型，用于执行测量并由第 3.2.4 节中描述的控制器的执行器混合器使用。 最后一部分报告了为提供模型参数而进行的实验测量。

模拟器在 Matlab/Simulink 中实现，X-Plane 9 用于实时轨迹的可视化，截图如图 2-1 所示。


### 2.1:框架和约定

所使用的平台是如下图所示的双推进器飞翼尾翼。 对于该系统，定义了三个参考系：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a1.png)

上图：尾翼 CAD 模型显示了车身框架 B、几何框架 G、惯性框架 I、四个致动器以及作用在部分控制表面上的滑流。 使用右手定则沿 y B 定义偏转为正。

惯性坐标系 I：[x I , y I , z I ] T ，固定在地面上并选择为北东地 (NED)。 地面假设在飞机的工作空间中是局部平坦的。

几何坐标系 G：[x G , y G , z G ] T ，固定在飞翼后缘，横向居中，在弦线内。 几何框架 G 用于独立于质心位置的几何参考。

机身框架B：[x B , y B , z B ]，固定在飞机上，位于其质心CM。 质心被假定为横向居中，在弦线内，并位于距后缘距离为 d x 处。

这架飞机有四个执行器，分别是：

由于螺旋桨叶片的阻力，左侧推进器产生力 T l 和扭矩 Q l 。 在这种情况下，推进器由螺旋桨、无刷直流电机 (BLDC) 和电子速度控制器 (ESC) 组成。BLDC 是同步电机，这意味着电机转速与正弦波频率成正比。产生正弦波是 ESC 的目的，它根据油门信号 τ 控制它们的频率。硬件组件在附录 F 中列出。从后面看车辆，左螺旋桨顺时针旋转。扭矩与旋转相反，这意味着 Q l 沿 x B 为负。 旋转的螺旋桨吹出空气，称为滑流效应。

右推进器，产生力 T r 和扭矩 Q r 。 由于它逆时针旋转，它的扭矩与左侧推进器的扭矩相反，并且沿 x B 为正。

左升降舵（升降舵代表升降舵和副翼组合），它是位于车辆后部、左推进器后面的控制面。 它的位置特意位于滑流中，以确保它在低速时保持有效性。

右升降舵，位于右推进器后面。 按照惯例，控制面偏转会增加外倾角，因此两个升降舵偏转都定义为沿 y B 轴为正。

执行器组合工作以产生推力和滚动、俯仰和偏航力矩。纵向力是通过同时推力实现的，而偏航力矩是由不同的推力产生的。 这同样适用于升降副翼挠度； 普通偏转产生俯仰力矩，而不同偏转产生滚动力矩。（**Note**：作者是针对固定翼状态描述的）

在悬停（机头向上）时，尾翼能够保持固定位置，但它也能够通过绕 z B 轴倾斜和绕 y B 俯仰来执行低速位移。 偏转。这些轻微的倾斜和俯仰角将具有将纵向推力定向到所需位置的效果。 在这种情况下，航向方向可以通过不同的升降舵偏转来控制。

为避免术语混淆，本文将使用以下内容：

**欧拉角** 本论文中使用的集合是文章15中定义的 yaw-pitch-roll R 1 (ψ)R 2 (θ)R 3 (φ)，它对应于绕 z B 轴旋转 ψ，然后是 绕新的 y B 轴旋转 θ，最后绕新的 x B 轴旋转 φ。

飞机在悬停机动期间的旋转将通过术语航向、俯仰和横向倾斜来描述。 航向将是飞机原点绕垂直轴的旋转，在这种情况下为 x B 。 术语俯仰描述了飞机绕其 y B 轴的旋转，横向倾斜将是飞机绕 z B 轴的旋转。


### 2.2:飞机运动学方程

运动方程是一组标准方程，将飞机的动力学描述为刚体，可以在飞机教科书中找到，例如文献20中。由于这架飞机能够进行广泛的姿态变化，单位四元数 q 用于姿态表示。 选择此约定而不是欧拉角，因为当俯仰角接近 θ = ±π/2 时，后者具有奇点，称为万向节锁定。 在这种情况下，偏航角和横滚角不是唯一的。单位四元数没有运动奇点。 定义和关系在附录 E 中给出。使用四元数（文献25） 的刚性飞机的运动方程由下式给出：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a2.png)

其中 R(q) 是从体坐标系 B 到惯性坐标系 I 的旋转矩阵，它是从单位四元数中检索出来的，p 是惯性位置，v B = [u, v, w] T 是在机体坐标系框架下的速度, m 是车辆的质量, ω B = [p, q, r] T 是机体框架中的机体角速率, ⊗ 是四元数积, I 是车辆关于车身框架轴的惯性矩阵 以质心 (CM) 为中心，× 是 3D 叉积。  F B 和 M B 是施加在 CM 上的净车身力和力矩，CM 是车身框架 B 的原点。 R(q) 的表达式在附录 G 中由公式 G.14 给出。


### 2.3:动态模型


实时模拟器以图形方式显示在下图中。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a3.png)

实时模拟器以图形方式显示在上图中。许多动力学块计算 CM 处的力和力矩，然后将这些力和力矩添加并馈送到运动方程（方程 2.1），然后将其积分以生成状态 p、vB、q、ωb。

作用在质心上机体上的力FB， 是重力 F g 、推进器力 F th 、空气动力 F a 、杆阻力 F r 和地面接触力 F c 的总和：

F B = F g + F t h + F a + F r + F c   （2.2）

类似地，作用在质心上机体上的力矩 M B = [L, M, N] T 是推进器和陀螺力矩 Mth 、空气动力学力矩 M a 、杆阻力力矩 M r 和地面接触力矩 M c 的总和：

M B = M t h + M a + M r + M c         （2.3）

由重力引起的力在第 2.3.2 节中描述。 它直接作用于**CM（质心）**，因此没有创建时刻。

为了计算机翼产生的空气动力，实施了组件分解方法，在第 2.3.3 节中进行了报告。机翼被分成梯形段。每个表面以自己的速度移动，如第 2.3.1 节所述，并围绕其空气动力学中心产生升力、阻力和俯仰力矩。然后将力和力矩相加并传输到CM。 由于滑流或飞机的高转速，该方法允许对机翼表面上的部分流动条件进行建模。通过将机翼视为平板来获得空气动力和力矩（文献23）。该模型预测整个飞行包线的空气动力学、失速效应、低展弦比和后掠的影响以及具有大偏转的大控制面。

使用类似的部件分解方法来模拟起落架和其他附件引起的阻力，这些附件被视为杆段。这在第 2.3.4 节中描述。通过考虑油门信号和流入速度来评估推进器力和扭矩。 还考虑了陀螺力矩，这些力矩是飞机旋转时螺旋桨角动量守恒产生的力矩。 推进器模型在第 2.3.5 节中描述。最后，为了模拟起飞和着陆阶段，开发了地面接触模型。 该模型在第 2.3.7 节中介绍，其中考虑了飞机上的特定外部点。 当这些点与地面接触时，会产生与穿透距离成正比的反作用力以及摩擦力。


### 2.3.1:速度和攻角


需要针对空气动力学模型和推进器模型评估飞机上不同点的速度。 在机身框架 B 中工作，位于飞机上位置 ri 处的任意点 i 相对于空气的速度可以通过以下公式找到：

v i = vB + ω B × r i − vw,B    (2.4)

其中 vw,B 是由 Dryden 风模型生成的车身框架中的风速，如附录 B 中所述。该方程适用于滑流之外的任何点。

速度可以分解为 v i = [u i , v i , w i ]T 的分量。 水平段的攻角 αi 是流入速度和翼型弦线之间形成的入射角，可以从下式找到：

α i = atan2(w i , ui )      (2.5)

垂直段（即小翼）的攻角，也称为侧滑角 βi 可以计算为：

β i = atan2(v i , ui )    (2.6)

当一个点在滑流内部时，纵向分量 ui 被修改，因为推进器沿纵向轴线吹动。速度 ui 分别修改为 vl,x 和 vr,x ，定义如下，分别用于左侧和右侧推进器后面的部分。动量理论可用于预测螺旋桨盘下游远处的速度(文献17)。正如在小型飞机螺旋桨上的实验所报告的那样（26），动量理论对螺旋桨盘下游 1 到 3 螺旋桨半径之间的距离给出了合理的预测。该距离范围对应于螺旋桨盘后面的操纵面位置。 基于此，左右螺旋桨将产生纵向气流，其速度由下式给出：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a4.png)

其中 rp 是螺旋桨半径，vin,l , vin,r是左右推进器的流入速度。可以使用公式 2.4 将它们计算为螺旋桨位置处速度的第一个分量。根据相同的理论，当飞机静止时（即推进器没有流入速度）,滑流的直径由 ds = 根号2 x rp 给出。 这个量是为暴露于滑流速度的翼段的宽度选择的。根据相同的理论，螺旋桨盘处的速度 vd 由下式给出：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a5.png)

这些量用于模拟螺旋桨护罩上的速度。


### 2.3.2:重力


重力产生作用于质心 (CM) 的力 Fg：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a6.png)

其中g是通常的重力加速度 [m/s 2 ]。 不会产生力矩，因为该力直接作用在 CM 上。质心位置位于后缘前方距离 dx=0.13m处，并假设与推进器的旋转轴和机翼弦线在同一水平面内。质量 m 是在一个称上测量的，而惯性矩阵 I 和质心位置是使用附录 A 中描述的高保真 CAD 模型评估的。


### 2.3.3:机翼空​​气动力学


机翼的空气动力和力矩通过部件分解进行建模。 每个段都有自己的速度，使用方程 2.4 计算，在其表面 Si 上，并产生自己的升力、阻力和绕其空气动力学中心的俯仰力矩。 然后将每个段的力和力矩相加以形成空气动力Fa 和空气动力力矩Ma。虽然尾翼的翼型不是平的，但选择为平板轮廓开发的模型(23)作为可用数据来评估整个飞行包线以及具有大挠度的大型控制面的空气动力和力矩。对于这个尾翼，飞翼被分成九个水平段，这些段构成了捕获滑流和带有控制面的部分的最少数量。在每个翼尖添加一个垂直段，见下图：

组件分解。 蓝色部分暴露于左侧滑流，绿色部分暴露于右侧滑流。 粗的黑色组件代表结构组件，建模为产生阻力的杆段。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a7.png)

每个水平段i具有平均空气动力弦ci和跨度bi，在其空气动力中心ri处产生力Fi为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a8.png)

其中 CL 是升力系数，CD 是阻力系数，后面会介绍。 每个水平段，知道它们的俯仰力矩在空气动力学中心CM,ac处，也会产生一个力矩Mi = [0, M i , 0] T：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a9.png)

类似地，每个垂直段 i 在其空气动力中心 r i 处产生一个力 F i 为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a10.png)


其中 βi 是第 2.3.1 节中定义的段 i 的侧滑角。 垂直线段矩定义为 M i = [0, 0, N i ] T ，其中：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a12.png)

然后将每段的空气动力和力矩传输到飞机的质心，如下所示：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a13.png)


表 2-1：水平翼段，从左到右。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a11.png)

表 2-1 报告了飞翼水平段的几何特征。 显示的参数是几何框架 G 中给出的段面积 S i 、跨度 b i 、MAC ci 、襟翼弦 cf ,i 和气动中心 ri,G。 从该表中，机翼的气动中心可以计算为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a14.png)

类似地，表 2-2 报告了两个垂直段的特征，即小翼(俩个支撑架)。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a15.png)

在线性范围内，以下升力曲线斜率用于飞翼段，如(18)中所述：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a16.png)

其中 Λ 是扫掠角（sweep angle），取为19.8度，水平段的纵横比 AR取为 3.13。 同样在线性范围内，以下方程用于描述升力和阻力系数：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a17.png)

其中 CD,0 是机翼表皮摩擦引起的阻力系数，k0是Oswald的效率因子。

随着迎角的增加，气流在称为“失速”的过程中与上表面分离，该过程逐渐发生。 为了解决这个问题，(23)中的模型包括一个术语，用于从机翼上表面逐渐分离气流，从后缘开始，以及湍流前缘涡流，这两者都会导致升力损失 . 完全失速时的攻角 αhigh 对应于完全的流动分离，是从经验数据库中检索的，该数据库列出了不同平板纵横比的经验数据库。控制面偏转具有增加翼段弯度和减少有效弦长的作用。 结果是升力、阻力和力矩曲线的移动以及失速攻角 αhigh 的修改。一套完整的方程，包括失速模型、操纵面偏转效应、垂直段和力矩系数，读者可以参考(21)。

整机全飞行包线升阻系数如图2-5所示，整机俯仰力矩系数如图2-6所示。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a18.png)

图 2-5：整架飞机的空气动力系数。 升力系数 C L 用黑色表示，阻力系数 C D 用蓝色表示。 两种力都用处于最小、零和最大偏转角的两个升降副翼表示，分别用平面、带点的平面和虚线表示。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a19.png)

图 2-6：整架飞机的俯仰力矩系数。 它用处于最小、零和最大偏转角的两个升降副翼表示，分别用平面、带点的平面和虚线表示。


### 2.3.4 结构段空气动力学

这里主要讲的是起落架和桨叶保护罩对模型的影响，我选择忽略它。


#### 2.3.5 推进器和陀螺力矩


左右推进器产生沿 x B 轴指向前方的推力 T l 和 T r。 因此推进器力 Fth 是纯粹的纵向力：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a20.png)

左右推进器分别位于距 CM 的横向距离 l 和 -l 处。 推进器与 CM 位于同一水平面，它们沿纵轴的位置不会影响产生的力矩，因为推进器仅沿 x B 轴产生力。 推力产生绕 z B 轴的偏航力矩。 此外，每个螺旋桨都会产生一个扭矩 Q。在这个平台上，左螺旋桨顺时针旋转，右螺旋桨逆时针旋转，从而产生相反方向的扭矩。推进器产生的力矩由 MT 给出：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a21.png)

然后将陀螺力矩 M gyro 与 MT 相加以产生 Mth 。 反作用陀螺力矩是由于旋转推进器的角动量随机体速率的变化率引起的，由下式给出：

M gyro = −ωB × Ith ωp            2.24

其中 ω B = [p, q, r] T 是飞机的机体速率，I th 是推进器旋转部件的惯性矩阵，取自旋转轴上的一点，ωp 是推进器的角速度。由于推进器围绕 xB 轴以高转速 ωp 旋转，因此选择将螺旋桨视为具有固定惯性的等效圆盘。 圆盘的对称性产生了一个对角惯性矩阵，将方程 2.24 简化为：

M gyro = −ωB × Ith ωp xB         2.25

其中 Ith 是推进器旋转部件绕 xB 轴的标量惯性。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a22.png)

该方程相对于推进器角速度是线性的。 假设左右推进器的惯性相同，ωp 可以替换为 ω l − ω r ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a23.png)

其中 ω l 和 ω r 是左右推进器角速度，均为正值。Ith 根据CAD 模型估计为1.626 · 10 -6 [kg m 2 ]。最后，总推进器力矩 M th 为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a24.png)


### 2.3.6 推进力和扭矩


需要根据油门信号产生推力和扭矩，还需要考虑流入速度对推力的影响。 叶片元素动量理论(28)可用于模拟螺旋桨空气动力学。在这种情况下，螺旋桨需要分解成多个部分，然后将这些部分视为翼型，根据自身速度产生升力和阻力。推力和扭矩通过沿螺旋桨半径积分得到。 然而，这将需要螺旋桨形状的高保真模型以及叶片段的升力和阻力系数函数。 由于这些原因，我们选择依赖下面描述的模型，基于实验数据。推进器动力学模型被提议为图 2-9 中所示的两个块表示。第一个模块是电子速度控制器 (ESC) 和无刷电机模块，它根据油门信号 τ 和电池电压 V batt 产生螺旋桨的旋转 ωp 。第二个块代表螺旋桨，给定它的旋转速度 ωp 和流入速度 vin 产生推力 T 和扭矩Q.每个推进器由一个ESC BeeRotor BS20A、一个BL280 2600KV电动机和一个直径125mm、螺距值75mm的螺旋桨组成。 请参阅附录表 F.1。同一个模型描述了每个推进器，具有自己的流入速度、角速度和油门信号，尽管电池电压对两个推进器来说是通用的，因为它们并联连接到同一个电池。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a25.png)

螺旋桨角速度 ωp 被建模为 Vbatt 和 τ 的经验函数，并将在第 2.5.1 节中讨论.知道螺旋桨角速度 ωp 和流入速度 vin ，就可以按如下方式计算螺旋桨推力和扭矩。 首先，推进比J计算为流入速度与螺旋桨叶尖速度的比率。 使用 UIUC(29)的定义：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a26.png)

其中 rp 是螺旋桨的半径。然后，推力系数 C T 和功率系数 C P 被建模为和 J相关的函数。这两个系数的模型将在第 2.5.1 节中描述。最后，推力 T 和扭矩 Q 计算如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a27.png)

左右推进器的模型相同.


### 2.3.7 地面接触动力学(忽略)


### 2.4 简化的分析空气动力学模型


图 2-11：简化的空气动力学模型图。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a28.png)

与高保真模拟器不同，本研究中开发的控制器需要一个描述飞机空气动力学的简化分析模型。在图 2-11 中，该函数需要对左右油门信号 τl 、τr 以及左右升降舵偏转 δl 、δr 与车身力矩 MB = [L, M, N] T 的关系进行建模和前向力 F。

为了将这个模型中评估的变量与更精确模型中的变量区分开来，我们使用overhat 表示法来表示估计。 例如，M̂表示简化模型中的俯仰力矩。向前推力估计为左右推力的总和：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a29.png)

其中 T l 和 T r 是使用图 2-9 中描述的推进器模型从 τ l 和 τ r 评估的。偏航力矩估计为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a30.png)

其中 l 是右侧推进器在机身框架中的横向位置。roll力矩 L̂ 假定为滑流中升降舵产生的横摇力矩、滑流外升降舵产生的横摇力矩和螺旋桨扭矩之和：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a31.png)

其中 cx 是考虑到滑流中升降舵的横摇力矩偏转系数，bx 是考虑到滑流外升降舵的横摇力矩偏转系数，Q l 和 Q r 是根据推进器模型评估的左右螺旋桨扭矩 图 2-9，ρ是空气密度，u 和 w 是飞机沿 x B 和 z B 轴的速度，vl、vr 是使用动量理论建模的左右滑流速度：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a32.png)

其中 rp 是螺旋桨的半径。

类似地，俯仰力矩假定为滑流中升降舵产生的俯仰力矩、滑流外升降舵产生的俯仰力矩和零偏转时的俯仰力矩之和。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a33.png)

式中 cy 为滑流内升降舵的俯仰力矩偏转系数，b y 为滑流外升降舵的俯仰力矩偏转系数。  M̂ 0 是整个飞机在零偏转时的估计俯仰力矩，它是攻角和飞机速度的函数。  M̂ 0 在附录 D 中描述。弯矩挠度系数 c x 、c y 、b x 和 b y 将在第 2.5.3 节中评估。

出于压实目的，XZ 动态压力 P d = 2/1 ρ(uu + ww) 以及等式 2.39 中定义的左右滑流速度可以代入等式 2.38 和 2.40。 我们最终得到以下描述简化分析空气动力学模型的方程组：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a34.png)

这个简化的模型将在第 3.2.4 节中使用，其中控制器必须确定控制偏转以用于获得所需的控制力矩和力。


### 2.5 测量


本节描述了为补充模拟器模型而进行的测量。 第一个实验测量了安装在力扭矩传感器上的推进器的推进器系数。 第二个实验测量了作为 PWM 命令信号的函数的升降舵偏转角。 第三个实验旨在通过将整个飞机安装在力扭矩传感器上来测量滑流中控制面的有效性。


### 2.5.1 推进器系数


本节报告了为定义推进器模型而进行的实验，如第 2.3.6 节所述。 首先，提出了一种用于电调和电机的模型，用于根据电池电压和油门信号估计螺旋桨的角速度。

为了测量 ESC 和电机特性，将整个带螺旋桨的推进器固定在静态表面上。 首先，将 ESC 校准为使用脉冲宽度调制信号 (PWM)，高时间范围为 1000 [μs] 至 2000 [μs]。 在这种情况下，范围从 0 到 1 的油门 τ 与以 [μs] 为单位的 PWM 高电平时间 PW M h 相关为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a35.png)

使用直流电源 HY3005F-3 为电调提供电压。 油门信号被转换为发送到 ESC 的 PWM 信号。 螺旋桨的角速度是从示波器 Hantek DSO5102B 中获取的，该示波器测量了无刷电机两相之间的差频。 该测量由光学 RPM 传感器 Hangar 9 HAN156 验证，该传感器不太准确，但提供了示波器测量的交叉检查。

测量不同电压和油门信号的螺旋桨角速度，提供图 2-12 所示的数据点。为了更好的理解电池电压的影响，每个电压下的数据点被缩放为该电压的函数。结果发现，当它们按 Vbatt0.8 缩放时，不同电压下的数据大约折叠到一条线上。 然后使用二阶多项式对这条线进行曲线拟合，得到以下模型：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a36.png)

带有记录数据的模型如图 2-12 所示。 公式 2.43 用于填补前面描述的公式 2.29 的作用。图 2-12：在不同电池电压 V batt 下，角速度 ω p 作为油门 τ 的函数。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a37.png)

为了评估推力系数 CT 和功率系数 CP ，需要进行风洞实验来估计它们作为流入速度 vin 的函数，或者等效地作为提前比 J 的函数。而不是进行我们自己的风洞实验，我们首先在零流入速度 (J = 0) 下进行实验，并依靠外部风洞测量来完成非零 J 的模型。

电机向上安装在力扭矩传感器 ATI mini40 校准的 SI-20-1 上，能够测量高达 20N 的力和高达 1 Nm 的扭矩，参见图 2-13。 在此设置中，由于电机直径大于安装杆直径，因此假设安装件的阻力可以忽略不计。推力T和扭力Q可以被传感器直接测量：

T = Fz

Q = Mz         2.44

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a38.png)

安装设备的工作台可能会对测得的推力产生影响。  Cheeseman 和 Bennett(31)提出了一个基于功率守恒的方程来估计这种影响。 他们预测由地面效应引起的推力的增加为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a39.png)

在本实验中，r p = 62.5mm是螺旋桨半径，z = 258.5mm是螺旋桨在地面以上的位置。 公式 2.45 预测推力增加 0.37%，因此假设这种影响可以忽略不计。

螺旋桨推力 T 和扭矩 Q 在不同螺旋桨角速度 ωp 下记录。 然后，使用以下方法获得静态推力和功率系数：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a40.png)

其中 ρ 是环境空气密度，而 rp 是螺旋桨的半径。 这些系数随ωp 的变化如图2-14 所示:

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a41.png)

图 2-14：角速度的静态螺旋桨系数函数。  C T,l , C T,r 和 C T,GWS 是我们实验中左右螺旋桨的静推力系数，以及数据库中的GWS螺旋桨。 类似地，CP,l 、CP,r 和CP,GWS 是静态功率系数。

角速度的测量推力和功率系数函数与来自 UIUC 数据库的螺旋桨进行了比较(29)。 选择了具有相似系数平均值和趋势的螺旋桨：GWS Direct Drive 4.5x3 英寸。 其静态系数也如图 2-14 所示。 非零 J 值下的 GWS 螺旋桨推力和功率系数经过曲线拟合和缩放，以匹配我们实验中螺旋桨的静态系数。 所得螺旋桨系数作为提前比的函数如图 2-15 所示，如下所示：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a42.png)

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a43.png)

图 2-15：推力和功率系数模型，提前比的函数。

所使用的模型假设，在垂直下降期间出现的负提前比下，静态系数是有效的。 对于较小的负提前比率 (-0.3 < J < 0)，该假设得到了实验数据的验证(32)。


### 2.5.2 控制面偏转图(Control Surface Deflection Map)


为了对控制面建模，进行了测量以将归一化伺服信号 s 与偏转角 δ 联系起来。 随着伺服信号的变化，使用数字角度计（Capri Tools CP20005）测量偏转角。伺服电机的输入是脉冲宽度调制 (PWM) 信号，它由 Pixhawk 机载计算机生成。 对于该系统，PWM 高电平时间范围为 850 至 2150us。 从归一化伺服信号到 PWM 高电平时间的映射是线性的，对于右左升降舵给出如下：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a44.png)

其中 sl , sr 是范围从 -1 到 1 的归一化伺服信号，而 PWM h 是范围从 850 到 2150μs的 PWM 高电平时间。

相应的测量升降舵偏转如图 2-16 所示。观察到这种关系是线性和对称的，最大摆动幅度39°。因此，与偏转 δ 和伺服信号 s 相关的线性关系简单地由下式给出：

δl = sl δmax ,  δr = sr δmax         2.51

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a45.png)

### 2.5.3 控制面有效性


本节讨论为研究操纵面偏转 δ l 和 δ r 的影响而执行的测量。 整个飞机首先安装在力扭矩传感器上，以测量用于方程 2.41 中简化空气动力学模型的升降舵偏转系数 c x 和 c y。 在模拟器中进行了类似的测量，以测量 cx 、cy 、bx 和 by。

力/扭矩传感器的台架测试

实验装置如图 2-17 所示:

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a46.png)

图 2-17：控制面有效性测试台。 飞机的质心位于传感器原点上方距离 z 处。飞机的质心位于传感器原点上方距离 z = 0.236m处。 恒定的推力命​​令 τ 和电池电压 V batt 被施加到每个推进器。 根据之前介绍的推进器模型，这些对应于每个推进器的推力为 0.66N（大约为最大推力的三分之一）。 在这个推进器工作点和零升降舵偏转，力扭矩传感器归零。它导致传感器读取的力和力矩的差异为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a47.png)

其中 D 是由于螺旋桨下洗气流造成的飞机阻力，L 和 M 是飞机的横摇和俯仰力矩，假设仅由于操纵面偏转。 这些量之前的 ∆ 符号表示与归零工作点的差异。 因为两个推进器都以相同的转速运行，所以它们的扭矩抵消了。

参考简化模型，对于方程 2.41 给出的横摇力矩 L̂ 和俯仰力矩 M̂，并考虑到飞机是静态的（即动压 P d = 0）并且两个推力相等且恒定 Tl = Tr = T,在这种情况下可以使用以下关系：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a48.png)

通过对左右升降舵施加对称相反的偏转δl=-δr=δ，可以从扭矩传感器测得的滚动力矩 L 中检索出滚动力矩系数 cx 为 Mx ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a49.png)

类似地，俯仰力矩系数 cy 可以从由测量给出的俯仰力矩 M 中恢复为 M = zFx − My ，通过对升降舵应用对称和相等的偏转 δ l = δ r = δ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a50.png)

系数取为多次测量的平均值，如表 2-5 和 2-6 所示。 这些测量是有意在高挠度下进行的，以测量大力矩并避免达到传感器精度限制。 结果值为：

c x = 9.91 · 10 -4 [m 3 /rad]，c y = 4.74 · 10 -4 [m 3 /rad]     2.56

从下面俩个图可以看出来，roll指的就是多旋翼状态下的yaw。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a51.png)
![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a52.png)

模拟器中的台架测试

在模拟器中执行相同的程序以找到 c X 和 c y 系数，以便将它们与从力/扭矩传感器获得的值进行比较。考虑方程 2.38 和 2.40 的简化模型中的 L̂ 和 M̂ 并假设飞机是静态的（即 u = 0，w = 0），并且两个推进器都以相同的转速旋转（即 Q r = Q l 和滑流 vl  = vr = vs )，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a53.png)

对于模拟器中的以下测量，滑流速度设置为 v s = 1m/s，（推进器未运行且 vs 是硬编码的）。滚动系数 cx 可以通过施加相等和相反的挠度来获得，δ l = -δ r = δ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a54.png)

测量滚动力矩偏转系数，同时将偏转δ设置在从δ min 到δ max 线性间隔的10个不同位置δ i 。 求解 cx ，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a55.png)

结果数据点 cx,i 显示在图 2-18 中，cx 的值取自 10 次测量的平均值：  c x,sim = 2.35 · 10 −3 [m 3 /rad]        2.60

图 2-18：来自模拟器的滚动力矩偏转系数。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a56.png)

类似地，通过施加相等的挠度，可以得到俯仰力矩挠度系数cy，δ l = δ r = δ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a57.png)

测量俯仰力矩，同时将挠度 δ 设置在从 δ min 到 δ max 线性间隔的 10 个不同位置 δ i 。 求解 cy ，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a58.png)

数据点 cy,i 如图 2-19 所示，cy 的值取自 10 次测量的平均值：      c y,sim = 3.5 · 10 -4 [m 3 /rad]      2.63

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a59.png)

为了测量滑流bx 和by 之外的偏转力矩系数，建议考虑具有零迎角的流入风速u 且两个推进器未运行的飞机，然后可以通过知道cx 、cy 来提取bx 、by 。 考虑方程 2.38 和 2.40 的简化模型中的 L̂ 和 M̂，并假设 w = 0、v l = u、v r = u、Q r = 0 和 Q l = 0，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a60.png)

滚动系数 bx 可以通过施加相等和相反的挠度来获得，δ l = -δ r = δ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a61.png)

测量滚动力矩偏转系数，同时将偏转δ设置在从δ min 到δ max 线性间隔的10个不同位置δ i 。 求解 b x ，使用 cx = cx,sim ，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a62.png)

结果数据点 bx,i 显示在图 2-20 中，bx 的值取自 10 次测量的平均值：   b x,sim = 2.22 · 10 -3 [m 3 /rad]      2.67

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a63.png)

俯仰系数 b y 可以通过施加相等的挠度来获得，δl = δr = δ：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a64.png)

测量俯仰力矩偏转系数，同时将偏转δ设置在从δ min 到δ max 线性间隔的10个不同位置δ i 。 求解 b y ，使用 cy = cy,sim ，我们得到：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a65.png)

数据点 by,i 显示在图 2-21 中，by 的值取自 10 次测量的平均值：    by,sim = 2.57 · 10 -4 [m 3 /rad]       2.70

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a66.png)

模拟器中的 cx 值约为测量值的 2.5 倍，而模拟器中的 cy 值低约 25%，表明操纵面对俯仰力矩更有效对roll力矩影响更少。在实际飞行中，与在模拟器中完成相同的机动相比，观察到回旋机动更快，而观察到的滚转机动要慢得多。测量值和模拟值之间的这种巨大差异可能是由于模型中的假设造成的，例如动量理论用于预测升降副翼上的滑流，以及假设机翼轮廓采用平板这一事实。测量值被认为比模拟系数值更能代表真实的空气动力学。

知道 cx,sim , cy,sim 的模拟值与 cx , cy 的实验值之间的差异，选择使用以下 bx 和 by 值：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a67.png)

其中，乘以实验值与模拟值的比率有望捕捉到差异。 换句话说，对于滑流外和滑流中的升降舵效率，假定相同的差异比。 控制器使用的控制导数系数 cx 、cy 、bx 和 by 的值汇总在附录 H 表 H.1 中。

模拟器修改

为了利用实验测量来改进模拟器，我们选择按 c x /c x,sim 缩放由于偏转引起的滚动力矩和由于偏转引起的俯仰力矩 c y /c y,sim 。为此，计算给定升降舵偏转时的侧倾和俯仰力矩以及零偏转时的侧倾和俯仰力矩，并将所选力矩设置为：

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a68.png)

缩放的效果如图 2-22 和 2-23 所示。 相对于使用真实平台进行手动飞行测试，减少滚动力矩大大提高了模拟器的保真度。 缩放俯仰力矩的效果似乎对图 2-23 中的曲线没有很大影响，但它对观察到的机动有重大影响。 例如，饱和升降舵偏转时的后过渡距离减少了约 40%。

图 2-22：滚动力矩系数以蓝色显示，未缩放，在偏转效应按 c x /c x,sim 缩放后显示为黑色。  δ l = δ max , δ r = δ min 处的力矩用纯线表示，δ l = δ min , δ r = δ max 处的矩用虚线表示。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a69.png)

图 2-23：俯仰力矩系数以蓝色显示，未缩放，在偏转效应按 c y /c y,sim 缩放后显示为黑色。 最小挠度处的力矩用普通线表示，最大挠度处的力矩用虚线表示。

![IMAGE ALT TEXT HERE](https://github.com/xdwgood/Navigation-and-control/blob/xdwgood-patch-1/a70.png)


## 第三部分：控制策略
