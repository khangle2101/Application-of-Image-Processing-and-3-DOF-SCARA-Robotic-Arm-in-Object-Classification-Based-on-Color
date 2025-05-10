% Step 1: Create a webcam object
cam = webcam(1);  % Uses the default camera on your laptop
cam.Resolution = '1920x1080'; % Set camera resolution

% Step 2: Set up a figure to display the webcam feed
% figure;

% Step 3: Define the initial reference point (adjust when setting up the camera)
initial_point = [278, 47]; % Initial point on the image for 1920x1080 resolution

% Step 4: Define real-world dimensions of the camera's field of view
cam_height = 274;                               % Distance between camera and checkerboard (mm)
zoom_in = 1.0;                                  % Camera zoom ratio
width_in_mm = cam_height*1.3*(1/zoom_in);   % Width of the real-world area covered by the camera
height_in_mm = cam_height*0.75*(1/zoom_in); % Height of the real-world area covered by the camera

% Calculate scaling factors for converting pixels to meters
scale_x = width_in_mm / 1920; % Meters per pixel (horizontal)
scale_y = height_in_mm / 1080; % Meters per pixel (vertical)

% Step 5: Capture a frame from the webcam
img = snapshot(cam);  % Capture one frame

detected = int16(0);
color_detected = int16(0);