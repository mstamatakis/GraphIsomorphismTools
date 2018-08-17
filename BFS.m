function [ result, n_branches ] = BFS(A_list_H, A_list_G, method, opts)
%BFS Solve subgraph isomorphism problem using breadth-first search
%   BFS(A_list_H, A_list_G, method, opts) returns all subgraphs with the
%   structure G that is embedded in a data graph H using the method
%   specified in one of the input arguments. Additional options, including
%   the measurement of number of branches and the specification of a
%   non-default ordering strategy, can also be given in the optional input.
%
%   REQUIRED INPUTS:
%   A_list_H - the adjacency list of the data graph
%   A_list_G - the adjacency list of the query graph
%   method - the specific algorithm, which can be 'Ullmann', 'McGregor' or
%   'Focus'
%
%   OPTIONAL INPUTS:
%   opts.measure - measures the number of branches created in the search
%   tree, can be either true or false
%   opts.order - specify a non-default ordering strategy

% Check number of inputs
if nargin > 4
    error("The function 'BFS' requires at most 4 inputs.");
end
if nargin == 3
    opts.measure = false;
    switch method
        case 'Ullmann'
            opts.order = 'NoOrder';
        case 'McGregor'
            opts.order = 'McGregorOrder';
        case 'Focus'
            opts.order = 'FocusOrder';
    end
end
if nargin == 4
    if isfield(opts, 'measure') == 0
        opts.measure = false;
    end
    if isfield(opts, 'order') == 0 || strcmp(opts.order, 'Default')
        switch method
            case 'Ullmann'
                opts.order = 'NoOrder';
            case 'McGregor'
                opts.order = 'McGregorOrder';
            case 'Focus'
                opts.order = 'FocusOrder';
        end
    end
end
% Initialise variables
[ A_H,A_G ] = adjacency_matrix( A_list_H,A_list_G );
N_H = size(A_H,1);
N_G = size(A_G,1);
result = [];
n_branches = 0;
previous_M = cell(1,1);
% Create query vertices order
switch opts.order
    case 'NoOrder'
        v_G_order = 1:N_G;
    case 'McGregorOrder'
        v_G_order = McGregorOrder(N_G, A_G);
    case 'FocusOrder'
        v_G_order = FocusOrder(A_list_G, A_G);
    case 'RIOrder'
        [v_G_order, ~] = RIOrder(A_list_G, A_G);
end
% Create initial domains of the query vertices
switch method
    case 'Ullmann'
        M0 = UllmannPreProcess( A_H, A_G, N_H, N_G);
    case 'McGregor'
        M0 = UllmannPreProcess( A_H, A_G, N_H, N_G);
    case 'Focus'
        M0 = FocusPreProcess(A_list_H, A_list_G, A_H, A_G);
end
% Convert matrices to bit-matrices
A_H = uint16(A_H);
A_G = uint16(A_G);
M0 = uint16(M0);
previous_M{1,1} = M0;
% Start solving the problem
% Trivial case where query graph contains more vertices than the data graph
if N_G>N_H
    return
end
% Other non-trivial cases
for v_G = v_G_order
    current_M = [];
    for n_M = 1:length(previous_M)
        M0 = previous_M{n_M};
        for v_H = 1:N_H
            if M0(v_G, v_H) == 1
                if opts.measure == true
                    n_branches = n_branches + 1;
                end               
                switch method
                    case 'Ullmann'
                        % Ullmann reduction procedure
                        M = M0;
                        M(v_G,[1:v_H-1,v_H+1:end])=0;
                        F = UllmannFeasibility(M, v_H, v_G, A_H, A_G,...
                            A_list_G );
                        if F == false
                            continue
                        end
                        M([1:v_G-1 v_G+1:end],v_H) = 0;
                        current_M = [current_M mat2cell(M,size(M,1))];
                    case 'McGregor'
                        % McGregor reduction procedure
                        M = McGregorFeasibility(M0, v_H, v_G, A_H, A_G,...
                            A_list_G );
                        current_M = [current_M mat2cell(M,size(M,1))];
                    case 'Focus'
                        % Focus search reduction procedure
                        if v_G == v_G_order(end) && any(M0(...
                                v_G_order(1:end-1), v_H)==1)==0
                            M = M0;
                            M(v_G, [1:v_H-1 v_H+1:end]) = 0;
                            current_M = [current_M mat2cell(M, size(M,1))];
                        else
                            [M , consistent] = FocusReduce(v_H, v_G, M0,...
                                v_G_order, A_list_H, A_list_G, A_H, A_G);
                            if consistent == true
                                current_M = [current_M ...
                                    mat2cell(M, size(M,1))];
                            end
                        end
                end                    
            end
        end
    end
    if v_G == v_G_order(end)
        result = current_M;
    else
        if isempty(current_M)
            return
        end
        previous_M = current_M;
    end
end
