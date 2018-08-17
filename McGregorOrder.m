function [ mu ] = McGregorOrder(N_G, A_G)
%McGregorOrder Generates a static sequence of query vertices
%   McGregorOrder(N_G, A_G) orderes the query vertices based on their
%   cardinality of the vertices' initial domains and return this in an
%   array mu.
%
%   REQUIRED INPUTS:
%   N_G - the numer of query vertices
%   A_G - the adjacency matrix of the query graph

% initialise variables
deg_G = sum(A_G, 2);
mu = [];
% fill the list mu with sequence of query vertices
while length(mu) ~= N_G
    [~ , v_G_m] = max(deg_G);
    mu = [mu , v_G_m];
    deg_G(v_G_m) = -inf;
end
