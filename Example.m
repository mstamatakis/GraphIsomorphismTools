clear, close all
%% inputs
% data graph size, fraction of active data vertices and adjacency list of
% query graph
graph_size = 4;
active_fraction = 1;
A_list_G = [ 2 3 ; 1 3 ; 1 2 ];
% option inputs
opts.measure = true;
opts.order = 'Default';
%% outputs
A_list_H = data_adjacency_list(graph_size, active_fraction);
plot_data_graph(graph_size)
% Brute-force search
[ result_brute, branches_brute ] = DFS(A_list_H, A_list_G, 'Brute', opts);
% Ullmann's algorithm
[ result_ullmann, branches_ullmann ] = BFS(A_list_H, A_list_G, 'Ullmann',opts);
% McGregor's algorithm
[ result_mcgregor, branches_mcgregor] = BFS(A_list_H, A_list_G, 'McGregor',opts);
% VF2
[ result_VF2, branches_VF2 ] = DFS(A_list_H, A_list_G, 'VF2', opts);
% Focus search
[ result_focus, branches_focus ] = BFS(A_list_H, A_list_G, 'Focus',opts);
% RI
[ result_RI, branches_RI ] = DFS(A_list_H, A_list_G, 'RI', opts);