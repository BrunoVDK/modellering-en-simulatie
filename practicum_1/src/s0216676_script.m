set(0, 'defaultFigurePosition', get(0, 'Screensize')); % Figuren vullen scherm
load('MovieLens_Subset.mat');
%%
% Opdracht 1
subplot(1,2,1)
spy(R(1:1000,1:1000))
subplot(1,2,2)
spy(T(1:1000,1:1000))
%%
% Opdracht 2
[m,n] = size(R);
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
%%
% Opdracht 5
A = sprand(4, 4, 1);
disp(A);
[Uk, sk, Vk] = svds(A);
X = s0216676_sparseModel(Uk, diag(sk), Vk, A);
disp(X);
%%
% Opdracht 6
k = 15;
nonzero = nnz(R);
[i,~] = find(R(:));
j = repmat(1:k, nonzero, 1);
B = sparse(repmat(i, k, 1), j(:), ones(nonzero * k, 1), m * n, k, k * nonzero);
spy(B(1:500,:))
%%
% Opdracht 7
tic
[U,S,V] = svds(R);
s0216676_optimalCoefficients(U,V,R)
toc




