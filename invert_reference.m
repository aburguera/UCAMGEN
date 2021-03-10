% Name        : Xinv=invert_reference(X)
% Description : Inverts a 2D transformation
% Input       : X    - Transformation from A to B [x;y;o]
% Output      : Xinv - Transformation from B to A
function Xinv=invert_reference(X)
  Xinv=[-X(1)*cos(X(3))-X(2)*sin(X(3));X(1)*sin(X(3))-X(2)*cos(X(3));-X(3)];
return;