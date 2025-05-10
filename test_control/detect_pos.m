close all;
detected = 0;
color_detected = 0;
% Step 5: Capture a frame from the webcam
img = snapshot(cam);  % Capture one frame

% Step 6: Convert the image to the HSV color space
hsv_img = rgb2hsv(img);


% Step 7: Define HSV ranges for blue, red, and yellow
% Blue
blue_hue_min = 0.55;
blue_hue_max = 0.75;
blue_sat_min = 0.5;
blue_val_min = 0.3;

% Red (split across hue space: lower and upper range)
red_hue_min1 = 0.0;
red_hue_max1 = 11/360; % First range for red
red_hue_min2 = 351/360;
red_hue_max2 = 1.0; % Second range for red
red_sat_min = 0.7;
red_val_min = 0.1;

% Yellow
yellow_hue_min = 45/360;
yellow_hue_max = 64/360;
yellow_sat_min = 0.15;
yellow_val_min = 0.75;

% Step 8: Create binary masks for each color
blue_mask = (hsv_img(:,:,1) >= blue_hue_min & hsv_img(:,:,1) <= blue_hue_max) & ...
    (hsv_img(:,:,2) >= blue_sat_min) & (hsv_img(:,:,3) >= blue_val_min);

red_mask = ((hsv_img(:,:,1) >= red_hue_min1 & hsv_img(:,:,1) <= red_hue_max1) | ...
    (hsv_img(:,:,1) >= red_hue_min2 & hsv_img(:,:,1) <= red_hue_max2)) & ...
    (hsv_img(:,:,2) >= red_sat_min) & (hsv_img(:,:,3) >= red_val_min);

yellow_mask = (hsv_img(:,:,1) >= yellow_hue_min & hsv_img(:,:,1) <= yellow_hue_max) & ...
    (hsv_img(:,:,2) >= yellow_sat_min) & (hsv_img(:,:,3) >= yellow_val_min);

% Combine the masks
combined_mask = blue_mask | red_mask | yellow_mask;

% Step 9: Clean the binary mask using morphological operations
combined_mask = imopen(combined_mask, strel('disk', 7)); % Remove small objects
combined_mask = imclose(combined_mask, strel('disk', 5)); % Close small gaps

% Show each color mask to debug
figure(1); % Create a separate figure for debugging
subplot(2, 2, 1); imshow(img); title('Original Image');
subplot(2, 2, 2); imshow(blue_mask); title('Blue Mask');
subplot(2, 2, 3); imshow(red_mask); title('Red Mask');
subplot(2, 2, 4); imshow(yellow_mask); title('Yellow Mask');

% Step 10: Filter objects by size
min_area = 1000; % Minimum area of the object (adjust as needed)
max_area = 500000; % Maximum area of the object (adjust as needed)
labeled_mask = bwlabel(combined_mask);
stats = regionprops(labeled_mask, 'BoundingBox', 'Centroid', 'Area');

% Filter out regions that don't meet the size criteria
valid_stats = stats([stats.Area] >= min_area & [stats.Area] <= max_area);

% Step 11: Display the original image
figure
imshow(img);
hold on;

% Step 12: Draw the initial point
plot(initial_point(1), initial_point(2), 'r.', 'MarkerSize', 20); % Red dot at the initial point

% Step 13: Draw bounding boxes and calculate relative positions
objects_position_mm = [];
centroids = [];
for k = 1:length(valid_stats)
    % Get the bounding box and centroid coordinates
    bbox = valid_stats(k).BoundingBox;
    centroid = valid_stats(k).Centroid;

    % Calculate relative position in pixels
    relative_position_pixels = [centroid(1) - initial_point(1), centroid(2) - initial_point(2)];

    % Convert relative position to real-world units
    relative_position_mm = [-relative_position_pixels(1) * scale_x + 479, ...
        relative_position_pixels(2) * scale_y];

    % Extract the HSV values at the centroid
    centroid_x = round(centroid(1));
    centroid_y = round(centroid(2));
    hsv_value_at_centroid = hsv_img(centroid_y, centroid_x, :); % Extract HSV value at centroid
    hue = hsv_value_at_centroid(1); % Hue
    saturation = hsv_value_at_centroid(2); % Saturation
    value = hsv_value_at_centroid(3); % Brightness/Value

    % Display the HSV values near the centroid
    text(centroid_x + 100, centroid_y - 25, ...
        sprintf('HSV: (%.2f, %.2f, %.2f)', hue, saturation, value), ...
        'Color', 'red', 'FontSize', 12, 'FontWeight', 'bold');

    % Determine the color of the object (blue, red, yellow)
    if blue_mask(centroid_y, centroid_x)
        color = 'Blue';
        color_detected = 1;

    elseif red_mask(centroid_y, centroid_x)
        color = 'Red';
        color_detected = 2;
    elseif yellow_mask(centroid_y, centroid_x)
        color = 'Yellow';
        color_detected = 3;
    else
        color = 'Unknown';
        color_detected = 4;
    end

    % Display the color of the object
    % text(centroid_x, centroid_y - 10, ...
    %     sprintf('Color: %s', color), ...
    %     'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');

    % Display the centroid position and relative position in real-world units
    % text(centroid_x, centroid_y, ...
    %     sprintf('Rel Pos: (%.2f px, %.2f px)\n(%.2f mm, %.2f mm)', ...
    %     relative_position_pixels(1), relative_position_pixels(2), ...
    %     relative_position_mm(1), relative_position_mm(2)), ...
    %     'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');

    % Display the centroid position in real-world units
    text(centroid_x + 100, centroid_y + 50, ...
        sprintf('Color: %s\nReal Pos: (%.2f mm, %.2f mm)\nPixel Pos: (%.2f px, %.2f px)', ...
        color,...
        relative_position_mm(1), relative_position_mm(2), ...
        relative_position_pixels(1), relative_position_pixels(2)),...
        'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold');
    % Draw a rectangle around the object
    rectangle('Position', bbox, 'EdgeColor', 'r', 'LineWidth', 2);

    if centroid ~= 0
        detected = detected + 1;
        objects_position_mm(detected,1:4) = [detected, relative_position_mm, color_detected]; % Collect objects_position_mm in a row-wise fashion
        centroids(detected,1:4) = [detected, centroid_x, centroid_y, color_detected];
    end
end
position = round(relative_position_mm);
% Step 14: Pause for a moment to display the frame before capturing the next one
% pause(0.1);
hold off;

