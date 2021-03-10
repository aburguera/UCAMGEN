% Normalizes angles to the interval  (-pi,pi]
function angles = normalize_angles(angles)
    angles=angles+(2*pi)*floor((pi-angles)/(2*pi));
return;