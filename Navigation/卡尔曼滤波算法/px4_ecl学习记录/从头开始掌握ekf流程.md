# 使用的版本：v1.11.0-rc3

# 按照我的能力，记录学习ekf过程，力争全面理解，但不会重复简单的流程

### 针对多旋翼版本！！！

1:注册并启动ekf进程/任务： `int Ekf2::task_spawn(int argc, char *argv[])`,实例化EKF`Ekf2 *instance = new Ekf2(replay_mode)`,实例化具体完成，把任务存放到指定工作队列中`nav_and_controllers`并初始化相关参数。

２：完成实例化后，进行初始化`bool Ekf2::init()`,检查imu状态,可以通过参数`_param_ekf2_imu_id`指定imu，如果不指定则由`sensor_combined`决定，如果失败则反复运行，每隔一秒`ScheduleDelayed(1_s); // retry in 1 second`.顺利则返回真。

３：运行`void Ekf2::Run()`开始循环，将一段时间内的imu数据传递给`imu_sample_new`(转化为秒单位，所以`1.e-6f`).并检查加速度器是否存在**削波（传感器测量值超过或等于最大量程时的情况）**现象`if (imu.delta_velocity_clipping > 0) {`

４：检查是否有传感器切换`if (_sensor_selection_sub.updated() || (_sensor_selection.timestamp == 0)) {`，如有则对imu进行复位`if (_imu_bias_reset_request) {`第一次运行必先进行传感器复位。

**继续思考**为什么在`bool Ekf::reset_imu_bias()`函数中最后没有进行陀螺仪偏差的设置？？？

5:将imu数据推送给估计器内部。`_ekf.setIMUData(imu_sample_new);`该函数主要求解振动量，其中`_params.fusion_mode & MASK_USE_DRAG`因为默认参数为１，因此`setDragData()`将不会运行

６：读取地磁数据,并推送到ecl中`mag_sample_new.time_us -= FILTER_UPDATE_PERIOD_MS * 1000 / 2;`这是为什么？

7: 读取气压计数据并推送到ecl中，其中有对气压计高度进行补偿的函数`compensateBaroForDynamicPressure`,主要是根据估计的风速和计算出的风速差，得出空速误差，利用空速误差计算误差压强（这里用到的参数是），然后将误差补偿并修正高度

８：读取GPS数据，并允许双GPS。检查gps可用性`if (collect_gps(gps)) {`,检查gps质量`_gps_checks_passed = gps_is_good(gps);`如果飞机在静止状态下，会计算俩次gps读数之间的位置改变，并据此计算水平和垂直方向的速度漂移。其中`collect_gps`函数主要完成了，初始化坐标系、`_state.pos(2);`向下为负、查表法确定当前gps点对应的地磁数据。如果以上检查通过，则设置本地坐标系并计算local位置`map_projection_project(&_pos_ref, (gps.lat / 1.0e7), (gps.lon / 1.0e7), &lpos_x, &lpos_y);`

９：正式运行ekf`const bool ekf_updated = _ekf.update();`,首先检查是否滤波器已经初始化，如果没有初始化它。在初始化函数中除了必要的imu数据外，地磁和气压计数据也是不可缺少的，这里阻止了滤波器开始，如果没有气压计或地磁数据.在倾斜角度初始化中`initialiseTilt`,要求无人机相对静止，然后使用加速度传感器值估计初始pitch和roll角度，并使用该值初始化四元数。

10:`_control_status.flags.yaw_align = resetMagHeading(_mag_lpf.getState(), false, false);`该函数中调用了`resetQuatStateYaw`该函数将四元数旋转到新计算出来的航向值。并不是使用地磁数据增强角度估计。

11:初始化协方差`initialiseCovariance`

a:其中这个函数`initialiseQuatCovariances`,使用重力向量初始化后的四元数，计算出等效的旋转矢量，结合输入函数的旋转矢量方差`rot_vec_var`,对四元数协方差矩阵进行初始化。为什么不直接输入四元数方差？－－－是因为四元数物理意义不直观，转换为旋转矢量后输入函数的方差物理意义明确。求解是依据指定的matlab代码：１：计算转移矩阵Ｇ（从旋转向量到四元数的雅克比）２：已知旋转向量方差（`rotCovMat`）求四元数方差，即`quatCovMat = G*rotCovMat*transpose(G);`

b:初始化速度和位置，gyro,accel偏差，地磁和风速的方差，为什么没有初始化这些状态的协方差矩阵？？？

