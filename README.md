# embedded-dsp-streamer

![Build](https://github.com/makarpi/embedded-dsp-streamer/actions/workflows/stm32.yml/badge.svg)
[Latest release](https://github.com/makarpi/embedded-dsp-streamer/releases/latest)

An experimental real-time DSP streaming pipeline built using an Intel MAX10 FPGA, an STM32H745 microcontroller and an NXP i.MX8M Mini running Linux.  
The goal of this project is to explore high-throughput data acquisition across heterogeneous hardware and to visualize the resulting signals directly on an embedded display.

This repository contains:

- **FPGA (Intel MAX10)** — FIFO-based sample source exposed through a 32-bit FMC/SRAM-like interface  
- **STM32H745 (CM7)** — MDMA double-buffered (ping-pong) reads from FMC and raw UDP streaming using lwIP  
- **i.MX8M Mini (Linux/Yocto)** — UDP receiver and real-time plotting (waveform, FFT later) on DSI panel

The system forms a complete end-to-end data path for embedded signal processing, suitable for experimentation with higher-level DSP algorithms.

---

## Overview

### Real-time data flow

FPGA (MAX10)
   │
   │  32-bit FMC (SRAM-like, read-only)
   ▼
STM32H745 (CM7)
   │
   │  MDMA ping-pong
   │  lwIP raw UDP streaming (1472-byte frames)
   ▼
Ethernet 100M
   ▼
i.MX8M Mini (Linux/Yocto)
   │
   ├─ UDP receiver (Python or C)
   └─ Data processing + plotting (NumPy + matplotlib)

Display output:
   i.MX8M framebuffer / Wayland / Qt → DSI panel

The pipeline ends in Linux processing the UDP data.  
The DSI panel is simply the output device driven by the i.MX8M’s display subsystem.

## Current Status

✅ FMC interface concept  
✅ Basic MDMA ping-pong tests  
✅ UDP send/receive prototype  
✅ Minimal Python waveform plotter

⬜ FPGA FIFO integration  
⬜ Continuous full-rate streaming  
⬜ FFT + waterfall visualization  
⬜ System-level latency measurement  

The project is ongoing and will expand as the pipeline becomes more complete.

---

## License

MIT (will be added once the first functional components are complete)

If you have suggestions, ideas or improvements — feel free to open an issue.
