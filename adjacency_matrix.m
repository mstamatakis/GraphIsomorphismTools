function [ A_H,A_G ] = adjacency_matrix( N,A_lG )
[ p_H_total,p_H_nb_max,p_G_total,p_G_nb_max ] = number_of_points_and_max_neighbour( N,A_lG );
[ A_lh ] = adjacency_list( N );
% Generating the adjanceny matrices from the input

A_H = zeros(p_H_total,p_H_total); % Initialising the adjacency matrix for H
A_G = zeros(p_G_total,p_G_total); % Initialising the adjacency matrix for G

% Setting values in the adjacency matrix A_H to 1 if it corresponds to
% neightbouring points
for p_H = 1:p_H_total
    for p_H_nb = 1:p_H_nb_max
        if A_lh(p_H,p_H_nb)==0
        else
            A_H(p_H,A_lh(p_H,p_H_nb))=1;
        end
    end
end

% Setting values in the adjacency matrix A_G to 1 if it corresponds to
% neightbouring points
for p_G = 1:p_G_total
    for p_G_nb = 1:p_G_nb_max
        if A_lG(p_G,p_G_nb)==0
        else
            A_G(p_G,A_lG(p_G,p_G_nb))=1;
        end
    end
end

end

