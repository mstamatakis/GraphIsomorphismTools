function [ ] = plot_data_graph( graph_size )
%plot_data_graph Plots the data graph as a triangular lattice
%   plot_data_graph( graph_size, A_list_G , fraction_active) generates a
%   plot of the data graph given the size
%
%   REQUIRED INPUTS:
%   graph_size - an integer that scales with the size of the graph, with
%   the vertices being equal to (graph_size+1)^2

% initialise variables
fraction_active = 1;
A_list_triangle = [2 3; 1 3; 1 2];
A_list_H = data_adjacency_list(graph_size, fraction_active);
[ A_H,~ ] = adjacency_matrix( A_list_H, A_list_triangle );
[ v_H_coordinates ] = triangle_coordinates( graph_size );
% plot vertices
scatter(v_H_coordinates(:,1),v_H_coordinates(:,2),'k','filled')
hold on
text(v_H_coordinates(:,1)+0.1,v_H_coordinates(:,2)+0.1,...
    cellstr(num2str([1:1:(graph_size+1)^2]')))
% plot edges
for i=1:(graph_size+1)^2
    for j=1:sum(A_H(i,:))
        plot( [v_H_coordinates(i,1),v_H_coordinates(A_list_H(i,j),1)],...
            [v_H_coordinates(i,2),v_H_coordinates(A_list_H(i,j),2)],'k')
    end
end
xlabel('x')
ylabel('y')
end
