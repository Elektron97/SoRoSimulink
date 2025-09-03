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
result = sim('sorosimulink.slx', 'ReturnWorkspaceOutputs','on');