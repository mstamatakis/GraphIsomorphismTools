function [ v_G_order ] = McGregorOrder(N_G, A_G)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


unordered_G = 1:N_G;
deg_G = sum(A_G, 2);
v_G_order = [];
while length(v_G_order) ~= N_G
    [~ , rank] = max(deg_G);
    v_G_order = [v_G_order , rank];
    deg_G(rank) = -inf;
end



