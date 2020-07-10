### 这是px4姿态控制器中截取的代码片段，用于说明非线性adrc具体使用,可以直接添加替换原px4程序。

### 在gazebo仿真中已经取得了成功（2019年），但真实飞行效果不能使用，我怀疑是ｂ没有选择正确


```
/* angular rates error */
math::Vector<3> rates_err = _rates_sp - rates;

_att_control = rates_p_scaled.emult(rates_err) +
		       _rates_int +
		       rates_d_scaled.emult(_rates_prev - rates) / dt +
		  _params.rate_ff.emult(_rates_sp);

_rates_sp_prev = _rates_sp;
_rates_prev = rates;

_adrc_control->adrc_td_control(v1, v2, _rates_sp(0), dt);
_adrc_control->adrc_leso_control(z1, z2, z3, adrc_setpoint, rates(0), dt);
_att_control(0) = _adrc_control->adrc_nl_control_result(v1, v2, z1, z2, z3);
adrc_setpoint = _att_control(0);

```

