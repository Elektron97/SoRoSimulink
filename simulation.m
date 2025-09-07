%% Simulation
clear all
close all
clc

%% Load and Startup SoRoSim
% Clean StartUp
diff_sorosim_path = fullfile("SoRoSim", "Differentiable_SoRoSim");
cd(diff_sorosim_path)
startup

% Switch again to the current directory
[current_path, ~, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
cd(current_path)

%% Load Robot
robot_name = "hsupport";
load(fullfile("robots", robot_name, "robot_linkage.mat"));

%% Dynamics Handle
addpath("functions")
addpath("signals")
sorosim_handle = @(x, u, t) sorosim_dynamics(T1, x, u, t);

%% Initial Conditions
x0 = [zeros(T1.ndof, 1); zeros(T1.ndof, 1)];
u0 = zeros(T1.nact, 1);

% Dimensions
nx = 2*T1.ndof;
nu = T1.nact;

%% Open Simulink
% Load Simulink file
load_system('sorosimulink.slx');
% Simulate and Extract results
sim_result = sim('sorosimulink.slx', 'ReturnWorkspaceOutputs','on');

%% Interpolate
result.nu_s = 1e+2;
result.fs = 1e+3;

% Interpolate Data
result.t = 0:(1/result.fs):sim_result.tout(end);
result.qqd = interp1(sim_result.tout, sim_result.simout.data, result.t)';

%% Compute Strain
result.s = 0:(1/result.nu_s):T1.VLinks.L;

% Strain handle
xi_handle = @(s, q) T1.CVRods{1}(2).Phi_h(s, T1.CVRods{1}(2).Phi_dof, T1.CVRods{1}(2).Phi_odr)*q + T1.CVRods{1}(2).xi_starfn(s);

% Init
result.xi = zeros(6, length(result.s), length(result.t));

% Fill
for i = 1:length(result.t)
    for j = 1:length(result.s)
        result.xi(:, j, i) = xi_handle(result.s(j), result.qqd(1:T1.ndof, i));
    end
end

%% Save
save("actuators_dynamics10.mat", '-v7.3', '-fromstruct', result);