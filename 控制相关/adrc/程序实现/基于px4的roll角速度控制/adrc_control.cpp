#include "adrc_control.h"

//using namespace adrccontrol;
/****************************************************************************
 *
 *
 ****************************************************************************/
/*
 *
 *
 *  @author DaWeiXiong	<1308455330@qq.com>
 *
 */

// Constructor
Adrc_Control::Adrc_Control():
	SuperBlock(nullptr, "ADRC"),
	_params_sub(-1)
{
	_params_handles.adrc_h0	= param_find("ADRC_H0");
	_params_handles.adrc_r = param_find("ADRC_R");
	_params_handles.adrc_h = param_find("ADRC_H");
	_params_handles.adrc_b01 = param_find("ADRC_B01");
	_params_handles.adrc_b02 = param_find("ADRC_B02");
	_params_handles.adrc_b03 = param_find("ADRC_B03");
	_params_handles.adrc_b0	= param_find("ADRC_B0");
	_params_handles.adrc_b1	= param_find("ADRC_B1");
	_params_handles.adrc_b2	= param_find("ADRC_B2");
	_params_handles.adrc_a1	= param_find("ADRC_A1");
	_params_handles.adrc_a2	= param_find("ADRC_A2");
	_params_handles.adrc_zeta = param_find("ADRC_ZETA");
	parameters_update(true);
}

void Adrc_Control::adrc_control_init()
{
	_params_sub = orb_subscribe(ORB_ID(parameter_update));
}

int
Adrc_Control::parameters_update(bool force)
{
	bool updated = false;
	struct parameter_update_s param_upd;

	orb_check(_params_sub, &updated);

	if (updated) {
		orb_copy(ORB_ID(parameter_update), _params_sub, &param_upd);
	}

	if (updated || force) {
		/* update C++ param system */
		updateParams();

		float v;
		//int32_t v_i;
		param_get(_params_handles.adrc_h0, &v);
		_params.adrch0 = v;
		param_get(_params_handles.adrc_r, &v);
		_params.adrcr = v;
		param_get(_params_handles.adrc_h, &v);
		_params.adrch = v;
		param_get(_params_handles.adrc_b01, &v);
		_params.adrcb01 = v;
		param_get(_params_handles.adrc_b02, &v);
		_params.adrcb02 = v;
		param_get(_params_handles.adrc_b03, &v);
		_params.adrcb03 = v;
		param_get(_params_handles.adrc_b0, &v);
		_params.adrcb0 = v;
		param_get(_params_handles.adrc_b1, &v);
		_params.adrcb1 = v;
		param_get(_params_handles.adrc_b2, &v);
		_params.adrcb2 = v;
		param_get(_params_handles.adrc_a1, &v);
		_params.adrca1 = v;
		param_get(_params_handles.adrc_a2, &v);
		_params.adrca1 = v;
		param_get(_params_handles.adrc_zeta, &v);
		_params.adrczeta = v;
	}

	return OK;
}

float Adrc_Control::adrc_fhan(float v1, float v2, float r0, float h0)
{
	float d = r0 * h0;
	float d0 = h0 * d;
	float y = v1 + h0 * v2;
	float a0 = sqrtf(d * d + 8.0f * r0 * fabsf(y));
	float a = 0;

	if (fabsf(y) > d0) {
		a = v2 + ((a0 - d) * adrc_sign(y)) / 2.0f;

	} else {
		a = v2 + y / h0;
	}

	return -r0 * adrc_sat(a, d);
}

//根据文献《离散系统最速控制综合函数》，fhan函数不是二阶离散系统的最速控制综合函数，文献提出改进版本fsun函数
float Adrc_Control::adrc_sat(float x, float xgm)	//saturation function
{
	if (fabsf(x) > xgm) {
		return adrc_sign(x);

	} else {
		return x / xgm;
	}
}

float Adrc_Control::adrc_fsun(float v1, float v2, float r0, float h0)
{
	float y = v1 + h0 * v2;
	float k0 = 0.5f * (1.0f + sqrtf(1.0f + (8.0f * fabsf(y) / (h0 * h0 * r0))));
	float k = adrc_sign(k0 - (int)k0) + int(k0);

	if (fabsf(y) <= h0 * h0 * r0) {
		return -r0 * adrc_sat(v2 + y / h0, h0 * r0);

	} else {
		return -r0 * adrc_sat((1 - 0.5f * k) * adrc_sign(y) - ((v1 + k * h0 * v2 * v2) / ((k - 1) * h0 * h0 * r0)), 1.0f);
	}
}

