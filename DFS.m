function [ result, n_branches ] = DFS(A_list_H, A_list_G, method, opts)
%DFS Solve subgraph isomorphism problem using depth-first search
%   DFS(A_list_H, A_list_G, method, opts) returns all subgraphs with the
%   structure G that is embedded in a data graph H using the method
%   specified in one of the input arguments. Additional options, including
%   the measurement of number of branches and the specification of a
%   non-default ordering strategy, can also be given in the optional input.
%
%   REQUIRED INPUTS:
%   A_list_H - the adjacency list of the data graph
%   A_list_G - the adjacency list of the query graph
%   method - the specific algorithm, which can be 'Brute', 'VF2' or
%   'RI'
%
%   OPTIONAL INPUTS:
%   opts.measure - measures the number of branches created in the search
%   tree, can be either true or false
%   opts.order - specify a non-default ordering strategy

% Check number of inputs
if nargin > 4
    error("The function 'DFS' requires at most 4 inputs.");
end

if nargin == 3
    opts.measure = false;
    switch method
        case 'Brute'
            opts.order = 'NoOrder';
        case 'VF2'
            opts.order = 'NoOrder';
        case 'RI'
            opts.order = 'Order';
    end
end

if nargin == 4
    if isfield(opts, 'measure') == 0
        opts.measure = false;
    end
    if isfield(opts, 'order') == 0 || strcmp(opts.order, 'Default')
        switch method
            case 'Brute'
                opts.order = 'NoOrder';
            case 'VF2'
                opts.order = 'RIOrder';
            case 'RI'
                opts.order = 'RIOrder';
        end
    end
end

% Initialise variables
N_H = size(A_list_H,1);
N_G = size(A_list_G,1);
result = [];
n_branches = 0;
M_H = zeros(N_H,1);
M_G = zeros(N_G,1);
[ A_H,A_G ] = adjacency_matrix( A_list_H,A_list_G );
A_H = uint16(A_H);
A_G = uint16(A_G);
n_neighbors_H = sum(A_H,2);
n_neighbors_G = sum(A_G,2);
n_G_matched = 0;
% Create query vertices order
% switch opts.order
%     case 'NoOrder'
%         v_G_unmatched = 1:N_G;
%     case 'FocusOrder'
%         v_G_unmatched = FocusSearchOrder(A_list_G, A_G);
%     case 'RIOrder'
%         [v_G_unmatched, ~] = RIGreatestConstraintFirst(A_list_G, A_G);
% end

% Start solving the problem
% Trivial case where query graph contains more vertices than the data graph
if N_G>N_H
    return
end
% Other non-trivial cases
switch method
    case 'Brute'
        [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, [], [], [], [], 0);
    case 'VF2'
        [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, [], [], [], [], 0);
    case 'RI'
        [mu,pt_mu] = RIOrder(A_list_G, A_G);
        [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, mu, pt_mu , n_neighbors_H, n_neighbors_G, n_G_matched);
        
        
end
        

