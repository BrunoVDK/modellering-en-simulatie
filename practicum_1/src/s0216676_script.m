%% Clear console and workspace
clc
clear
%% Load data
set(0, 'defaultFigurePosition', get(0, 'Screensize')); % Figuren vullen scherm
load('MovieLens_Subset.mat');
[m,n] = size(R);
%% Opdracht 1
subplot(1,2,1)
spy(R(1:1000,1:1000))
subplot(1,2,2)
spy(T(1:1000,1:1000))
%% Opdracht 2
ratings = nnz(R);
int_mem = 4;
double_mem = 8;
max_r = 500;
%
fprintf('Geheugenruimte full(R) : %i\n', m * n * double_mem)
%
size_sparse_naive = ratings * (int_mem * 2 + double_mem);
size_sparse = 12 * ratings + 4 * n;
fprintf('Geheugenruimte sparse(R) : %i\n', size_sparse)
%
fullR = full(R);
fprintf('Matlab zelf gebruikt respectievelijk %i en %i bytes.\n', whos('fullR').bytes, whos('R').bytes)
%
r = 1:max_r;
size_approx = (m + n) * double_mem * r;
snijpunt_r = size_sparse / ((m + n) * double_mem);
fprintf('Snijpunt in r = %i\n\n', snijpunt_r)
%
hold on
plot(r, repmat(size_sparse,1,max_r), 'b-')
plot(r, size_approx, 'r-')
plot(snijpunt_r, size_sparse, 'kp')
xlabel('r')
ylabel('Geheugenverbruik')
legend('Ijle R', 'Benadering', 'Location', 'northeast') 
%% Opdracht 5
A = sprand(4, 4, 1);
disp(A);
[Uk, sk, Vk] = svds(A);
X = s0216676_sparseModel(Uk, diag(sk), Vk, A);
disp(X);
%% Opdracht 6
B = repmat(spones(R(:)), 1, 15);
spy(B(1:500,:))
%% Opdracht 7
tic
[U,S,V] = svds(R);
s0216676_optimalCoefficients(U,V,R)
toc
%% Opdracht 9
mu = s0216676_userMeans(R);
fprintf("Aantal gebruikers met gemiddelde score van 5 : %i\n", length(mu(mu == 5)))
t = sort(mu); 
fprintf("Laagste gemiddeldes : \n")
fprintf("%.4f\n", full(t(1:3)'))
%% Opdracht 10
% Test op de voorbeeldmatrix in de opgave
R = [0 0 3.5 3.0 0 3.0 0 0 0 3.0 0 ; 2.5 0 4.0 0 0 0 0 0 5.0 2.5 0 ; 2.5 5.0 5.0 5.0 4.0 4.0 0 0.5 4.5 0 3.0 ; 0 0 4.5 0 0 0 3.5 0 0 0 3.5 ; 2.5 0 0 0 0 0 0 0 0 2.5 0];
[U,s,V,~] = s0216676_rank1MatrixPursuit(R,3,R);
round(U * diag(s) * V', 1) % Drukt dezelfde waarden af als die opgegeven in de opgave
%% Opdracht 11
[i,j] = find(T);
mu = s0216676_userMeans(R);
fprintf("RMSE : %.4f\n", s0216676_RMSE(T, sparse(i,j,mu(j))))
%% Opdracht 12
tic
k = 30;
[U,s,V,rmse] = s0216676_rank1MatrixPursuit(R,k,T);
plot(1:k, rmse, 'b-')
xlabel('k')
ylabel('rmse')
toc
%% Opdracht 13
[U20,s20,V20,~] = s0216676_rank1MatrixPursuit(R,20,T);
round(s20(1:20),1)
%% Opdracht 14
% Unit test
X = [1 0 1 3 ; 5 4 0 1 ; 2 4 0 0];
disp(X)
[IDs,score] = s0216676_actualBestMovies(X);
fprintf("Score : %.2f\n", score)
fprintf("IDs : %i\n", IDs)
%% Opdracht 16
[IDs,~] = s0216676_actualBestMovies(R);
fprintf("Feitelijke beste films : ")
movieLabel(IDs(1:25))
reviews = sum(R(IDs(1:25),:)~=0,2) %#ok
median(reviews)
sum(reviews)
[IDs,~] = s0216676_predictedBestMovies(U20,s20,V20);
fprintf("Voorspelde beste films : ")
movieLabel(IDs(1:25))
reviews = sum(R(IDs(1:25),:)~=0,2) %#ok
median(reviews)
sum(reviews)
%% Opdracht 18
for j = [98,10100]
    [best,score] = s0216676_predictedBestMoviesForUser(R,U20,s20,V20,j);
    fprintf("10 beste films : ")
    movieLabel(best(1:10))
    score(1:10)
    fprintf("---------------------")
end
reviews = find(T(:,98) >= 4.5);
movieLabel(reviews)
T(reviews,98)