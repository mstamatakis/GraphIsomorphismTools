function [ M0 ] = ullmann_root_matrix( N,A_lG )
[ p_H_total,~,p_G_total,~ ] = number_of_points_and_max_neighbour( N,A_lG );
[ A_H,A_G ] = adjacency_matrix( N,A_lG );
% Generating the root M0

M0 = zeros(p_G_total,p_H_total); % Initilisaing the root matrix

for p_H=1:p_H_total
    for p_G=1:p_G_total
        if sum(A_H(p_H,:))<sum(A_G(p_G,:))  % if the number of neighborus of a point idx in H is smaller than the number of neighbours of a point idx2 in G
            M0(p_G,p_H)=0;
        else
            M0(p_G,p_H)=1; % if the number of neighborus of a point idx in H is greater than or equal to the number of neighbours of a point idx2 in G
        end
    end
end

end

