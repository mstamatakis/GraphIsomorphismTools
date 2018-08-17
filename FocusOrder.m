function [mu] = FocusOrder(A_list_G, A_G)
%FocusOrder Returns the static ordering sequence of query vertices.
%   FocusOrder(A_list_G, A_G) generates the static ordering sequence of
%   query vertices that are utilised by focus search algorithm.
%
%   REQUIRED INPUTS:
%   A_list_G - the adjacency list of the query graph
%   A_G - the adjacency matri of the query graph

% initialise variables
unmatched_V = 1:size(A_list_G,1);
deg = sum(A_G,2);
mu = [];
% start filled mu with the sequence of vertices
while isempty(unmatched_V) == 0
    S_vis_m = -inf;
    n_e_m = -inf;
    for v = unmatched_V
        S_vis = intersect(A_list_G(v,:),mu);
        if length(S_vis) >= S_vis_m
            n_e = 0;
            for n_neigh = 1:deg(v)
                v_neigh = A_list_G(v,n_neigh);
                for i_neigh = 1:deg(v_neigh)
                    n_e = n_e + deg(A_list_G(v_neigh, i_neigh));
                end
            end
            if length(S_vis) > S_vis_m || length(S_vis) == S_vis_m &&...
                    n_e > n_e_m 
                v_m = v;
                S_vis_m = length(S_vis);
                n_e_m = n_e;
            end
        end
    end
    mu = [mu v_m];
    unmatched_V = unmatched_V(find(unmatched_V~=v_m));
end
