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
robot_name = "isupport";
load(fullfile("robots", robot_name, "robot_linkage.mat"));

%% Initial Conditions
x0 = [zeros(T1.ndof, 1); zeros(T1.ndof, 1)];

%% Open Simulink
open_system("sorosimulink.slx");