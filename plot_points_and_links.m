function [ ] = plot_points_and_links( N,A_lG )
[ A_H,~ ] = adjacency_matrix( N,A_lG );
[ H_coordinates ] = coordinates( N );
[ A_lH ] = adjacency_list( N );

% Plotting points in H
scatter(H_coordinates(:,1),H_coordinates(:,2),'k','filled')
hold on
text(H_coordinates(:,1)+0.1,H_coordinates(:,2)+0.1,cellstr(num2str([1:1:(N+1)^2]')))

% Plotting links in H
for i=1:(N+1)^2
    for j=1:sum(A_H(i,:))
        plot( [H_coordinates(i,1),H_coordinates(A_lH(i,j),1)],...
            [H_coordinates(i,2),H_coordinates(A_lH(i,j),2)],'k')
    end
end

xlabel('x')
ylabel('y')
end

