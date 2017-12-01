function [ M0_mod,row_1nb_all ] = ullmann_preliminary_root_refinement( N,A_lG )
[ M0 ] = ullmann_root_matrix( N,A_lG );
[ ~,~,p_G_total,~ ] = number_of_points_and_max_neighbour( N,A_lG );
% If there is any row in M0 that contains only one '1', eliminate all other '1's in that column
row_1nb_all=find(sum(M0,2)==1); % finding any rows which contain only one '1' in the root matrix
M0_mod=M0; % initilisaing the modified root
if isempty(row_1nb_all)==0 % if a is not empty i.e. there are rows which contain only one '1' in the root matrix
    col_1nb=zeros(length(row_1nb_all),1); % initilisaing a vector to store the row numbers for rows that contain only one '1'
    for row_1nb=1:length(row_1nb_all)
        col_1nb(row_1nb)=find((M0(row_1nb_all(row_1nb),:))==1); % finding at which column is the '1 located for rows that contain only one '1'
    end
    for p_G=1:p_G_total
        for row_1nb=1:length(row_1nb_all) % repeat for all rows that contain only one 1
            if p_G==row_1nb_all
            else % for all values in the column at which the one '1' is located, set their values to zero
                M0_mod(p_G,col_1nb(row_1nb))=0;
            end
        end
    end
end


end

