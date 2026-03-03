// pulp-kernel -- hardware drivers, scheduling, and system core
//
// generic over AppLayer; never imports concrete apps or fonts.
// ships a built-in mono font (FONT_6X13) for boot console and
// sleep screen. distros bring their own proportional fonts.

#![no_std]

extern crate alloc;

pub mod board;
pub mod drivers;
pub mod kernel;
pub mod ui;
