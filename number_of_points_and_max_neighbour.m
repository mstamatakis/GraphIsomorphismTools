function [ p_H_total,p_H_nb_max,p_G_total,p_G_nb_max ] = number_of_points_and_max_neighbour( N,A_lG )
% Test
[ A_lH ] = adjacency_list( N );
[p_H_total,p_H_nb_max] = size(A_lH); % Determining the number of points and the maxmium number of neightbours in H
[p_G_total,p_G_nb_max]=size(A_lG); % Determining the number of points and the maxmium number of neightbours in subgraph G


end

