/*
 * This file is part of Cleanflight and Betaflight.
 *
 * Cleanflight and Betaflight are free software. You can redistribute
 * this software and/or modify this software under the terms of the
 * GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * Cleanflight and Betaflight are distributed in the hope that they
 * will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software.
 *
 * If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdint.h>
#include <platform.h>

#include "drivers/io.h"
#include "drivers/timer.h"
#include "drivers/dma.h"
#include "drivers/timer_def.h"

const timerHardware_t timerHardware[USABLE_TIMER_CHANNEL_COUNT] = {
    DEF_TIM(TIM8, CH3, PB9, TIM_USE_MOTOR,                   0), // PWM1
    DEF_TIM(TIM8, CH2, PB8, TIM_USE_MOTOR,                   0), // PWM2
    DEF_TIM(TIM3, CH4, PB1, TIM_USE_MOTOR,                   0), // PWM3
    DEF_TIM(TIM2, CH2, PA1, TIM_USE_MOTOR,                   0), // PWM4
    DEF_TIM(TIM2, CH3, PA2, TIM_USE_MOTOR,                   0), // PWM5
    DEF_TIM(TIM2, CH4, PA3, TIM_USE_MOTOR,                   0), // PWM6
    DEF_TIM(TIM2, CH1, PA0, TIM_USE_MOTOR,                   0), // PWM7
    DEF_TIM(TIM3, CH3, PB0, TIM_USE_MOTOR,                   0), // PWM8

    DEF_TIM(TIM1, CH1, PA8, TIM_USE_LED|TIM_USE_TRANSPONDER, 0), // LED
};
