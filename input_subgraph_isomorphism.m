clear all, close all, clc
% Input
% Test - equilateral triangles
N_range=[1:1:6]; % number of triangles in both width and height, minimum=1
A_lG=[2 3;
    1 3;
    1 2]; % adjacency list of a triangle

t_ullmann=zeros(length(N_range),1); % initilisaing a vector to store time
t_simple=zeros(length(N_range),1);
% repeat algorithm for all N
for N_num=1:length(N_range)
    N=N_range(N_num);
    tic
    [result_ullmann]=ullmann( N,A_lG );
    t_ullmann(N_num)=toc;
%     tic
%     [result_simple]=simple_enumeration(N,A_lG);
%     t_simple(N_num)=toc;
    
end

% plot time vs N
figure
plot(N_range',t_ullmann)
ylabel('Elapsed time (s)')
xlabel('System size N')
hold on
plot(N_range',t_simple)
legend('Ullmann','Simple')

% plot time vs p_H
% figure
% plot((N_range'+1).^2,t_ullmann)
% ylabel('Elapsed time (s)')
% xlabel('System size p_{H,total}')

% plot H
figure
plot_points_and_links( N,A_lG )




