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

16:检查垂直acc，并选择高度源执行垂直方向速度和位置复位`controlHeightSensorTimeouts`

16:开始地磁融合`controlMagFusion`,

ａ：如果在飞行中复位yaw，则运行`has_realigned_yaw = resetMagHeading(_mag_lpf.getState())`,在这个函数中会使用yaw为０的角度重新计算一个旋转矩阵`R_to_earth`，然后将最新的地磁数据旋转到地球坐标系下并计算出新的`yaw_new`,然后使用新的yaw复位四元数`resetQuatStateYaw`,该函数计算出复位前后四元数误差`q_error`,并使用它再次调整四元数状态。

ｂ：`selectMagAuto`该函数根据是否能有足够的观测数据来选择使用哪种地磁融合方式。然后执行`runMagAndMagDeclFusions`函数正式开始执行地磁融合计算。从代码上看，３Ｄ地磁融合和头融合的主要区别是：前者会计算/调整地磁和地磁偏差状态＋四元数状态，后者只是调整四元数（证据：`SparseVector24f<0,1,2,3,16,17,18,19,20,21> Hfusion;`），因此当磁场干扰较小时，3d融合方法会让四元数更准确，反过来说地磁偏差得到计算也意味着抵抗地磁干扰能力增加？？？

ｃ：运行这个函数`run3DMagAndDeclFusions`,开始执行3d地磁融合。第一次运行会初始化地磁协方差，执行`fuseDeclination(0.02f);`融合计算磁偏角，首先将测量/观测值导入`	const float &magN = _state.mag_I(0);`推导流程参考**5磁偏观测**,然后计算更新值`atan2f(magE, magN) - getMagDeclination(),`,更新预测的状态`measurementUpdate`。之所以运行这个函数是因为这是求解航向必须的，`yaw_new = -atan2f(mag_earth_pred(1), mag_earth_pred(0)) + getMagDeclination();`

ｄ：融合地磁`fuseMag`,详细推导见**4地磁融合＋３**。运行４和３的脚本后，流程是:

1:首先计算地磁更新方差`_mag_innov_var`,运行4脚本得到ｘ轴的地磁更新方差`	_mag_innov_var(0) = HKX10*HKX20 - HKX11*HKX18 + HKX12*HKX22 + HKX13*HKX16 - HKX14*HKX19 + HKX15*HKX21 + HKX17*HKX6 + HKX23 + R_MAG;`.**why???**。在运行脚本３得到ｙ和ｚ的地磁更新方差`_mag_innov_var(1) = IV11*P(17,20) + IV11*(IV11*P(17,17).....`.如果这些方差过小/为负数，则停止融合计算。求地磁更新方差`	_mag_innov = mag_I_rot + _state.mag_B - _mag_sample_delayed.mag;`(预测值－测量值)

2:评估ekf工作效果`_mag_test_ratio(index) = sq(_mag_innov(index)) / (sq(math::max(_params.mag_innov_gate, 1.0f)) * _mag_innov_var(index));`,**Note**:使用革新值和革新值不确定度（方差）相除，是一种标准的评判手段。

3:计算Ｋ和Ｈ矩阵,并进行测量更新

e:运行`fuseHeading`,选择合适的选择顺序`shouldUse321RotationSequence`，**why???**(应该是分别代表俩个欧拉角，依据俩个欧拉角大小决定最佳选择顺序).计算预测的航向`const float predicted_hdg = getEuler321Yaw(_R_to_earth);`,计算通过测量值得到的航向`measured_hdg = -atan2f(mag_earth_pred(1), mag_earth_pred(0)) + getMagDeclination();`,融合计算`fuseYaw321(measured_hdg, R_YAW, fuse_zero_innov);`,推导详情参考２航向观测融合。最后更新四元数状态,并进行最终的融合。

