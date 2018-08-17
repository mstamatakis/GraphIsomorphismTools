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

% initialise variables
N_H = size(A_list_H , 1);
N_G = size(A_list_G , 1);
deg_H = sum(A_H, 2);
deg_G = sum(A_G, 2);
deg_neig_H = cell(N_H, 1);
deg_neig_G = cell(N_G, 1);
M0 = ones(N_G,N_H);
% create degree of neighbours list used in iterated labeling filtering
for v_H = 1:N_H
    for j = 1:deg_H(v_H)
        deg_neig_H{v_H} = [deg_neig_H{v_H} deg_H(A_list_H(v_H,j))];
    end
    deg_neig_H{v_H} = sort(deg_neig_H{v_H},'descend');
end
for v_G = 1:N_G
    for j = 1:deg_G(v_G)
        deg_neig_G{v_G} = [deg_neig_G{v_G} deg_G(A_list_G(v_G,j))];
    end
    deg_neig_G{v_G} = sort(deg_neig_G{v_G},'descend');
end
% filtering domains
for v_H=1:N_H
    for v_G=1:N_G
        if deg_H(v_H)<deg_G(v_G)
            M0(v_G,v_H)=0;
        else
            for k = 1:deg_G(v_G)
                if  deg_neig_H{v_H}(k) < deg_neig_G{v_G}(k)
                    M0(v_G,v_H)=0;
                    break
                end
            end
        end
    end
end

end
