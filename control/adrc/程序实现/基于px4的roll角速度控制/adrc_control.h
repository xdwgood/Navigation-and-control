#pragma once

#include "adrc_control.h"

/****************************************************************************
 *
 *
 ****************************************************************************/
/*
 *  adrc_control.h
 *
 *  @author DaWeiXiong	<1308455330@qq.com>
 */

#include <float.h>
#include <math.h>
#include <lib/mathlib/mathlib.h>
#include <systemlib/param/param.h>
#include <uORB/topics/parameter_update.h>
#include <controllib/blocks.hpp>

/*
 * @class	Adrc_control
 * @brief	Multicopter advance control class
 */
class Adrc_Control: public control::SuperBlock
{
public:
	// Constructor
	Adrc_Control();
	// Destructor
	~Adrc_Control() = default;

	void adrc_control_init();
	void adrc_td_control(float &v1, float &v2, float setpoint, float ddt);
	void adrc_eso_control(float &z1, float &z2, float &z3, float last_u, float last_y);
	float adrc_nslef_control(float v1, float v2, float z1, float z2);
	float adrc_control_output_result(const float input_u0, const float z3);

	float adrc_nl_control_result(float v1, float v2, float z1, float z2, float z3);
	void adrc_leso_control(float &z1, float &z2, float &z3, float last_u, float last_y, float ddt);

protected:

	int		_params_sub;			/**< notification of parameter updates */

	int parameters_update(bool force);

	struct {
		param_t adrc_h0;
		param_t adrc_r;
		param_t adrc_h;
		param_t adrc_b01;
		param_t adrc_b02;
		param_t adrc_b03;
		param_t adrc_b0;
		param_t adrc_b1;
		param_t adrc_b2;
		param_t adrc_a1;
		param_t adrc_a2;
		param_t adrc_zeta;
	}		_params_handles;		/**< handles for interesting parameters */

	struct {
		float adrch0;
		float adrcr;
		float adrch;
		float adrcb01;
		float adrcb02;
		float adrcb03;
		float adrcb0;
		float adrcb1;
		float adrcb2;
		float adrca1;
		float adrca2;
		float adrczeta;
	} _params{};

private:

	float adrc_fhan(float v1, float v2, float r0, float h0);
	float adrc_fsun(float v1, float v2, float r0, float h0);
	float adrc_sign(float val);
	float adrc_sat(float x, float xgm);
	float Fal_ADRC(float e, float alpha, float zeta);

};
