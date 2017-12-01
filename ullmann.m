function [ result,nodes ] = ullmann(N,A_lG )
[ A_H,A_G ] = adjacency_matrix( N,A_lG );
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
                % Ullmann's refinement
                u_ref=1; % dummy variable for ullmann's refinement
                    for p_G_nb=1:sum(A_G(p_G,:)) % for all neighbours of p_G                    
                    if M(A_lG(p_G,p_G_nb),:)*A_H(:,p_H)==0 % if this equals to zero, then this inner node will not generate subgraph isomorphism
                        u_ref=0;
                        break
                    end
                    end
                if u_ref==0
                    M=M0_mod; % restoring M
                    continue
                else
                nodes{p_G,n}=num2cell(M,[p_G_total,p_H_total]); % storing M in nodes
                track_change{p_G,n}=num2cell(p_H); % track where the 1 is located
                n=n+1;
                M=M0_mod; % restoring M
                end       
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
                        % Ullmann's refinement
                        u_ref=1; % dummy variable for ullmann's refinement
                        for n_p_g=1:p_G
                            for n_p_g_nb=1:sum(A_G(n_p_g,:))
                                if n_p_g==p_G
                                    if M(A_lG(n_p_g,n_p_g_nb),:)*A_H(:,p_H)==0
                                        u_ref=0;
                                        break
                                    end
                                else
                                    previous_track=cell2mat(track_change{p_G-1,n_node});
                                    if M(A_lG(n_p_g,n_p_g_nb),:)*A_H(:,previous_track(n_p_g))==0
                                        u_ref=0;
                                        break
                                    end
                                 end
                            end
                            if u_ref==0
                                break
                            end
                        end
                        if u_ref==0
                            M=cell2mat(nodes{p_G-1,n_node});  
                            continue
                        else
                            nodes{p_G,n}=num2cell(M,[p_G_total,p_H_total]);
                            track_change{p_G,n}=[track_change{p_G-1,n_node} , p_H]; 
                            n=n+1;
                            M=cell2mat(nodes{p_G-1,n_node});
                        end
                    end
                end
            end
        end
    end
end

[ result ] = terminal_nodes_test( N,A_lG,nodes );
end

