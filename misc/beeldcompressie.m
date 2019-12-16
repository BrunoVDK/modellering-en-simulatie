%% Grayscale image
colormap gray;
imagesc(Z)
%% Color image
image(A)

%% Low rank approximation (SVD)
hold on
figure
colormap gray;

[U,S,V] = svd(Z);
X = 10:10:200;
[~,steps] = size(X);
Y = X;
for i = 1:steps
   k = X(i);
   Zk = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
   Y(i) = norm(Zk - Z) / norm(Z);
   colormap gray;
   subplot(5,5,i); 
   imagesc(Zk);
end
subplot(5,5,21:25);
semilogy(X, Y, 'b--')

%% Low rank approximation (QR)
figure
colormap gray;

[Q,R,P] = qr(Z);
X = 10:10:200;
[~,steps] = size(X);
Y = X;
ip = inv(P);
for i = 1:steps
   k = X(i);
   Zk = Q(:,1:k) * R(1:k,:) * ip;
   Y(i) = norm(Zk - Z) / norm(Z);
   colormap gray;
   subplot(5,5,i); 
   imagesc(Zk);
end
subplot(5,5,21:25);
semilogy(X, Y, 'r--')

hold off

%% Eigenvalue decomposition (QR)

k = 5;
P1 = orth(randn(k));
P2 = randn(k);
Lk = diag(1:k);
A = (P1 * Lk) \ P1';
B = (P2 * Lk) \ P2';

X1 = eigendec_QR(A);
X2 = eigendec_QR(B);

function [X,it] = eigendec_QR(A)
    X = A;
    it = 0;
    res = eps
    while res >= eps
        [Q,R] = qr(X);
        X = R * Q;
        it = it + 1;
        res = norm(tril(X) - diag(diag(X)),'fro')
    end
end