float Adrc_Control::adrc_sign(float val)
{
	if (val > 0.0f) {
		return 1.0f;

	} else if (val < 0.0f) {
		return -1.0f;

	} else {
		return 0.0f;
	}
}

void Adrc_Control::adrc_td_control(float &v1, float &v2, float setpoint, float ddt)
{
	parameters_update(true);

	float fv = adrc_fhan((v1 - setpoint), v2, _params.adrcr, _params.adrch0 * ddt);

	v1 += ddt * v2;
	v2 += ddt * fv;
}

//原点附近有连线性段的连续幂次函数
// float Adrc_Control::Fal_ADRC(float e, float alpha, float zeta)
// {
// 	uint16_t s = 0;
// 	float fal_output = 0;
// 	s = (adrc_sign(e + zeta) - adrc_sign(e - zeta)) / 2;
// 	fal_output = e * s / (powf(zeta, 1 - alpha)) + powf(fabsf(e), alpha) * adrc_sign(e) * (1 - s);
// 	return fal_output;
// }

// Base fal function
float Adrc_Control::Fal_ADRC(float e, float alpha, float zeta)
{
	float fal_output = 0.f;

	if (fabsf(e) > zeta) {
		return fal_output = powf(fabsf(e), alpha) * adrc_sign(e);

	} else {
		return fal_output = e / powf(zeta, 1 - alpha);
	}

}

//非线性eso，参数调整比较困难
void Adrc_Control::adrc_eso_control(float &z1, float &z2, float &z3, float last_u, float last_y)
{
	const float e = z1 - last_y; //状态误差
	const float fe = Fal_ADRC(e, 0.5, (5.0f * _params.adrch)); //非线性函数，提取跟踪状态与当前状态误差
	const float fe1 = Fal_ADRC(e, 0.25, (5.0f *
					     _params.adrch)); //根据文献【基于adrc控制器的无刷直流电机调速系统的建模与仿真】，此函数选取第三个参数范围5h--10h

	/*************ESO state update**********/
	z1 += _params.adrch * (z2 - _params.adrcb01 * e);
	z2 += _params.adrch * (z3 - _params.adrcb02 * fe + _params.adrcb0 * last_u);
	z3 += _params.adrch * (-_params.adrcb03 * fe1);
}

//线性eso，适用3w法调整参数
void Adrc_Control::adrc_leso_control(float &z1, float &z2, float &z3, float last_u, float last_y, float ddt)
{
	float e = z1 - last_y; //状态误差
	int w = 1 / ddt;	//fs = 1 / dt

	z1 = z1 + ddt * (z2 - e * 3.0f * w);	//b01 = 3w
	z2 = z2 + ddt * (z3 - e * 3.0f * w * w + _params.adrcb0 * last_u); //b02 = 3w^2
	z3 = z3 - ddt * e * w * w * w;	//b03 = w^3

}

//线性输出
float Adrc_Control::adrc_nl_control_result(float v1, float v2, float z1, float z2, float z3)
{
	/********状态误差反馈率*************************************************************
	/fhan_Input->e0+=fhan_Input->e1*fhan_Input->h;状态积分项,在adrc控制中我们并不需要积分项*/
	const float e1 = v1 - z1;//状态偏差项
	const float e2 = v2 - z2;//状态微分项
	const float u0 = _params.adrcb1 * e1 + _params.adrcb2 * e2;
	const float u = u0 - (z3 / 6666.0f);

	return u;
}



float Adrc_Control::adrc_nslef_control(float v1, float v2, float z1, float z2)
{
	/********状态误差反馈率*************************************************************
	/fhan_Input->e0+=fhan_Input->e1*fhan_Input->h;状态积分项,在adrc控制中我们并不需要积分项*/
	const float e1 = v1 - z1;//状态偏差项
	const float e2 = v2 - z2;//状态微分项，
	float temp_e2 = math::constrain(e2, -3000.0f, 3000.0f);
	const float u0 = _params.adrcb1 * Fal_ADRC(e1, _params.adrca1, _params.adrczeta)
			 + _params.adrcb2 * Fal_ADRC(temp_e2, _params.adrca2, _params.adrczeta);
	return u0;

}

float Adrc_Control::adrc_control_output_result(const float input_u0, const float z3)
{
	float output = NAN;
	//非线性组合输出减去扰动（内+外扰动），得到抗干扰输出 U = U0 - Z3/B0
	return output = input_u0 - (z3 / _params.adrcb0);
}

