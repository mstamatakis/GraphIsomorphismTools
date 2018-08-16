function [mu] = FocusOrder(A_list_G, A_G)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

unmatched_V = 1:size(A_list_G,1);
deg = sum(A_G,2);
mu = [];

while isempty(unmatched_V) == 0
    L_set_previous = -inf;
    sum_branch_previous = -inf;
    for v = unmatched_V
        set_intersect = intersect(A_list_G(v,:),mu);
        if length(set_intersect) >= L_set_previous
            sum_branch = 0;
            for n_neigh = 1:deg(v)
                v_neigh = A_list_G(v,n_neigh);
                for i_neigh = 1:deg(v_neigh)
                    sum_branch = sum_branch + deg(A_list_G(v_neigh, i_neigh));
                end
            end
            if length(set_intersect) > L_set_previous || length(set_intersect) == L_set_previous && sum_branch > sum_branch_previous 
                u_m = v;
                L_set_previous = length(set_intersect);
                sum_branch_previous = sum_branch;
            end
        end
    end
    mu = [mu u_m];
    unmatched_V = unmatched_V(find(unmatched_V~=u_m));
end
