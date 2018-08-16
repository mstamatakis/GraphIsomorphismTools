function [ H_co ] = triangle_coordinates( N )
%% Calculating coordinates
H_co = zeros((N+1)^2,2); % Initilisaing the coordinates matrix
x_diff=0; % dummy variable for calculating the coordinate of x
y_diff=0; % dummy variable for calculating the coordinate of y
p_H_label=[1:1:N+1]; % number of points in each row
h=sqrt(1-0.5^2); % height of an equilaterial triangle with side length=1
for n_rows = 1:N+1
    H_co(p_H_label,1)=[x_diff:1:N+x_diff]; % x
    H_co(p_H_label,2)=y_diff*h; % y
    
    % Updating dummy variables
    x_diff=x_diff+0.5;
    y_diff=y_diff+1;
    p_H_label=p_H_label+(N+1);    
end
end