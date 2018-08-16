function [ v_H_list, v_G ] = BruteMatch(M_H, M_G)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


v_H_list = transpose(find(M_H==0));
v_G = min(find(M_G == 0));


end

