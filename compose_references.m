% Name        : [X3 P3]=compose_references(X1, X2)
% Description : Composes two poses.
% Input       : X1 - Transformation from A to B
%               X2 - Transformation from B to C
% Output      : X3 - Transformation from A to C
function X3=compose_references(X1,X2)
  X3=[X1(1)+X2(1)*cos(X1(3))-X2(2)*sin(X1(3));
      X1(2)+X2(1)*sin(X1(3))+X2(2)*cos(X1(3));
      X1(3)+X2(3)];
return;