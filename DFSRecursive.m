function [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, mu, pt_mu , n_neighbors_H, n_neighbors_G, n_G_matched)

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
            [ v_H_list, v_G ] = BruteMatch(M_H, M_G);
        case 'VF2'
            [ v_H_list, v_G ] = VF2ComputePair(M_H, M_G, A_H, A_G, N_H);
        case 'RI'
            [ v_H_list, v_G] = RIMatch(M_G, mu ,pt_mu, A_H, n_G_matched, n_neighbors_H, n_neighbors_G);
                              
    end
    M_H0 = M_H;
    M_G0 = M_G;
    n_G_matched = n_G_matched + 1;
    for v_H = v_H_list
        M_H = M_H0;
        M_G = M_G0;
        if opts.measure == true
            n_branches = n_branches + 1;
        end
        switch method
            case 'Brute'
                M_H(v_H) = v_G;
                M_G(v_G) = v_H;
                [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, mu, pt_mu , n_neighbors_H, n_neighbors_G, n_G_matched);
                
            case 'VF2'                
                M_H(v_H) = v_G;
                M_G(v_G) = v_H;
                F = VF2Feasibility(v_H, v_G, M_G, A_H, A_list_G);
                if F == true
                    [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, mu, pt_mu , n_neighbors_H, n_neighbors_G, n_G_matched);
                end   
                
            case 'RI'
                F = RIFeasibility(v_H, v_G, M_H, M_G, A_H, A_G, n_neighbors_H, n_neighbors_G);
                if F == true
                    M_G(v_G) = v_H;
                    M_H(v_H) = v_G;
                    [ result, n_branches ] = DFSRecursive(M_H, M_G, A_list_H, A_list_G, A_H, A_G, N_H, N_G, method, opts, result, n_branches, mu, pt_mu , n_neighbors_H, n_neighbors_G, n_G_matched);
                end                    
        end

    end

end

end
