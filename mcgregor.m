function [ result,nodes ] = mcgregor(N,A_lG )
[ A_H,A_G ] = adjacency_matrix( N,A_lG );
[ p_H_total,~,p_G_total,~ ] = number_of_points_and_max_neighbour( N,A_lG );
[ M0_mod,row_1nb_all ] = ullmann_preliminary_root_refinement( N,A_lG );
% Determining the inner nodes and terminal nodes
nodes=cell(2,1);
track_change=cell(2,1);
M = M0_mod;
for p_G=1:p_G_total
    for p_H=1:p_H_total
        B = zeros(p_H,1);
        if M(p_G,p_H)==1
            B = A_H(p_H,:);
            
            
            


[ result ] = terminal_nodes_test( N,A_lG,nodes );


end

