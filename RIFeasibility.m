function [ feasible ] = RIFeasibility(v_H, v_G, M_H, M_G, A_H, A_G, deg_H, deg_G)
%RIFeasibility Determines if the current mapping is feasible
%   RIFeasibility(v_H, v_G, M_H, M_G, A_H, A_G, deg_H, deg_G) returns a
%   logical variable 'feasible' depending on whether the mapping between
%   v_H and v_G passes the pruning rules set in the RI algorithm.
%
%   REQUIRED INPUTS:
%   v_H - the data vertex that is being matched
%   v_G - the query vertex that is being matched
%   M_H - an array of size (N_H,1) which indicates which data vertices have
%   been previously mapped to the query vertices
%   M_G - an array of size (N_G,1) which indicates which query vertices 
%   have been previously mapped to the data vertices
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph
%   deg_H - the degree of each vertex in the data graph
%   deg_G - the degree of each vertex in the query graph

if any(M_G==v_H) % first pruning rule
    feasible = false;
    return
elseif deg_H(v_H)<deg_G(v_G) % second pruning rule
    feasible = false;
    return
else % third pruning rule
    adj_v_G = find( A_G(v_G,:) );
    M_H(v_H) = v_G;
    M_G(v_G) = v_H;
    % Check edge correspondence for vertices connected to v_G
    for n_G_neig = adj_v_G
        v_H_neig = M_G(n_G_neig);
        if v_H_neig ~= 0
            if A_H(v_H,v_H_neig)==0
                feasible = false;
                return
            end
        end
    end
end
feasible = true;
end
