function B = inverse(A)
	[N, N] = size(A);
	
	for i = 1:N # algoritm descompunere QR
		R(i, i) = norm(A(:, i), 2);
		Q(:, i) =  A(:, i) / R(i, i);

		for j = (i + 1):N
			R(i, j) = Q(:, i)' * A(:, j);
			A(:, j) -= Q(:, i) * R(i, j);
		endfor
	endfor
	
	# R * A^-1 = inv(Q)
	
	Q = Q'; # inv(Q) = Q'
	
	B = zeros(N, N);

	for j = 1:N      # rezolvam un sistem de ecuatii lineare in care
		for i = N:-1:1 # matricea coeficientilor este superior triunghiulara
		  B(i, j) = (Q(i, j) - R(i, (i + 1):N) * B((i + 1):N, j)) / R(i, i);	
		endfor
	endfor
endfunction