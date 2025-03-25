%%% Build Robot %%%
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

%% Useful Paths
robot_name =  "isupport";
robot_dir = fullfile("robots", robot_name);

% Create Directory
if ~exist(robot_dir, 'dir')
   mkdir(robot_dir)
end

%% Flags
rebuild_link = false;
rebuild_linkage = false;

% File Names
link_file = "robot_link.mat";
linkage_file = "robot_linkage.mat";

%% Create or Load SoRoSimLink
if rebuild_link
    L1 = SorosimLink();
    save(fullfile(robot_dir, link_file), "L1");
else
    if exist(fullfile(robot_dir, link_file), 'file')
        load(fullfile(robot_dir, link_file));
    else
        disp("Error: Linkage not created.");
    end
end

%% Create or Load SoRoSimLinkage
if rebuild_linkage
    T1 = SorosimLinkage(L1);
    save(fullfile(robot_dir, linkage_file), "T1");
else
    if exist(fullfile(robot_dir, linkage_file), 'file')
        load(fullfile(robot_dir, linkage_file));
    else
        disp("Error: Linkage not created.");
    end
end

%% Show Robot
T1.plotq(0.2*randn(T1.ndof, 1))