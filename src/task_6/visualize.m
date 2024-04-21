out = sim("Task_6_template.slx")
plot(t_all,out.filtered)
hold on
plot(t_all,sigint)
hold off
