function [ F ] = VF2Feasibility(v_H, v_G, M_G, A_H, A_list_G)
%% Detailed description of the function
% Compute the feasbility of a pair in set P
% Inputs
%    M_H - current partial mapping solution of data graph
%    M_G - current partial mapping solution of query graph
%    A_H - adjacency matrix of data graph
%    A_G - adjacency matrix of query graph
% Outputs
%    F - feasbility of pair (true/false)
%% The code

neig_list_G = A_list_G( v_G, find(A_list_G(v_G,:)) );
% Check branch correspondence for nodes connected to P_G
for v_G_neig = neig_list_G
    v_H_neig = M_G(v_G_neig);
    if M_G(v_G_neig) ~= 0
        % check branch correspondence
        if A_H(v_H,v_H_neig)==0
            F = false;
            return
        end
    end
end

F = true;
        
