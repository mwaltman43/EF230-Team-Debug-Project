function terrain_map = generate_terrain()
    num_el = 400;
    x = linspace(-100, 100, num_el);

    D = 0.9;
    freq_ratio = 1.5;
    w0 = 0.09;
    amp = 5;
    n = (0:9)';
    phi = 2 * pi * rand(numel(n), 1);
    height = amp * sum(freq_ratio.^((D - 2) * n) .* cos(w0 * freq_ratio.^n * x + phi), 1);

    terrain_map = [x(:), height(:)];
end
