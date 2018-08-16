function [ M0 ] = UllmannPreProcess( A_H, A_G, N_H, N_G)
%% Detailed description of the function
% This function applies the allDifferent constraint to an initialized
% domain. That is, if a domain is single-valued, this single value is
% removed from all other domains.
% Inputs
%   A_lH - the adjacency list of the data graph H
%   A_lG - the adjacency list of the query graph G
% Outputs
%   M0_mod - the modified domain after applying the alldifferent constraint
%   row_1nb_all - vector that contains the label of query graph nodes that
%                 have only one possible match

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

