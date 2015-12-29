using JuMP

# Simple Optimization problem
m = Model()
@defVar(m, x >= 0)
@defVar(m, 0 <= y <= 3)
@addConstraint(m, x + y <= 3)
@addConstraint(m, 5x + 3y <= 11)
@setObjective(m, Max, x + 4y)

print(m)

# Find the optimal solution
status = solve(m)
println("Z = ", getObjectiveValue(m))
println("x = ", getValue(x))
println("y = ", getValue(y))

# Save these values for later
obj = getObjectiveValue(m)
x_opt = getValue(x)
y_opt = getValue(y)