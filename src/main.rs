#![no_std]
#![no_main]
#![allow(clippy::unwrap_used)]

use cortex_m_rt::entry;
use nrf52840_hal as hal;
use hal::gpio::*;
use hal::pac;
use hal::prelude::*;
use hal::Delay;

use panic_halt as _;

#[entry]
fn main() -> ! {
    // Take peripherals
    if let Some(p) = pac::Peripherals::take() {
        // Configure GPIO pins
        let pins = hal::gpio::p0::Parts::new(p.P0);
        let mut led = pins.p0_24.into_push_pull_output(Level::High).degrade();

        // Initialize delay provider
        let mut delay = Delay::new(p.SYST);

        loop {
            // Toggle LED every second
            led.toggle().unwrap();
            delay.delay_ms(1000u32);
        }
    }

    loop {}
}
