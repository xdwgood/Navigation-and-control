/****************************************************************************
 *
 ****************************************************************************/

/**
 * @file adrc_control_params.c
 * Adrc controller parameters.
 *
 * @author Anton xdwgood(github)
 */

/**
 * TD filter factor
 * According to the simulation experience, take the appropriate number of h. We will take 2 for the time being.
 *
 * Adrc control param1
 *
 * @unit norm
 * @min -1000.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_H0, 3.0f);

/**
 * TD adjustment speed coefficient
 * The larger the value, the faster the overprocessing
 *
 * @unit norm
 * @min 1.0
 * @max 10000.0
 * @decimal 2
 * @increment 1
 */
PARAM_DEFINE_FLOAT(ADRC_R, 5000.0f);

/**
 * TD sampling step size
 * Control frequency correlation???
 *
 * @unit norm
 * @min -1000.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_H, 0.005f);

/**
 * ESO tunable parameters to determine model estimation
 *
 * @unit norm
 * @min 0.0
 * @max 1000.0
 * @decimal 2
 * @increment 1
 */
PARAM_DEFINE_FLOAT(ADRC_B01, 200.0f);

/**
 * ESO tunable parameters to determine model estimation
 *
 * @unit norm
 * @min 0.0
 * @max 10000.0
 * @decimal 2
 * @increment 1
 */
PARAM_DEFINE_FLOAT(ADRC_B02, 1767.0f);

/**
 * ESO tunable parameters to determine model estimation
 *
 * @unit norm
 * @min 0.0
 * @max 200000.0
 * @decimal 2
 * @increment 1
 */
PARAM_DEFINE_FLOAT(ADRC_B03, 13420.0f);

/**
 * ESO input feedback factor to determine feedback
 *
 * @unit norm
 * @min -1000.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_B0, 2f);

/**
 * NLSEF
 * Disturbance compensation
 * @unit norm
 * @min -1000.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */

PARAM_DEFINE_FLOAT(ADRC_B1, 10.0f);
/**
 * NLSEF
 *
 * @unit norm
 * @min -1000.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_B2, 0.01f);

/**
 * NLSEF
 * Proportional link, principle: small error using large gain, generally take 0.0----1.0
 * @unit norm
 * @min -1.0
 * @max 10.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_A1, 0.8f);

/**
 * NLSEF
 * Differential link, principle: Differential error Small differential gain is small, generally greater than 1.0
 * @unit norm
 * @min -1.0
 * @max 1000.0
 * @decimal 2
 * @increment 0.001
 */
PARAM_DEFINE_FLOAT(ADRC_A2, 1.5f);

/**
 * NLSEF
 * Find the third parameter of fal(param1,param2,param3) in the final output formula
 * @unit norm
 * @min 0.0
 * @max 1000.0
 * @decimal 2
 * @increment 1.0
 */
PARAM_DEFINE_FLOAT(ADRC_ZETA, 50.0f);
