function [ M ] = McGregorFeasibility(M, v_H, v_G, A_H, A_G, A_list_G)
%McGregorFeasibility Generate the solution/reduced domain
%   McGregorFeasibility(M, v_H, v_G, A_H, A_G, A_list_G) performs forward
%   checking and reduce domains of vertices adjacent to v_G.
%
%   REQUIRED INPUTS:
%   M - the current mapping solution in matrix form
%   v_H - the data vertex that is being mapped
%   v_G - the query vertex that is being mapped
%   A_list_G - the adjacency list of the query graph
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph

% initialise variables
deg_v_G = sum(A_G(v_G,:));
% forward checking
M(v_G,[1:v_H-1,v_H+1:end])=0;
% McGregor's domain reduction rule
for n_neig = 1:deg_v_G
    v_G_neig = A_list_G(v_G,n_neig);
    M(v_G_neig,:) = bitand( M(v_G_neig,:), A_H(v_H,:) );
end
M([1:v_G-1 v_G+1:end],v_H) = 0;
