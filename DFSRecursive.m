function [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H,...
    A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches,...
    mu, parent, deg_H, deg_G, n_G_matched)
%DFSRecursive The recursive search for subgraph isomorphisms in an 
% algorithm with depth-first search strategy (called by the DFS function)
%   DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, 
%   opts, result, n_branches, mu, parent_mu , deg_H, deg_G, n_G_matched)
%   returns all isomorphisms given a subgraph isomorphism problem. It also
%   returns the number of branches created in a search tree by an algorithm
%   if opts.order is true.
%
%   REQUIRED INPUTS:
%   M_H - a vector of size (N_H,1) that shows which data vertex is mapped
%   to a query vertex
%   M_G - a vector of size (N_G,1) that shows which query vertex is mapped
%   to a data vertex
%   A_list_H - the adjacency list of the data graph H
%   A_list_G - the adjacency list of the query graph G
%   A_H - the adjacency matrix of the data graph H
%   A_G - the adjacency matrix of the query graph G
%   N_H - the number of data vertices
%   N_G - the number of query vertices
%   method - the specific algorithm, which can be 'Brute', 'VF2' or
%   'RI'
%   opts.order - measures the number of branches if it is true
%   result - an array that stores all the isomorphisms
%   n_branches - the current number of branches generated in the tree
%   mu - the static sequence of query vertices
%   parent_mu - the parent of each vertex in the static sequence (RI only)
%   deg_H - an array that stores the degree of each data vertex
%   deg_G - an array that stores the degree of each query vertex
%   n_G_matched - the current number of query vertices that are mapped


if n_G_matched == N_G
    switch method
        case 'Brute'
            F = BruteFeasibility(M_G, A_H, A_G, N_G);
            if F == true
                result = [result M_G];   
            end
        case 'VF2'
            result = [result M_G]; 
        case 'RI'
            result = [result M_G];            
    end            
else
    switch method
        case 'Brute'
            [ domain_v_G, v_G ] = BruteMatch(M_H, M_G);
        case 'VF2'
            [ domain_v_G, v_G ] = VF2Match(M_H, M_G, A_H, A_G, N_H);
        case 'RI'
            [ domain_v_G, v_G] = RIMatch(M_G, mu ,parent, A_H,...
                n_G_matched, deg_H, deg_G);                              
    end
    M_H0 = M_H;
    M_G0 = M_G;
    n_G_matched = n_G_matched + 1;
    for i = 1:length(domain_v_G)
        v_H = domain_v_G(i);
        M_H = M_H0;
        M_G = M_G0;
        if opts.measure == true
            n_branches = n_branches + 1;
        end
        switch method
            case 'Brute'
                M_H(v_H) = v_G;
                M_G(v_G) = v_H;
                [ result, n_branches ] = DFSRecursive(M_H, M_G,...
                    A_list_H, A_list_G, A_H, A_G, N_H, N_G, method,...
                    opts, result, n_branches, mu, parent ,...
                    deg_H, deg_G, n_G_matched);                
            case 'VF2'                
                M_H(v_H) = v_G;
                M_G(v_G) = v_H;
                F = VF2Feasibility(v_H, v_G, M_G, A_H, A_list_G);
                if F == true
                    [ result, n_branches ] = DFSRecursive(M_H, M_G,...
                        A_list_H, A_list_G, A_H, A_G, N_H, N_G, method,...
                        opts, result, n_branches, mu, parent ,...
                        deg_H, deg_G, n_G_matched);
                end                   
            case 'RI'
                F = RIFeasibility(v_H, v_G, M_H, M_G, A_H, A_G,...
                    deg_H, deg_G);
                if F == true
                    M_G(v_G) = v_H;
                    M_H(v_H) = v_G;
                    [ result, n_branches ] = DFSRecursive(M_H, M_G,...
                        A_list_H, A_list_G, A_H, A_G, N_H, N_G, method,...
                        opts, result, n_branches, mu, parent ,...
                        deg_H, deg_G, n_G_matched);
                end                    
        end
    end
end

end
