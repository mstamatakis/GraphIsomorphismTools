function [ domain_v_G, v_G] = VF2Match(M_H, M_G, A_H, A_G, N_H)
%VF2Match Returns an unmatched query vertex and its domain using the VF2
%algorithm
%   VF2Match(M_H, M_G, A_H, A_G, N_H) examines the current mapping and 
%   select v_G as the next unmatched query vertex. The domain of v_G is 
%   also returned.
%
%   REQUIRED INPUTS:
%   M_H - a vector of size (N_H,1) that describes which data vertex is
%   mapped to a query vertex
%   M_G - a vector of size (N_G,1) that describes which query vertex is
%   mapped to a data vertex
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph
%   N_H - the number of data vertices

% initialise variables
T_H = uint16(zeros(length(M_H),1));
T_G = uint16(zeros(length(M_G),1));
i_UnmatchedQueryVertex = [];
i_MatchedQueryVertex = [];
% find the neighbouring vertices to the already matched query and data
% vertices
for i = 1:length(M_G)
    if M_G(i) == 0
        i_UnmatchedQueryVertex = [i_UnmatchedQueryVertex i];
        continue
    else
        T_H = bitor(T_H,transpose(A_H(M_G(i),:)));
        T_G = bitor(T_G,transpose(A_G(i,:)));
        i_MatchedQueryVertex = [i_MatchedQueryVertex i];
    end
end
if isempty(i_MatchedQueryVertex)
    domain_v_G = 1:N_H;
    deg_G = sum(A_G,2);
    [~, v_G] = max(deg_G);
else
    % forward checking before determining the domain
    for j = i_MatchedQueryVertex
        T_H(M_G(j))=0;
        T_G(j) = 0;
    end    
    domain_v_G = transpose(find(T_H));
    % determine the next query vertex to match
    V_G_unmatched = find(T_G);
    deg_v_m = -inf;
    v_m = 0;
    for i = 1:length(V_G_unmatched)
        v_G_unmatched = V_G_unmatched(i);
        deg_v_G_unmatched = sum(A_G(v_G_unmatched,:));
        if deg_v_m < deg_v_G_unmatched
            deg_v_m = deg_v_G_unmatched;
            v_m = v_G_unmatched;
        end
    end
    v_G = v_m;    
end
