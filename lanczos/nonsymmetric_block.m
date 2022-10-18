function [Vm, Wm, T] = nonsymmetric_block(A, V, W, m)
  [n, p] = size(V);

  Vm = zeros(n, p, m + 2);
  Vm_ = zeros(n, p, m + 2);
  Wm = zeros(n, p, m + 2);
  Wm_ = zeros(n, p, m + 2);
  T = zeros((m+2) * p, (m+2) * p);
  U = zeros(p, p, m);
  S = zeros(p, p, m);
  Z = zeros(p, p, m);

  [delt, bet] = qr(W' * V);

  % Compute the QR decomposition of W' * V

  Vm(:, :, 1) = V * (bet ^ (-1));
  Wm(:, :, 1) = W * delt;
  Vm_(:, :, 2) = A * Vm(:, :, 1);
  Wm_(:, :, 2) = A' * Wm(:, :, 1);

  for j = 1:m
    % alpha j indices
    a1 = (j - 1) * p + 1;
    a2 = a1 + p - 1;

    % beta j+1 indices
    bx1 = j * p + 1;
    bx2 = bx1 + p - 1;
    by1 = (j - 1) * p + 1;
    by2 = by1 + p - 1;

    % delta j+1 indices
    dx1 = (j - 1) * p + 1;
    dx2 = dx1 + p - 1;
    dy1 = j * p + 1;
    dy2 = dy1 + p - 1;

    T(a1:a2, a1:a2) = (Wm(:, :, j))' * Vm_(:, :, j + 1);
    Vm_(:, :, j + 1) -= Vm(:, :, j) * T(a1:a2, a1:a2);
    Wm_(:, :, j + 1) -= Wm(:, :, j) * (T(a1:a2, a1:a2))';

    % Compute the QR decomposition of V'(:, :, j+1) and W'(:, :, j+1)
  
    Vm_(:, :, j + 1) = Vm(:, :, j + 1) * T(bx1:bx2, by1:by2);
    Wm_(:, :, j + 1) = Wm(:, :, j + 1) * T(dx1:dx2, dy1:dy2);

    % Compute the singular value decomposition of W'(:, :, J+1) and V(:, :, j+1)

    [U(:, :, j), S(:, :, j), Z(:, :, j)] = svd((Wm(:, :, j + 1))' * Vm(:, :, j + 1));
    
    T(dx1:dx2, dy1:dy2) = T(dx1:dx2, dy1:dy2) * U(:, :, j) * (S(:, :, j) ^ (1/2));
    T(bx1:bx2, by1:by2) = (S(:, :, j) ^ (1/2)) * (Z(:, :, j))' * T(bx1:bx2, by1:by2);

    Vm(:, :, j + 1) = Vm(:, :, j + 1) * Z(:, :, j) * (S(:, :, j) ^ (-1/2));
    Wm(:, :, j + 1) = Wm(:, :, j + 1) * U(:, :, j) * (S(:, :, j) ^ (-1/2));

    Vm_(:, :, j + 2) = A * Vm(:, :, j + 1) - Vm(:, :, j) * T(dx1:dx2, dy1:dy2);
    Wm_(:, :, j + 2) = A' * Wm(:, :, j + 1) - Wm(:, :, j) * (T(bx1:bx2, by1:by2))';
  endfor 
endfunction