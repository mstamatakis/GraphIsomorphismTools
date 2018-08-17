function [ F ] = BruteFeasibility(M_G, A_H, A_G, N_G)
%BruteFeasibility Returns the feasiblity of the current mapping in
%brute-force search with forward checking
%   BruteFeasibility(M_G, A_H, A_G, N_G) returns a logical varirable F. If
%   the current mapping is a solution, then F is returned as true.
%   Otherwise, F is returned as false.
%
%   REQUIRED INPUTS:
%   M_G - the current mapping solution
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph

for v_G = 1:N_G
    v_H = M_G(v_G);
    for v_G_neig = 1:N_G
        if A_G(v_G, v_G_neig) == 1
            v_H_neig = M_G(v_G_neig);
            if A_H(v_H, v_H_neig) == 0
                F = false;
                return
            end
        end
    end
end          
F = true;
end
