out = sim("Task_6_template.slx")
plot(t_all, out.filtered, 'b.-'); hold on
%plot(t_all, sigint); hold on;
stem(t_all, out.buff, 'r*')
grid on;
legend;
hold off
