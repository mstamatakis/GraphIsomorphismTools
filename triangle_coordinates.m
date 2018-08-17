function [ v_coordinate ] = triangle_coordinates( graph_size )
%triangle_coordinates Returns the coordinates of the data graph
%   triangle_coordinates( graph_size ) generates the coordinates of each
%   vertex in the x-axis and y-axis in a data graph of specified size.
%
%   REQUIRED INPUTS:
%   graph_size - an integer that scales with the size of the data graph,
%   with the number of vertices being (graph_size+1)^2

% initialise variables
v_coordinate = zeros((graph_size+1)^2,2);
x_shift=0; % shift of coordinates from the x-axis
y_shift=0; % shift of coordinates from the y-axis
v_index=[1:1:graph_size+1];
h=sqrt(1-0.5^2); % height of an equilaterial triangle with side length=1
% calculate coordinate of each vertex
for n_rows = 1:graph_size+1
    v_coordinate(v_index,1)=[x_shift:1:graph_size+x_shift];
    v_coordinate(v_index,2)=y_shift*h;    
    % Updating shifts
    x_shift=x_shift+0.5;
    y_shift=y_shift+1;
    v_index=v_index+(graph_size+1);    
end
end
