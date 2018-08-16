function [mu,pt_mu] = RIOrder(A_list_G, A_G)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% % Example A_G:
% A_list_G = [2 4 5 10 0;
%        1 3 5 6 0;
%        2 6 0 0 0;
%        1 7 0 0 0;
%        1 2 6 7 8;
%        2 3 5 8 9;
%        4 5 8 10 0;
%        5 6 7 9 0;
%        6 8 0 0 0;
%        1 7 11 0 0;
%        10 0 0 0 0];
V = 1:size(A_list_G,1);
deg = sum(A_G);
[~, u_0] = max(deg);
V = V(find(V~=u_0));
mu = u_0;
pt_u0 = 0;
pt_mu = pt_u0;
u_m = 0;
while isempty(V) == 0
    u_rank = [-inf, -inf, -inf];
%     n_neig_rank = -inf;
    m = length(mu);
    for i = 1:length(V)        
        V_i_vis = length(intersect(A_list_G(V(i),:), mu));
        % The paper's definition of V_i_neig
        V_i_neig = 0;
        for j = 1:length(mu)
            set_neig = setdiff(A_list_G(mu(j),:),[mu V(i) 0]);
            if isempty(set_neig) == 1
                continue
            else
                for k =1:length(set_neig)
                    if any(A_list_G(set_neig(k),:)==V(i)) == 1
                        V_i_neig = V_i_neig + 1;
                        break
                    end
                end
            end
        end
%         % What seems to be the actual definition of V_i_neig?
%         set_neig_a = setdiff(A_list_G(V(i),:), [0 mu]);
%         for j =1:length(mu)
%             set_neig_a = intersect(set_neig_a, A_list_G(mu(j),:));
%         end
%         n_neig = length(set_neig_a);
        
        
        
        set_unv = setdiff(A_list_G(V(i),:), [0 mu]);
        for j = 1:length(mu)
            set_unv = setdiff(set_unv, A_list_G(mu(j),:));
        end
        V_i_unv = length(set_unv);
%         disp(['V(i) = ', num2str(V(i)), ', rank is [' , num2str(V_i_vis), ' ', num2str(V_i_neig), ' ', num2str(V_i_unv), ']'])
        if V_i_vis>u_rank(1) || V_i_vis==u_rank(1) && V_i_neig>u_rank(2) || V_i_vis==u_rank(1) && V_i_neig==u_rank(2) && V_i_unv>u_rank(3)
            u_m = V(i);
            u_rank = [V_i_vis V_i_neig V_i_unv];
%             n_neig_rank = n_neig;
        end     
    end
    
    % add pt and mu
    pt_u_m = min(intersect(A_list_G(u_m,:),mu));
    mu = [mu u_m];
    pt_mu = [pt_mu pt_u_m];
    V = V(find(V~=u_m));
end

end

