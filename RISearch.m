function [ result ] = RISearch(A_list_H,A_list_G )
[ A_H,A_G ] = adjacency_matrix( A_list_H,A_list_G );
[ N_H,~,N_G,~ ] = total_nodes_and_maximum_neighbor( A_list_H,A_list_G );
[mu,pt_mu] = RIGreatestConstraintFirst(A_list_G, A_G);


% Re-ordering adjacency list and matrices according to mu
% A_G = A_G(mu,:);
% A_list_G = A_list_G(mu,:);

% Calculating number of neightbors
n_neighbors_H = sum(A_H, 2);
n_neighbors_G = sum(A_G, 2);

% Converting to bit matrices
A_H = uint16(A_H);
A_G = uint16(A_G);

% Initialise array to store the result
result = [];

for v_H=1:N_H
    if n_neighbors_G(mu(1))>n_neighbors_H(v_H)
        continue
    else
        M_G0 = zeros(N_G,1);
        M_H0 = zeros(N_H,1);
        M_G0(mu(1)) = v_H;        
        M_H0(v_H) = mu(1);
        previous_M_G0 = M_G0;
        previous_M_H0 = M_H0;
        current_M_G0 = [];
        current_M_H0 = [];
        for n_G = 2:N_G
            for i = 1:size(previous_M_G0, 2)
                M_G0 = previous_M_G0(:,i);
                M_H0 = previous_M_H0(:,i);
                x_list = A_list_H(M_G0(pt_mu(n_G)),:);
                x_list = x_list(find(x_list~=0));
                M_G = M_G0;
                M_H = M_H0;
                P_G = mu(n_G);
                for P_H = x_list
                    F = RIFeasibility(P_H, P_G, M_H, M_G, A_H, A_G, n_neighbors_H, n_neighbors_G);
                    if F==true
                        M_G(P_G) = P_H;
                        M_H(P_H) = P_G;
                        current_M_G0 = [current_M_G0 M_G];
                        current_M_H0 = [current_M_H0 M_H];
                        M_G = M_G0;
                        M_H = M_H0;
                    end
                end
            end
            
            if n_G == N_G
                result = [result current_M_G0];
            else
                previous_M_G0 = current_M_G0;
                previous_M_H0 = current_M_H0;
                current_M_G0 = [];
                current_M_H0 = [];
            end
        end
    end
end
