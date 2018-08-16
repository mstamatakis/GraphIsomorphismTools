function [ v_H_list, v_G ] = VF2ComputePair(M_H, M_G, A_H, A_G, N_H)
%% Detailed description of the function
% Compute the set P(s)
% Inputs
%    M_H - current partial mapping solution of data graph
%    M_G - current partial mapping solution of query graph
%    A_H - adjacency matrix of data graph
%    A_G - adjacency matrix of query graph
% Outputs
%    P - pairs
%% The code
T_H = uint16(zeros(length(M_H),1));
T_G = uint16(zeros(length(M_G),1));
i_UnmatchedQueryVertex = [];
i_MatchedQueryVertex = [];
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
    v_H_list = 1:N_H;
    deg_G = sum(A_G,2);
    [~, v_G] = max(deg_G);
else
    % Removed already matched data and query vertices from future pairing
    for j = i_MatchedQueryVertex
        T_H(M_G(j))=0;
        T_G(j) = 0;
    end
    
    % Create pairs
    v_H_list = transpose(find(T_H));
    
    v_G = find(T_G);
    previous_neig = -inf;
    selected_v_G = 0;
    for k = 1:length(v_G)
        current_neig = sum(A_G(v_G(k),:));
        if previous_neig < current_neig
            previous_neig = current_neig;
            selected_v_G = v_G(k);
        end
    end
    
    v_G = selected_v_G;
    
%     P_G = uint16(ones(length(P_H),1).*selected_v_G);

    
    
%     P = [P_H P_G];
end
    

