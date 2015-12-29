using JuMP

# Simple Optimization problem
m = Model()
@defVar(m, AE >= 0)
@defVar(m, BE >= 0)
@defVar(m, CE >= 0)
@defVar(m, DE >= 0)

@defVar(m, AW >= 0)
@defVar(m, BW >= 0)
@defVar(m, CW >= 0)
@defVar(m, DW >= 0)

@addConstraint(m, AE + BE + CE + DE >= 900000)
@addConstraint(m, AW + BW + CW + DW >= 700000)
@addConstraint(m, AE + AW <= 800000)
@addConstraint(m, BE + BW <= 400000)
@addConstraint(m, CE + CW <= 600000)
@addConstraint(m, DE + DW <= 350000)
@addConstraint(m, AE + AW <= 0.25*(AE + BE + CE + DE + AW + BW + CW + DW))

@setObjective(m, Min, 2200AE + 2200BE + 4000CE + 2300DE 
				+ 2800AW + 2200BW + 3000CW + 3100DW)

print(m)

# Find the optimal solution
status = solve(m)
println("Z = ", getObjectiveValue(m))
println("AE = ", getValue(AE))
println("BE = ", getValue(BE))
println("CE = ", getValue(CE))
println("DE = ", getValue(DE))

println("AW = ", getValue(AW))
println("BW = ", getValue(BW))
println("CW = ", getValue(CW))
println("DW = ", getValue(DW))


# Save these values for later
obj = getObjectiveValue(m)
AE_opt = getValue(AE)
BE_opt = getValue(BE)
CE_opt = getValue(CE)
DE_opt = getValue(DE)

AW_opt = getValue(AW)
BW_opt = getValue(BW)
CW_opt = getValue(CW)
DW_opt = getValue(DW)
