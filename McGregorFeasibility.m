function [ M ] = McGregorFeasibility(M, v_H, v_G, A_H, A_G, A_list_G, v_G_order )
M(v_G,[1:v_H-1,v_H+1:end])=0;
for p_G_nb=1:sum(A_G(v_G,:)) % for all neighbours of p_G
    M(A_list_G(v_G,p_G_nb),:) = bitand( M(A_list_G(v_G,p_G_nb),:) , A_H(v_H,:) );
end
M([1:v_G-1 v_G+1:end],v_H) = 0;