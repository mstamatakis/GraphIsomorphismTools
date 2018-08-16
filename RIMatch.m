function [ v_H_list, v_G] = RIMatch(M_G, mu ,pt_mu, A_H, n_G_matched, n_neighbors_H, n_neighbors_G)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if n_G_matched == 0
    v_G = mu(1);
    deg_G = n_neighbors_G(v_G);
    v_H_list = transpose(find(n_neighbors_H >= deg_G));
else
    v_G = mu(n_G_matched+1);
    v_H_list = A_H(M_G(pt_mu(n_G_matched+1)),:);
    v_H_list = find(v_H_list);
    
end  
end

