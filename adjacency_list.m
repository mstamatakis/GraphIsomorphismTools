function [ A_lH ] = adjacency_list( N )
% Calculating adjacenct list for H
% Initiliasing the reduced adjacency matrix
if N==1
    A_lH=zeros((N+1)^2,4);
else
    A_lH=zeros((N+1)^2,3);
end

p_per_row=[1:1:N+1]; % Dummy variable specifying the number of points in each row (CONSTANT)
p_label=[1:1:N+1]; % Dummy variable specifying the label of each points in each row (CHANGES AT EACH ITERATION)

for row=1:N+1 % row number
    for p=1:N+1 % number of points in each row
        
        % bottom row
        if row==1
            if p==1 % first point in bottom row
                A_lH(1,(1:2))=[2, p_per_row(1)+N+1]; 
            elseif p==N+1 % last point in bottom row
                A_lH(p_per_row(end),(1:3))=[p_per_row(end-1),p_per_row(end-1)+N+1,p_per_row(end)+N+1];
            else % all intermediate points in bottom row
                A_lH(p,(1:4))=[p-1,p+1, p+N, p+N+1];
            end
            
        % top row           
        elseif row==N+1
            if p==1 % first point in top row
                A_lH(p_label(1),(1:3))=[p_label(1)-N-1, p_label(1)-N, p_label(1)+1];
            elseif p==N+1 % last point in top row
                A_lH(p_label(end),(1:2))=[p_label(end)-N-1, p_label(end)-1];
            else % intermediate points in top row
                A_lH(p_label(p),(1:4))=[p_label(p)-N-1, p_label(p)-N, p_label(p)-1, p_label(p)+1];                
            end                

        % intermediate rows
        else 
            if p==1 % first point in intermediate rows
                A_lH(p_label(1),(1:4))=[p_label(1)-N-1, p_label(1)-N, p_label(1)+1, p_label(1)+N+1];
            elseif p==N+1 % last point in intermediate rows
                A_lH(p_label(end),(1:4))=[p_label(end)-N-1, p_label(end)-1, p_label(end)+N, p_label(end)+N+1];
            else % intermediate points in intermediate rows
                A_lH(p_label(p),(1:6))=[p_label(p)-N-1, p_label(p)-N, p_label(p)-1, p_label(p)+1, p_label(p)+N, p_label(p)+N+1];
            end
        end
        
    end    
    % Updating dummy variable
    p_label=p_label+(N+1);
end


end

