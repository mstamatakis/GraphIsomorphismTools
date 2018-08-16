function [ result ] = terminal_nodes_test_BV( N,A_lG,nodes )
[ ~,~,p_G_total,~] = number_of_points_and_max_neighbour( N,A_lG );
[ A_H,A_G ] = adjacency_matrix( N,A_lG );
% Check if any terminal nodes satisfy the subgraph isomorphism condition
result=zeros(p_G_total,1); % initialising a matrix to store the result
n=1; % initilisaing a number n to be used in storing the result
A_H = uint8(A_H);
A_G = uint8(A_G);
for n_node=1:length(nodes)
    M=cell2mat(nodes{end,n_node});
    if isempty(M)==1
        break
    end
    matrix_subtract = M*(M*A_H)'-A_G;
    %if isequal(A_G,M*(M*A_H)')
    if any(matrix_subtract(:)<0)==1
        continue
    else
        [row,col] = find(M==1);
        [row_sorted, row_order]=sort(row);
        col_sorted=col(row_order,:);
        result(:,n)=col_sorted;
        n=n+1;
    end
end
         
end

