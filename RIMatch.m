function [ domain_v_G, v_G] = RIMatch(M_G, mu ,parent, A_H, n_G_matched, deg_H, deg_G)
%RIMatch Returns an unmatched query vertex and its domain using the RI
%algorithm
%   RIMatch(M_G, mu ,parent, A_H, n_G_matched, deg_H, deg_G) examines the
%   current mapping select v_G as the next unmatched query vertex in the
%   list mu. The domain of v_G is also returned.
%
%   REQUIRED INPUTS:
%   M_G - a vector of size (N_G,1) that describes which query vertex is
%   mapped to a data vertex.
%   mu - the static sequence of the query vertices
%   parent - the parent of each vertex in the static sequence mu
%   A_H - the adjacency matrix of the data graph
%   n_G_matched - the number of query vertices that are already matched
%   deg_H - the degree of each data vertex
%   deg_G - the degree of each query vertex

if n_G_matched == 0
    v_G = mu(1);
    deg_v_G = deg_G(v_G);
    domain_v_G = transpose(find(deg_H >= deg_v_G));
else
    v_G = mu(n_G_matched+1);
    v_H_parent = M_G(parent(n_G_matched+1));
    domain_v_G = find( A_H(v_H_parent, :) );
end  
end
