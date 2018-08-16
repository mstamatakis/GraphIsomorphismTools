function [ A_list_H ] = generate_triangle_adjacency_list( N, fraction_active )
% Calculating adjacency list for H
% Initiliasing the reduced adjacency matrix
if N==1
    A_list_H=zeros((N+1)^2,4);
else
    A_list_H=zeros((N+1)^2,3);
end

p_per_row=[1:1:N+1]; % Dummy variable specifying the number of points in each row (CONSTANT)
p_label=[1:1:N+1]; % Dummy variable specifying the label of each points in each row (CHANGES AT EACH ITERATION)

for row=1:N+1 % row number
    for p=1:N+1 % number of points in each row
        
        % bottom row
        if row==1
            if p==1 % first point in bottom row
                A_list_H(1,(1:2))=[2, p_per_row(1)+N+1]; 
            elseif p==N+1 % last point in bottom row
                A_list_H(p_per_row(end),(1:3))=[p_per_row(end-1),p_per_row(end-1)+N+1,p_per_row(end)+N+1];
            else % all intermediate points in bottom row
                A_list_H(p,(1:4))=[p-1,p+1, p+N, p+N+1];
            end
            
        % top row           
        elseif row==N+1
            if p==1 % first point in top row
                A_list_H(p_label(1),(1:3))=[p_label(1)-N-1, p_label(1)-N, p_label(1)+1];
            elseif p==N+1 % last point in top row
                A_list_H(p_label(end),(1:2))=[p_label(end)-N-1, p_label(end)-1];
            else % intermediate points in top row
                A_list_H(p_label(p),(1:4))=[p_label(p)-N-1, p_label(p)-N, p_label(p)-1, p_label(p)+1];                
            end                

        % intermediate rows
        else 
            if p==1 % first point in intermediate rows
                A_list_H(p_label(1),(1:4))=[p_label(1)-N-1, p_label(1)-N, p_label(1)+1, p_label(1)+N+1];
            elseif p==N+1 % last point in intermediate rows
                A_list_H(p_label(end),(1:4))=[p_label(end)-N-1, p_label(end)-1, p_label(end)+N, p_label(end)+N+1];
            else % intermediate points in intermediate rows
                A_list_H(p_label(p),(1:6))=[p_label(p)-N-1, p_label(p)-N, p_label(p)-1, p_label(p)+1, p_label(p)+N, p_label(p)+N+1];
            end
        end
        
    end    
    % Updating dummy variable
    p_label=p_label+(N+1);
end

if fraction_active ~= 1
    n_Vertex = (N+1)^2;
    n_InactiveVertex = n_Vertex - round(n_Vertex*fraction_active);
    
    assert(n_InactiveVertex < n_Vertex, 'Error: all vertices removed from the data graph')
    
    for n_VertexRemoved = 0:n_InactiveVertex-1
        i_VertexToRemove = randi(n_Vertex - n_VertexRemoved );
        for i_Vertex = 1:size(A_list_H,1)
            if i_Vertex == i_VertexToRemove
                continue
            else
                % Remove selected vertex from the adjacent lists of its
                % neighbors
                i_RemovedVertex = find(A_list_H(i_Vertex,:) == i_VertexToRemove);
                if isempty(i_RemovedVertex) == 0
                    A_list_H(i_Vertex,:) = [ A_list_H(i_Vertex,[1:i_RemovedVertex-1]), A_list_H(i_Vertex,[i_RemovedVertex+1:end]), 0];
                end
                % Shift index value by 1
                i_VertexLargerThanRemoved = find(A_list_H(i_Vertex,:)>i_VertexToRemove);
                if isempty(i_VertexLargerThanRemoved) == 0
                    A_list_H(i_Vertex,i_VertexLargerThanRemoved) = A_list_H(i_Vertex,i_VertexLargerThanRemoved) - 1;
                end
            end            
        end
        A_list_H(i_VertexToRemove,:) = [];
    end
    
    % Delete all zero columns
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
    
    % Delete all zero rows
    

        
        
        

end
    


