function x_dot = sorosim_dynamics(robot_linkage, x, u, t)
    % Assert for debug
    assert(length(x) == 2*robot_linkage.ndof);
    assert(length(u) == robot_linkage.nact);
    assert(length(t) == 1);

    % dynamicsSolver function
    [y,~,~,~] = robot_linkage.dynamicsSolver(t, x, u);
    
    % dxdt = [q_dot; q_2dot]
    x_dot = [x(robot_linkage.ndof + 1:end); y(1:robot_linkage.ndof)];
end