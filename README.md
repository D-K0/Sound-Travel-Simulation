# Sound Travel Simulation

**Course:** ESC203 — Advanced Simulation in the Natural Sciences  
**Authors:** Diana Korotun, Harshita Gupta  
**Date:** June 2, 2025  

---

## 📘 Project Overview

This project explores the **simulation of sound propagation** using two complementary computational methods:

1. **Wave Equation Solution (Finite Difference Method)**
2. **Ray Tracing Simulation**

The goal is to model and compare how a **single sound pulse at 440 Hz** travels through different media (air and water), accounting for **reflections** and **absorptions** at boundaries and material interfaces.

---

## 🧪 Simulation Setup

- **Sound Source:** Single pulse, 440 Hz frequency  
- **Media:** Air and Water  
- **Phenomena Modeled:**  
  - Reflection and absorption  
  - Interface behavior between different materials  
- **Numerical Methods:**  
  - Finite Difference solution of the 2D wave equation  
  - Ray tracing with energy loss  
- **Stability Condition:** Courant–Friedrichs–Lewy (CFL) criterion  

---

## ⚙️ Implementation Details

### Wave Equation Method
- Implemented using **finite difference discretization** of the 2D acoustic wave equation.
- Stability ensured using the **CFL condition**.
- Simulations performed for:
  - Entire domain filled with **air**
  - Entire domain filled with **water**
  - Mixed cases: bubble of air in water and vice versa
- Visualizations generated to show **wave propagation**, **boundary reflections**, and **CFL instability effects**.

### Ray Tracing Method
- Rays represent sound energy paths.
- Simulates **reflection**, **refraction**, and **attenuation** at boundaries.
- Enables comparison with full wave simulation for accuracy and computational efficiency.

---

## 🎧 Results

| Method | Description | Media | Visualization |
|:-------|:-------------|:-------|:---------------|
| Wave Equation | Full-field simulation of pressure waves | Air & Water | *See “Wave Equation – Final” results* |
| Ray Tracing | Geometric simulation of sound paths | Air & Water | [Ray Tracing Result](https://docs.google.com/file/d/1plHDgIZ5ZnLhKBkcBFW9beOi0yPYiRqd/preview) |

---

## 🧰 Repository Structure

