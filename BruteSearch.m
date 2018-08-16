function [ result ] = BruteSearch(A_list_H,A_list_G, M_H0, M_G0, v_H_unmatched_0, v_G_unmatched_0, result )

N_H = size(A_list_H,1);
N_G = size(A_list_G,1);

% Determining the inner nodes and terminal nodes
if isempty(v_G_unmatched_0)
    F = BruteFeasibility(M_G0, A_list_H, A_list_G, N_G );
    if F == true
        result = [result M_G0];   
    end
else    
    v_G = v_G_unmatched_0(1);
    P_H = transpose(v_H_unmatched_0);
    P_G = ones(length(P_H), 1)*v_G;
%     v_G_unmatched_0(1) = [];
    P = [P_H P_G];
    for i = 1:size(P,1)
        P_H = P(i,1);
        P_G = P(i,2);
        M_H = M_H0;
        M_G = M_G0;
        v_H_unmatched = v_H_unmatched_0;
        v_G_unmatched = v_G_unmatched_0;
%         M_H0 = M_H;
%         M_G0 = M_G;
        M_H(P_H) = P_G ;
        M_G(P_G) = P_H ;
        v_H_unmatched(find(v_H_unmatched_0==P_H)) = [];
        v_G_unmatched(1) = [];
        [result] = BruteSearch(A_list_H,A_list_G, M_H, M_G, v_H_unmatched, v_G_unmatched, result );
        
    end
%     M_H = M_H0;
%     M_G = M_G0;
end

end
