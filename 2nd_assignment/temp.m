x1 = 2.7242165126;
x2 = 0.7724216282;

eq1 = 2 * (1.5 - x1 + x1 * x2) * (-1 + x2) + 2 * (2.25 - x1 + x1 * x2^2) * (-1 + x2^2) + 2 * (2.625 - x1 + x1 * x2^3) * (-1 + x2^3);
eq2 = 2 * (1.5 - x1 + x1 * x2) * x1 + 4 * (2.25 - x1 + x1 * x2^2) * x1 * x2 + 6 * (2.625 - x1 + x1 * x2^3) * x1 * x2^2;

disp(eq1);
disp(eq2);