17:开始执行gps融合`controlGpsFusion`,第一次运行会执行`startGpsFusion`函数，这个函数会复位水平位置以及水平＋垂直方向的速度。不考虑其它位置信息源和来自gps的yaw。其中`else if (do_vel_pos_reset) {`这里的复位是针对有gps数据但因为质量等问题没有被融合使用，如果gps数据消失则在这里停止gps融合` (_control_status.flags.gps && (_imu_sample_delayed.time_us - _gps_sample_delayed.time_us > (uint64_t)10e6)) {`,再次恢复后会在`if (_control_status.flags.tilt_align && _NED_origin_initialised && gps_checks_passing) {`这里执行位置速度复位。在飞机正常运行时通常在这里运行`Only use GPS data for position and velocity aiding if enabled`.首先进行机体坐标系下的位置补偿`pos_offset_body = _params.gps_pos_body - _params.imu_pos_body;`，这一步的意义是将gps测量速度、位置同步到imu坐标点，因为预测的速度状态是gyro一段时间积分得到的，因此要在一个坐标系下。

**思考**：速度补偿为什么这样计算???`vel_offset_body = _ang_rate_delayed_raw % pos_offset_body;`

开始执行水平速度融合`fuseHorizontalVelocity`,注意在`fuseVelPosHeight`函数中的`KHP(row, column) = Kfusion(row) * P(state_index, column);`Ｈ为1×24向量，并且各个值为１。这是因为测量值就是预测的状态值，因此测量传递矩阵为１。最后执行融合更新`fuse(Kfusion, innov);`

18:开始高度融合`controlHeightFusion`,在这里我们不使用rng高度辅助，并选择气压计高度`vdist_sensor_type`,正常情况下执行这里`startBaroHgtFusion();`,该函数完成使用气压计高度标志位设置和地效影响是否关闭。正式开始高度融合`_baro_hgt_innov(2) = _state.pos(2) + _baro_sample_delayed.hgt - _baro_hgt_offset;`,融合气压计高度`fuseVerticalPosition(_baro_hgt_innov....`.**小总结**：无论是高度还是速度的融合，内部的状态是根据imu数据计算出来的，观测数据是gps、baro。所以在ekf中的imu数据只是在预测阶段被使用。

19:如果gps正常，不会执行`controlFakePosFusion`函数，该函数的作用是限制位置估计，不会让位置估计在没有gps情况下估计的太不合理`_gps_pos_innov.xy() = Vector2f(_state.pos) - _last_known_posNE;`



# 补充一些面试问题

１：ekf里面是如何估计陀螺仪和加速度偏差的？

答：实际上实在协方差预测的时候，计算了以上俩个偏差。正如python脚本展示的一样，偏差被作用到预测状态中`d_ang_true = d_ang - d_ang_b`,初始化时候会给定gyro/acc的初始值（不为０）。在计算过程转移矩阵(Ａ/Ｆ)的时候，由于偏差已经作用到`state_new`,因此在协方差传递公式`P_new = A * P * A.T + G * var_u * G.T`中也包含了偏差方差的传递。在３Ｄ地磁融合中(会在python脚本中计算好卡尔曼增益)`Kfusion(row) = HKX24*(HKX10*P(row,17) - HKX11*P(row,18) + HKX12*P(1,row) + HKX13*P(0,row) - HKX14*P(2,row) + HKX15*P(3,row) + HKX6*P(row,16) + P(row,19));`这里的Ｐ矩阵即是在协方差预测矩阵中计算出来的，得到gyro/acc的偏差卡尔曼增益后，乘上相应的更新（在这里是地磁更新）得到新的偏差状态`_state.delta_ang_bias -= K.slice<3, 1>(10, 0) * innovation;`.在`fuseVelPosHeight`中计算的`Kfusion(row) = P(row, state_index) / innov_var;`(因为该状态固定`state_index`)相应gyro和acc偏差的结果为０．因此不产生影响对gyro/acc偏差估计。