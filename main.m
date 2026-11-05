%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setup                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% global fixed time step
TIME_STEP = 0.1;

% sim global vars
time = 0;

% terrain map stuff
terrain_map = generate_terrain();

% create player tank
player = Tank([-80, 80]);

% create enemy tank
enemy = Tank([80, 80]);

% all tanks in the sim
tanks = [player, enemy];
num_tanks = numel(tanks);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sim loop                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim_running = true;
while sim_running
    frame_start = tic;

    % update tank kinematics
    for i = 1:num_tanks
        tpos = tanks(i).get_pos();
        height = interp1(terrain_map(:,1), terrain_map(:,2), tpos(1));
        tanks(i).update(TIME_STEP, height);
    end

    % increment time step
    time = time + TIME_STEP;

    % delay
    elapsed = toc(frame_start);
    if elapsed < (1/60)
        pause((1/60) - elapsed);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% local functions                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function terrain_map = generate_terrain()
    num_el = 200;
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