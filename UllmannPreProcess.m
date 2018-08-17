function [ M0 ] = UllmannPreProcess( A_H, A_G, N_H, N_G)
%UllmannPreProcess Generate the initial domain in Ullmann's algorithm
%   UllmannPreProcess( A_H, A_G, N_H, N_G) returns a matrix M0 of size
%   (N_G, N_H) where each row of the matrix represents the domain of a
%   query vertex
%
%   REQUIRED INPUTS:
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph
%   N_H - the number of data vertices
%   N_G - the number of query vertices

% Invariant domain reduction
M0 = zeros(N_G,N_H);
for v_H=1:N_H
    for v_G=1:N_G
        if sum(A_H(v_H,:))<sum(A_G(v_G,:))  
            M0(v_G,v_H)=0;
        else
            M0(v_G,v_H)=1;
        end
    end
end

% Forward checking
for v_G = 1:N_G
    domain_v_G = find(M0(v_G,:)==1);
    if length(domain_v_G) == 1
        M0([1:v_G-1 v_G+1:end],v_H) = 0;
    end
end

end

