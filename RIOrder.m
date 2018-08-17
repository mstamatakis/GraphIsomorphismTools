function [mu,parent] = RIOrder(A_list_G, A_G)
%RIOrder Returns the static ordering sequence of query vertices using the
%RI algorithm.
%   RIOrder(A_list_G, A_G) generates the static ordering sequence mu of
%   query vertices that are utilised by the RI algorithm. The parent of
%   each vertex in the list mu is also returned.
%
%   REQUIRED INPUTS:
%   A_list_G - the adjacency list of the query graph
%   A_G - the adjacency matrix of the query graph

% initialise variables
V = 1:size(A_list_G,1);
deg = sum(A_G);
% add the first vertex to mu
[~, v_0] = max(deg);
V = V(find(V~=v_0));
mu = v_0;
parent_v0 = 0;
parent = parent_v0;
% add other vertices to mu
while isempty(V) == 0
    v_rank = [-inf, -inf, -inf];
    for v = V
        % compute the lexicographic score of an unordered vertex
        % first score
        S_vis = length(intersect(A_list_G(v,:), mu));
        % second score
        S_neig = 0;
        for v_ordered = mu
            set_neig = setdiff(A_list_G(v_ordered,:),[mu v 0]);
            if isempty(set_neig) == 1
                continue
            else
                for v_neig = set_neig
                    if any(A_list_G(v_neig,:)==v) == 1
                        S_neig = S_neig + 1;
                        break
                    end
                end
            end
        end
        % third score
        set_unv = setdiff(A_list_G(v,:), [0 mu]);
        for v_ordered = mu
            set_unv = setdiff(set_unv, A_list_G(v_ordered,:));
        end
        S_unv = length(set_unv);
        % comparing the scores with the previously selected vertex
        if S_vis>v_rank(1) || S_vis==v_rank(1) && S_neig>v_rank(2) || ...
                S_vis==v_rank(1) && S_neig==v_rank(2) && S_unv>v_rank(3)
            v_m = v;
            v_rank = [S_vis S_neig S_unv];
        end     
    end    
    % add selected vertex to mu and parent
    parent_v_m = min(intersect(A_list_G(v_m,:),mu));
    mu = [mu v_m];
    parent = [parent parent_v_m];
    V = V(find(V~=v_m));
end
end
