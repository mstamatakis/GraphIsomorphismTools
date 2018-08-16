function [ A_H,A_G ] = adjacency_matrix( A_list_H,A_list_G )
%adjacency_matrix Compute the adjacency matrices of the data graph and
%query graph
%   adjacency_matrix( A_list_H,A_list_G ) returns two matrices, the first
%   is the adjacency matrix of the data graph H, the second is the
%   adjacency matrix of the query graph
%
%   REQUIRED INPUTS:
%   A_list_H - the adjacency list of the data graph
%   A_list_G - the adjacency list of the query graph

[N_H, max_deg_H] = size(A_list_H);
[N_G, max_deg_G] = size(A_list_G);
    
% Generating the adjanceny matrices from the input
A_H = zeros(N_H,N_H);
A_G = zeros(N_G,N_G);

% Setting values in the adjacency matrix A_H to 1 if it corresponds to
% neightbouring points
for v_H = 1:N_H
    for v_H_neig = 1:max_deg_H
        if A_list_H(v_H,v_H_neig)==0
            break
        else
            A_H(v_H,A_list_H(v_H,v_H_neig))=1;
        end
    end
end


for v_G = 1:N_G
    for v_G_neig = 1:max_deg_G
        if A_list_G(v_G,v_G_neig)==0
            break
        else
            A_G(v_G,A_list_G(v_G,v_G_neig))=1;
        end
    end
end

end

