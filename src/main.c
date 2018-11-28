// Copyright (c) 2018 Sarun Rattanasiri
// under the MIT License https://opensource.org/licenses/MIT

#define STM8S103
#include "stm8s.h"

// the library is namespaced, name clashing hardly occurs
#define BUTTON_DEBOUNCE__CONFIRM 64
#include "button_debounce.h"

// configure callbacks
const ButtonDebounce_Config button_c3_debounce_config = {
    // "fell" event subscription
    .fell = &led_toggle,
    // apart from "fell"
    // there are "rose" and "state_changed" events
};
static ButtonDebounce_State button_c3_debounce_state;

int main() {
  uint8_t prescaler;

  // configure pins
  SetBit(GPIOB->DDR, 5);
  SetBit(GPIOB->ODR, 5);
  SetBit(GPIOC->CR1, 3);

  button_debounce__state_init(&button_c3_debounce_state);

#define _PRESCALER_DIVIDE_64 (64 - 1)

  for (prescaler = 0;; prescaler++) {
    // sampling the state of the button on pin C3
    if (!(prescaler & _PRESCALER_DIVIDE_64)) {
      button_debounce__sample(&button_c3_debounce_config,
                              &button_c3_debounce_state, ValBit(GPIOC->IDR, 3));
    }
  }
}

void led_toggle() {
  // toggle an LED on pin B5
  ChgBit(GPIOB->ODR, 5);
}
