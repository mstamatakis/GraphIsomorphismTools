function [ A_list_H ] = data_adjacency_list( graph_size, fraction_active )
%data_adjacency_list Generate the adjacency list of a triangular grid.
%   data_adjacency_list( graph_size, fraction_active ) returns the
%   adjacency list of a triangular lattice of specified graph size and
%   fraction of vertices that are active (the inactive vertices will be
%   removed from the adjacency list).
%
%   REQUIRED INPUTS:
%   graph_size - an integer which scales with the graph size, with the
%   number of vertices being (graph_size+1)^2
%   fraction_active - the fraction of active vertices, between 0 and 1.

% Initialise adjacency list
if graph_size==1
    A_list_H=zeros((graph_size+1)^2,3);
else
    A_list_H=zeros((graph_size+1)^2,6);
end

% Fill the list
v_per_row=[1:1:graph_size+1]; % Number of vertices in each row
v_index=[1:1:graph_size+1]; % Index number of each vertex in each row

for row=1:graph_size+1 % for each row in the data graph
    for v=1:graph_size+1 % for each vertex        
        if row==1 % The first row
            if v==1
                A_list_H(v_index(v),(1:2))=[2, v_per_row(1)+graph_size+1]; 
            elseif v==graph_size+1
                A_list_H(v_index(v),(1:3))=[v_per_row(end-1),...
                    v_per_row(end-1)+graph_size+1,...
                    v_per_row(end)+graph_size+1];
            else
                A_list_H(v_index(v),(1:4))=[v-1, ...
                    v+1,...
                    v+graph_size,...
                    v+graph_size+1];
            end
                     
        elseif row==graph_size+1 % The last row
            if v==1
                A_list_H(v_index(v),(1:3))=[v_index(1)-graph_size-1,...
                    v_index(1)-graph_size,...
                    v_index(1)+1];
            elseif v==graph_size+1
                A_list_H(v_index(v),(1:2))=[v_index(end)-graph_size-1,...
                    v_index(end)-1];
            else
                A_list_H(v_index(v),(1:4))=[v_index(v)-graph_size-1,...
                    v_index(v)-graph_size,...
                    v_index(v)-1,...
                    v_index(v)+1];                
            end                

        else % Any rows inbetween the first and the last
            if v==1
                A_list_H(v_index(v),(1:4))=[v_index(1)-graph_size-1,...
                    v_index(1)-graph_size,...
                    v_index(1)+1,...
                    v_index(1)+graph_size+1];
            elseif v==graph_size+1
                A_list_H(v_index(v),(1:4))=[v_index(end)-graph_size-1,...
                    v_index(end)-1,...
                    v_index(end)+graph_size,...
                    v_index(end)+graph_size+1];
            else
                A_list_H(v_index(v),(1:6))=[v_index(v)-graph_size-1,...
                    v_index(v)-graph_size,...
                    v_index(v)-1,...
                    v_index(v)+1,...
                    v_index(v)+graph_size,...
                    v_index(v)+graph_size+1];
            end
        end        
    end    
    v_index=v_index+(graph_size+1);
end

% Remove certain number of vertices based on fraction_active
if fraction_active ~= 1
    n_Vertex = (graph_size+1)^2;
    n_InactiveVertex = n_Vertex - round(n_Vertex*fraction_active);
    
    assert(n_InactiveVertex < n_Vertex,...
        'Error: all vertices removed from the data graph')
    
    for n_VertexRemoved = 0:n_InactiveVertex-1
        % choose a random vertex to remove
        i_VertexToRemove = randi(n_Vertex - n_VertexRemoved );
        for i_Vertex = 1:size(A_list_H,1)
            if i_Vertex == i_VertexToRemove
                continue
            else
                % Remove selected vertex from the adjacent lists of its
                % neighbors
                i_RemovedVertex = find(A_list_H(i_Vertex,:) ==...
                    i_VertexToRemove);
                if isempty(i_RemovedVertex) == 0
                    A_list_H(i_Vertex,:) = [ A_list_H(i_Vertex,...
                        [1:i_RemovedVertex-1]),...
                        A_list_H(i_Vertex,[i_RemovedVertex+1:end]), 0];
                end
                % Shift index value by 1
                i_VertexLargerThanRemoved = find(A_list_H(i_Vertex,:)>...
                    i_VertexToRemove);
                if isempty(i_VertexLargerThanRemoved) == 0
                    A_list_H(i_Vertex,i_VertexLargerThanRemoved) = ...
                        A_list_H(i_Vertex,i_VertexLargerThanRemoved) - 1;
                end
            end            
        end
        % remove adjacency list of selected vertex
        A_list_H(i_VertexToRemove,:) = [];
    end
    
    % delete all zero columns
    maxNeighbors = size(A_list_H,2);
    StopDelete = false;
    while StopDelete == false || maxNeighbors == 0
        SumColumn = sum(A_list_H(:,maxNeighbors));
        if SumColumn ~= 0
            StopDelete = true;
        else
            A_list_H(:,maxNeighbors) = [];
            maxNeighbors = maxNeighbors - 1;
        end
    end

end

end
    


