% Define the function
f = @(x) sin(3*pi*cos(2*pi*x).*sin(pi*x));

% Define the interval and number of points
a = -8;
b = 1;
n = 3^7;  % Reduced number of points for faster computation, adjust as needed

% Generate initial guesses for fzero
x0 = linspace(a, b, n);

% Preallocate arrays for storing results
q_serial = zeros(size(x0));  % Serial results
q_parallel = zeros(size(x0));  % Parallel results

% Set options for fzero to suppress display
options = optimset('Display', 'off');

%% Serial Execution
disp('Starting serial execution...');
tic;
for i = 1:n
    q_serial(i) = fzero(f, x0(i), options);  % Solve using fzero with display off
end
serial_time = toc;
disp(['Serial execution time: ', num2str(serial_time), ' seconds']);

%% Parallel Execution
disp('Starting parallel execution...');


tic;
parfor i = 1:n
    q_parallel(i) = fzero(f, x0(i), options);  % Parallel solve using fzero with display off
end
parallel_time = toc;
disp(['Parallel execution time: ', num2str(parallel_time), ' seconds']);

% Close the parallel pool
delete(gcp('nocreate'));

%% Unique solutions
q_serial_unique = unique(q_serial);  % Get unique roots from serial execution
q_parallel_unique = unique(q_parallel);  % Get unique roots from parallel execution

%% Calculate Speedup and Efficiency
speedup = serial_time / parallel_time;
efficiency = speedup / 8;  % Since you used 8 workers

% Display the results
disp(['Speedup: ', num2str(speedup)]);
disp(['Efficiency: ', num2str(efficiency)]);
