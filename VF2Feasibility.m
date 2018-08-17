function [ feasible ] = VF2Feasibility(v_H, v_G, M_G, A_H, A_list_G)
%VF2Feasibility Determines if the current mapping is feasible
%   VF2Feasibility(v_H, v_G, M_G, A_H, A_list_G) returns a logical variable
%   'feasible' depending on whether the mapping between v_H and v_G passes 
%   the pruning rules set in the VF2 algorithm.
%
%   REQUIRED INPUTS:
%   v_H - the data vertex that is being matched
%   v_G - the query vertex that is being matched
%   M_G - an array of size (N_G,1) which indicates which query vertices 
%   have been previously mapped to the data vertices
%   A_H - the adjacency matrix of the data graph
%   A_list_G - the adjacency list of the data graph

neig_list_G = A_list_G( v_G, find(A_list_G(v_G,:)) );
% Check branch correspondence for nodes connected to P_G
for v_G_neig = neig_list_G
    v_H_neig = M_G(v_G_neig);
    if M_G(v_G_neig) ~= 0
        % check branch correspondence
        if A_H(v_H,v_H_neig)==0
            feasible = false;
            return
        end
    end
end
feasible = true;
end
        
