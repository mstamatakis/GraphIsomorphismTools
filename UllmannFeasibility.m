function [ feasible ] = UllmannFeasibility(M, v_H, v_G, A_H, A_G, A_list_G )
%UllmannFeasibility Returns the feasiblity of the current mapping in
%Ullmann's algorithm
%   UllmannFeasibility(M, v_H, v_G, A_H, A_G, A_list_G ) returns a logical 
%   varirable feasible. If the current match up between v_G and v_H is
%   likely to lead to an isomorphism, feasible is returned as true, and
%   false otherwise.
%
%   REQUIRED INPUTS:
%   M - the partial solution/domain
%   v_H - the data vertex that is being matched
%   v_G - the query vertex that is being matched
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph
%   A_list_G - the adjacency list of the query graph

for n_neig=1:sum(A_G(v_G,:))
    v_G_neig = A_list_G(v_G, n_neig);
    if sum(bitand(M(v_G_neig,:), A_H(v_H,:)))==0
        feasible=false;
        return
    end
end
feasible = true;
end
