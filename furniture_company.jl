using JuMP

# Simple Optimization problem
m = Model()
@defVar(m, x >= 0, Int)
@defVar(m, y >= 0, Int)
@defVar(m, z >= 0, Int)
@addConstraint(m, 6x + 2y + 5z <= 500)
@addConstraint(m, 2x + 2y + 3z <= 300)
@addConstraint(m, 4x + 2y + 6z <= 450)
@setObjective(m, Max, 60x + 40y + 100z)

print(m)

# Find the optimal solution
status = solve(m)
println("Z = ", getObjectiveValue(m))
println("x = ", getValue(x))
println("y = ", getValue(y))
println("z = ", getValue(z))

# Save these values for later
obj = getObjectiveValue(m)
x_opt = getValue(x)
y_opt = getValue(y)
z_opt = getValue(z)

