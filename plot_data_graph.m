function [ ] = plot_data_graph( N, A_list_G , fraction_active)
A_list_H = generate_triangle_adjacency_list(N, fraction_active);
[ A_H,~ ] = adjacency_matrix( A_list_H,A_list_G );
[ H_coordinates ] = triangle_coordinates( N );


% Plotting nodes of data graph H
scatter(H_coordinates(:,1),H_coordinates(:,2),'k','filled')
hold on
text(H_coordinates(:,1)+0.1,H_coordinates(:,2)+0.1,cellstr(num2str([1:1:(N+1)^2]')))

% Plotting edges of data graph H
for i=1:(N+1)^2
    for j=1:sum(A_H(i,:))
        plot( [H_coordinates(i,1),H_coordinates(A_list_H(i,j),1)],...
            [H_coordinates(i,2),H_coordinates(A_list_H(i,j),2)],'k')
    end
end

xlabel('x')
ylabel('y')
end

