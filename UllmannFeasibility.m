function [ F ] = UllmannFeasibility(M, n_H, n_G, A_H, A_G, A_list_G )
for p_G_nb=1:sum(A_G(n_G,:)) % for all neighbours of p_G        
    if sum(bitand(M(A_list_G(n_G,p_G_nb),:), A_H(n_H,:)))==0 % if this equals to zero, then this inner node will not generate subgraph isomorphism
        F=false;
        return
    end
end
F = true;