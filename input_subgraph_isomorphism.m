clear all, close all, clc
% Input
% Test - equilateral triangles
N_range=[6]; % number of triangles in both width and height, minimum=1

A_lG=[2 3;
    1 3;
    1 2]; % adjacency list of a triangle


% A_lG = [ 2 3 0 0;
%     1 3 4 0;
%     1 2 4 5;
%     2 3 5 6;
%     3 4 6 0;
%     4 5 0 0];

% A_lG = [ 3 0 0 0;
%     3 0 0 0;
%     1 2 4 5;
%     3 5 0 0;
%     3 4 6 0;
%     5 0 0 0];

% A straight line with 5 points
% A_lG = [ 2 0;
%      1 3;
%      2 4;
%      3 5;
%      4 0];

t_ullmann=zeros(length(N_range),1); % initilisaing a vector to store time
t_BVDR = zeros(length(N_range),1);
% t_simple=zeros(length(N_range),1);
% t_VF2=zeros(length(N_range),1);
% repeat algorithm for all N
for N_num=1:length(N_range)
    N=N_range(N_num);
    % Ullmann
    tic
    [result_ullmann]=ullmann( N,A_lG );
    t_ullmann(N_num)=toc;
    % BVDR
    tic
    [result_BVDR]=ullmann_BVDR( N,A_lG );
    t_BVDR(N_num)=toc;
%     tic
%     [result_VF2]=VF2(N,A_lG);
%     t_VF2(N_num)=toc;
    % Simple enumeration
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
plot(N_range',t_BVDR)
legend('Ullmann','BVDR')

% plot time vs p_H
% figure
% plot((N_range'+1).^2,t_ullmann)
% ylabel('Elapsed time (s)')
% xlabel('System size p_{H,total}')

% plot H
figure
plot_points_and_links( N,A_lG )




