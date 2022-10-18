function out = proximal_2x2_RGB(img, STEP = 0.1)
    % ==============================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 definita img cu puncte intermediare echidistante.
    % img este o imagine colorata RGB -Red, Green, Blue.
    % =============================================================================================

    % TODO: Extrage canalul rosu al imaginii.
    img_red = img(:, :, 1);

    % TODO: Extrage canalul verde al imaginii.
    img_green = img(:, :, 2);
    
    % TODO: Extrage canalul albastru al imaginii.
    img_blue = img(:, :, 3);
    
    % TODO: Aplic? functia proximal pe cele 3 canale ale imaginii.
    out_red = proximal_2x2(img_red, STEP);
    out_green = proximal_2x2(img_green, STEP);
    out_blue = proximal_2x2(img_blue, STEP);

    % TODO: Formeaza imaginea finala concaten�nd cele 3 canale de culori.
    out(:, :, 1) = out_red;
    out(:, :, 2) = out_green;
    out(:, :, 3) = out_blue;

endfunction
