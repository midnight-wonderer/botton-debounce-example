// Copyright (c) 2018 Sarun Rattanasiri
// under the MIT License https://opensource.org/licenses/MIT

#define STM8S103
#include "stm8s.h"

// it is a unconventional to include c directly without linking
// but this method suite the embedded system more IMHO
// this library design such that it is unlikely for name clashing
#define BUTTON_DEBOUNCE__CONFIRM 128
#include "button_debounce.c"

// configure callbacks
const ButtonDebounce_Config button_c3_debounce_config = {
    .falled = &led_toggle,  // here we subscribe to "falled" event
    // apart from "falled" there are "rised" and "state_changed"
};
static ButtonDebounce_State button_c3_debounce_state;

int main() {
  uint8_t prescaler;

  // configure pins
  SetBit(GPIOB->DDR, 5);
  SetBit(GPIOB->ODR, 5);
  SetBit(GPIOC->CR1, 3);

  button_debounce__state_init(&button_c3_debounce_state);

#define PRESCALER_DEVIDE_64 (64 - 1)
  for (prescaler = 0;; prescaler++) {
    // keep sample (poll) the state of the button and feed it to
    // the library
    if (!(prescaler & PRESCALER_DEVIDE_64)) {
      button_debounce__sample(&button_c3_debounce_config,
                              &button_c3_debounce_state, ValBit(GPIOC->IDR, 3));
    }
  }
}

// subscribe to the event
void led_toggle() {
  // we just toggle an LED on pin B5 here
  ChgBit(GPIOB->ODR, 5);
}
