function out = bicubic_resize_RGB(img, p, q)
    % =========================================================================
    % Redimensioneaza imaginea img astfel �nc�t aceasta save fie de dimensiune p x q.
    % Imaginea img este colorata.
    % =========================================================================

    % TODO: Extrage canalul rosu al imaginii.
    img_red = img(:, :, 1);

    % TODO: Extrage canalul verde al imaginii.
    img_green = img(:, :, 2);

    % TODO: Extrage canalul albastru al imaginii.
    img_blue = img(:, :, 3);

    % TODO: Aplica functia bicubic pe cele 3 canale ale imaginii.
    out_red = bicubic_resize(img_red, p, q);
    out_green = bicubic_resize(img_green, p, q);
    out_blue = bicubic_resize(img_blue, p, q);

    % TODO: Formeaza imaginea finala concatenand cele 3 canale de culori.
    out(:, :, 1) = out_red;
    out(:, :, 2) = out_green;
    out(:, :, 3) = out_blue;

endfunction
