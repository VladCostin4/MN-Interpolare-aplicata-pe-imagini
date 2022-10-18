function out = proximal_rotate_RGB(img, rotation_angle)
    % =========================================================================
    % Aplica Interpolarea Proximala pentru a roti o imagine RGB cu un unghi dat.
    % =========================================================================
    
    % TODO: Extrage canalul rosu al imaginii.
    img_red = img(:, :, 1);

    % TODO: Extrage canalul verde al imaginii.
    img_green = img(:, :, 2);
  
    % TODO: Extrage canalul albastru al imaginii.
    img_blue = img(:, :, 3);

    % TODO: Aplica rotatia pe fiecare canal al imaginii.
    out_red = proximal_rotate(img_red, rotation_angle);
    out_green = proximal_rotate(img_green, rotation_angle);
    out_blue = proximal_rotate(img_blue, rotation_angle);

    % TODO: Formeaza imaginea finala concaten�nd cele 3 canale de culori.
    out(:, :, 1) = out_red;
    out(:, :, 2) = out_green;
    out(:, :, 3) = out_blue;
    
endfunction