12:`increaseQuatYawErrVariance`调整四元数方差根据地磁不确定性，具体推导？？？

13:初始化地形估计器`_terrain_initialised = initHagl();`,并统一输出滤波

14:至此跳出`initialiseFilter`,执行`predictState`

1:使用当前角度变化计算出相应的四元数，然后四元数相乘得到预测的四元数。

2:预测速度和位置（考虑重力加速度影响，位置预测使用梯形积分）

15:预测协方差`predictCovariance`

1:计算各个状态的过程噪声，单独处理加速度过程噪声根据数据情况。

2:使用python代码预测协方差，增加过程噪声到预测的协方差中`nextP(i,i) = kahanSummation(nextP(i,i), process_noise(i), _delta_angle_bias_var_accum(index));`,其中地磁和风速添加过程噪声时的不需要使用Kahan求和是因为，这俩个状态的过程噪声不会比imu产生的噪声小很多



16:开始地磁融合`controlMagFusion`,

ａ：如果在飞行中复位yaw，则运行`has_realigned_yaw = resetMagHeading(_mag_lpf.getState())`,在这个函数中会使用yaw为０的角度重新计算一个旋转矩阵`R_to_earth`，然后将最新的地磁数据旋转到地球坐标系下并计算出新的`yaw_new`,然后使用新的yaw复位四元数`resetQuatStateYaw`,该函数计算出复位前后四元数误差`q_error`,并使用它再次调整四元数状态。

ｂ：`selectMagAuto`该函数根据是否能有足够的观测数据来选择使用哪种地磁融合方式。然后执行`runMagAndMagDeclFusions`函数正式开始执行地磁融合计算。从代码上看，３Ｄ地磁融合和头融合的主要区别是：前者会计算/调整地磁和地磁偏差状态＋四元数状态，后者只是调整四元数（证据：`SparseVector24f<0,1,2,3,16,17,18,19,20,21> Hfusion;`），因此当磁场干扰较小时，3d融合方法会让四元数更准确，反过来说地磁偏差得到计算也意味着抵抗地磁干扰能力增加？？？

ｃ：运行这个函数`run3DMagAndDeclFusions`,开始执行3d地磁融合。第一次运行会初始化地磁协方差，执行`fuseDeclination(0.02f);`融合计算磁偏角，首先将测量/观测值导入`	const float &magN = _state.mag_I(0);`推导流程参考**5磁偏观测**,然后计算更新值`atan2f(magE, magN) - getMagDeclination(),`,更新预测的状态`measurementUpdate`。之所以运行这个函数是因为这是求解航向必须的，`yaw_new = -atan2f(mag_earth_pred(1), mag_earth_pred(0)) + getMagDeclination();`

ｄ：融合地磁`fuseMag`,详细推导见**4地磁融合＋３**。运行４和３的脚本后，流程是:

1:首先计算地磁更新方差`_mag_innov_var`,运行4脚本得到ｘ轴的地磁更新方差`	_mag_innov_var(0) = HKX10*HKX20 - HKX11*HKX18 + HKX12*HKX22 + HKX13*HKX16 - HKX14*HKX19 + HKX15*HKX21 + HKX17*HKX6 + HKX23 + R_MAG;`.**why???**。在运行脚本３得到ｙ和ｚ的地磁更新方差`_mag_innov_var(1) = IV11*P(17,20) + IV11*(IV11*P(17,17).....`.如果这些方差过小/为负数，则停止融合计算。求地磁更新方差`	_mag_innov = mag_I_rot + _state.mag_B - _mag_sample_delayed.mag;`(预测值－测量值)

2:评估ekf工作效果`_mag_test_ratio(index) = sq(_mag_innov(index)) / (sq(math::max(_params.mag_innov_gate, 1.0f)) * _mag_innov_var(index));`,**Note**:使用革新值和革新值不确定度（方差）相除，是一种标准的评判手段。

3:计算Ｋ和Ｈ矩阵,并进行测量更新

e:运行`fuseHeading`,选择合适的选择顺序`shouldUse321RotationSequence`，**why???**(应该是分别代表俩个欧拉角，依据俩个欧拉角大小决定最佳选择顺序).计算预测的航向`const float predicted_hdg = getEuler321Yaw(_R_to_earth);`,计算通过测量值得到的航向`measured_hdg = -atan2f(mag_earth_pred(1), mag_earth_pred(0)) + getMagDeclination();`,融合计算`fuseYaw321(measured_hdg, R_YAW, fuse_zero_innov);`,推导详情参考２航向观测融合。最后更新四元数状态,并进行最终的融合。
