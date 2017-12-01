function [ result, nodes ] = simple_enumeration( N,A_lG )
[ p_H_total,~,p_G_total,~ ] = number_of_points_and_max_neighbour( N,A_lG );
[ M0_mod,row_1nb_all ] = ullmann_preliminary_root_refinement( N,A_lG );
% Determining the inner nodes and terminal nodes
nodes=cell(2,1);
track_change=cell(2,1);
for p_G=1:p_G_total
    n=1;
    if p_G==1 % the first iteration
        M=M0_mod;
        for p_H=1:p_H_total
            if M(p_G,p_H)==1
                M(p_G,[1:p_H-1,p_H+1:end])=0;
                nodes{p_G,n}=num2cell(M,[p_G_total,p_H_total]); % storing M in nodes
                track_change{p_G,n}=num2cell(p_H); % track where the 1 is located
                n=n+1;
                M=M0_mod; % restoring M
            end
        end
    else        
        for n_node=1:length(nodes)
            M=cell2mat(nodes{p_G-1,n_node});            
            if p_G==row_1nb_all % if the row has only one '1'
                nodes{p_G,num_node}=nodes{p_G-1,num_node}; % then no changes are made to the nodes
                track_change{p_G,num_node}=track_change{p_G-1,num_node};
            else
                for p_H=1:p_H_total
                    if  any(M((1:p_G-1),p_H))==1 % if at that column, there is already a '1' that we have set in previous iterations, then continue
                        continue
                    elseif M(p_G,p_H)==1
                        M(p_G,:)=0;
                        M(p_G,p_H)=1;
                        nodes{p_G,n}=num2cell(M,[p_G_total,p_H_total]);
                        track_change{p_G,n}=[track_change{p_G-1,n_node} , p_H]; 
                        n=n+1;
                        M=cell2mat(nodes{p_G-1,n_node});
                    end
                end
            end
        end
    end
[ result ] = terminal_nodes_test( N,A_lG,nodes );
end





