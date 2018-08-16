function [M0] = FocusPreProcess(A_list_H, A_list_G, A_H, A_G)
%FocusPreProcess Generate the initial domain in focus search
%   FocusPreProcess(A_list_H, A_list_G, A_H, A_G) returns a matrix M0 of
%   size (N_G, N_H) where each row of the matrix represents the domain of a
%   query vertex
%
%   REQUIRED INPUTS:
%   A_list_H - the adjacency list of the data graph
%   A_list_G - the adjacency list of the query graph
%   A_H - the adjacency matrix of the data graph
%   A_G - the adjacency matrix of the query graph

N_H = size(A_list_H , 1);
N_G = size(A_list_G , 1);

M0 = ones(N_G,N_H);

deg_H = sum(A_H, 2);
deg_G = sum(A_G, 2);

deg_neig_H = cell(N_H, 1);
deg_neig_G = cell(N_G, 1);

% Create Zampelli et al's degree of neighbours list
for i = 1:N_H
    for j = 1:deg_H(i)
        deg_neig_H{i} = [deg_neig_H{i} deg_H(A_list_H(i,j))];
    end
    deg_neig_H{i} = sort(deg_neig_H{i},'descend');
end

for i = 1:N_G
    for j = 1:deg_G(i)
        deg_neig_G{i} = [deg_neig_G{i} deg_G(A_list_G(i,j))];
    end
    deg_neig_G{i} = sort(deg_neig_G{i},'descend');
end
    

% Filtering vertices
for p_H=1:N_H
    for p_G=1:N_G
        if deg_H(p_H)<deg_G(p_G)
            M0(p_G,p_H)=0;
        else
            for k = 1:deg_G(p_G)
                if  deg_neig_H{p_H}(k) < deg_neig_G{p_G}(k)
                    M0(p_G,p_H)=0;
                    break
                end
            end
        end
    end
end

end


