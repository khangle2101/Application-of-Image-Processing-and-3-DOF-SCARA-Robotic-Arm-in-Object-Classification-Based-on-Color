# 🤖 Application of Image Processing and 3-DOF SCARA Robotic Arm in Object Classification Based on Color

An academic project that combines **Computer Vision**, **Robotics**, and **Embedded Systems** to build a real-time sorting system. The system detects object color (Red, Yellow, Blue), computes the inverse kinematics of a 3-DOF SCARA robotic arm, and sorts the object using an electromagnetic gripper.

---

## 📌 Key Features

- 🎨 Detects and classifies colors using HSV thresholding in MATLAB  
- 📷 Captures live video using smartphone camera via DroidCam  
- 📐 Converts pixel coordinates to real-world positions using checkerboard calibration  
- ⚙️ Computes inverse kinematics and sends angles to Arduino  
- 🤖 SCARA robot performs pick-and-place actions with high precision  
- 🖥️ Controlled via MATLAB GUI (App Designer) with workspace visualization  
- ⚡ Gripper control + emergency reset handled via serial commands

---

## 🛠 Hardware Components

| Component              | Description                          |
|------------------------|--------------------------------------|
| SCARA Arm              | Custom-built 3-DOF robotic arm       |
| Controller             | Arduino UNO R3 + CNC Shield V3       |
| Stepper Motors         | 3× NEMA 17 + A4988 drivers           |
| Gripper                | 24V Electromagnetic                  |
| Camera                 | Smartphone camera via DroidCam       |
| Frame Design           | SolidWorks 3D Model (`FullRobot.STEP`)

---

## 💻 Software & Algorithms

| Module                 | Implementation / File                |
|------------------------|--------------------------------------|
| Image Processing       | `detect_pos.m`, `setup_cam.m`        |
| Color Detection (HSV)  | `detect_pos.m`                       |
| Position Calibration   | `cal_pos.m`, `TransMatrix.m`         |
| Inverse Kinematics     | `IK.m`, `ik_2dof.m`                  |
| Forward Kinematics     | `fk_3dof.m`, `FK_control.m`          |
| Control GUI            | `gui_test.mlapp`                     |
| Workspace Simulation   | `Workspace.m`                        |
| Gripper & Reset        | `Magnet.m`, `Reset_button.m`         |
| Stepper Control (Arduino) | `control_stepper_4_step.ino`     |

---

## 📂 Project Structure
```
├── Arduino/
│ └── control_stepper_4_step.ino # Stepper motor & gripper control
│
├── MATLAB_Code/
│ ├── gui_test.mlapp # MATLAB App Designer GUI
│ ├── detect_pos.m, setup_cam.m # Color detection + calibration
│ ├── cal_pos.m, TransMatrix.m # Position conversion
│ ├── IK.m, ik_2dof.m # Inverse kinematics (3DOF & 2DOF)
│ ├── fk_3dof.m, FK_control.m, basic_01.m
│ ├── Magnet.m, Reset_button.m # Gripper + safety control
│ ├── control_test.m # Full motion sequence
│ └── Workspace.m # Plot workspace reach
│
├── CAD/
│ └── FullRobot.STEP # 3D model (SolidWorks)
│
├── Demo/
│ ├── Video_demo.mp4
│ └── Hệ thống trước khi chạy.jpg
│
├── Robot Project Report.pdf # Full project documentation
└── README.md
```

---

## ⚙️ How It Works

1. 📸 Live image captured from camera via DroidCam  
2. 🎯 Object color segmented via HSV threshold (`detect_pos.m`)  
3. 📐 Pixel → mm conversion via checkerboard (`setup_cam.m`, `cal_pos.m`)  
4. 🧠 Inverse kinematics computed in MATLAB → joint angles  
5. 🔌 Angles sent to Arduino over serial → stepper motors activated  
6. 🧲 Electromagnet controlled for pick and release  
7. 🖱️ All steps are coordinated through a user-friendly GUI

---

## ▶ Demo
This short video demonstrates the real-time object classification and sorting system using a 3-DOF SCARA robotic arm, controlled via MATLAB and Arduino.

[![Watch Demo](https://img.youtube.com/vi/8Hgz4ZEQ1kY/0.jpg)](https://youtube.com/shorts/8Hgz4ZEQ1kY)

---

## 📊 Performance

| Metric                  | Result                          |
|--------------------------|---------------------------------|
| Color detection accuracy | 100% (under controlled lighting)|
| Sorting success rate     | ~95%                            |
| Positioning error margin | ~2–4 mm                         |

---

## 🧠 Team Members

- **Lê Hoàng Khang** – 21151022 – HCMUTE  
- **Dương Hoàng Khôi** – 21151027 – HCMUTE

---

## 📄 License

This project is developed for academic purposes as part of the university robotics coursework.  
Not intended for commercial use.


