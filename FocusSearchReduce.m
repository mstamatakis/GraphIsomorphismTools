function [M, consistent] = FocusSearchReduce(n_H, n_G, M0, mu, A_list_H, A_list_G, A_H, A_G)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

M = M0;
% Forward checking
index = find(mu==n_G);
previous_matched_vertices = mu(1:index-1);
if any(M0(previous_matched_vertices,n_H)==1)
    consistent = false;
    return
end
M(n_G, [1:n_H-1 n_H+1:end]) = 0; 


current_matched_vertices = mu(1:index);
v_G_future = intersect(A_list_G(index,:), mu(index+2:end));
for j = v_G_future
    jD = M(j,:);
    for i_neig = current_matched_vertices
        if A_G(j,i_neig) == 1
            jD = bitand(jD, A_H(find(M(i_neig,:)==1),:));
        end
    end
    if sum(jD) == 0
        consistent = false;
        return
    end
end

% Second check
j = mu(index+1);
% pastAdj = intersect(current_matched_vertices, A_list_G(j,:));
jD = M(j,:);
for i_neig = current_matched_vertices
    if A_G(j,i_neig) == 1
        jD = bitand(jD, A_H(find(M(i_neig,:)==1),:));
    end
end
if sum(jD) == 0
    consistent = false;
    return
end

M(j,:) = jD;  
consistent = true;


