function [ domain_v_G, v_G ] = BruteMatch(M_H, M_G)
%BruteMatch Returns the an unmatched query vertex and its domain
%   BruteMatch(M_H, M_G) examines the current mapping and selects from the
%   set of all unmatched query vertices the vertex that has the smallest
%   index number, and initialises its domain as all unmatched data
%   vertices.
%
%   REQUIRED INPUTS:
%   M_G - a vector of size (N_G,1) that describes which query vertex is
%   mapped to a data vertex.
%   M_H - a vector of size (N_H,1) that describes which data vertex is
%   mapped to a query vertex.

domain_v_G = transpose(find(M_H==0));
v_G = min(find(M_G == 0));
end
