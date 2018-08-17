function [M, feasible] = FocusReduce(v_H, v_G, M0, mu, A_list_H, A_list_G, A_H, A_G)
%FocusReduce Generate the solution/reduced domain and  checks if the
%current map is feasible
%   FocusReduce(n_H, n_G, M0, mu, A_list_H, A_list_G, A_H, A_G) checks if
%   the map between v_H and v_G is likely to lead to a complete
%   isomorphism, and if so returns the reduced domain of the next query
%   vertex that will be mapped.
%
%   REQUIRED INPUTS:
%   v_H - the data vertex that is being mapped
%   v_G - the query vertex that is being mapped
%   M0 - the current mapping solution in matrix form
%   A_list_H - the adjacency list of the data graph
%   A_list_G - the adjacency list of the query graph
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph

% intialising variables
M = M0;
n_v_G_matched = find(mu==v_G);
previous_matched_vertices = mu(1:n_v_G_matched-1);
% Forward checking
if any(M0(previous_matched_vertices,v_H)==1)
    feasible = false;
    return
end
M(v_G, [1:v_H-1 v_H+1:end]) = 0; 
% The first part of pruning rules utilised by focus search
V_G_matched = mu(1:n_v_G_matched);
V_G_unmatched_neig = intersect(A_list_G(v_G,:), mu(n_v_G_matched+2:end));
for v_G_unmatched_next = V_G_unmatched_neig
    D = M(v_G_unmatched_next,:);
    for v_G_matched = V_G_matched
        if A_G(v_G_unmatched_next,v_G_matched) == 1
            D = bitand(D, A_H(find(M(v_G_matched,:)==1),:));
        end
    end
    if sum(D) == 0
        feasible = false;
        return
    end
end
% The second part of pruning rules utilised by focus search
v_G_unmatched_next = mu(n_v_G_matched+1);
D = M(v_G_unmatched_next,:);
for v_G_matched = V_G_matched
    if A_G(v_G_unmatched_next,v_G_matched) == 1
        D = bitand(D, A_H(find(M(v_G_matched,:)==1),:));
    end
end
if sum(D) == 0
    feasible = false;
    return
end
M(v_G_unmatched_next,:) = D;  
feasible = true;
end
