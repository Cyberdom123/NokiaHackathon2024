out = sim("Task_6_template.slx")
plot(t_all, out.simout, 'b.-'); hold on
plot(t_all, out.simout1); hold on;
plot(t_all, out.simout2, 'r*')
grid on;
legend;
hold off
