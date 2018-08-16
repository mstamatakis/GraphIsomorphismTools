function [ F ] = RIFeasibility(v_H, v_G, M_H, M_G, A_H, A_G, n_neighbors_H, n_neighbors_G)

if any(M_G==v_H)
    F = false;
    return
elseif n_neighbors_H(v_H)<n_neighbors_G(v_G)
    F = false;
    return
else
    neighbor_G = A_G(v_G,:);
    neighbor_G_list = find(neighbor_G);
    M_H(v_H) = v_G;
    M_G(v_G) = v_H;
    % Check branch correspondence for nodes connected to P_G
    for n_G_neig = neighbor_G_list
        v_H_neig = M_G(n_G_neig);
        if v_H_neig ~= 0
            % check branch correspondence
            if A_H(v_H,v_H_neig)==0
                F = false;
                return
            end
        end
    end
end

F = true;
    

end
