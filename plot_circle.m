% Name        : h=plot_circle(x,y,r,c)
% Description : Plots a circle
% Input       : x,y - Coordinates of the circle center.
%               r - Radius
%               c - Color
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function h=plot_circle(x,y,r,c)
    th=0:pi/10:2*pi;
    xunit=r*cos(th)+x;
    yunit=r*sin(th)+y;
    h=plot(xunit,yunit,c);
return;