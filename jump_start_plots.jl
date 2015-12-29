using DataFrames, Gadfly, Cairo

include("jump_start.jl")

# Start and end y-values and x-values
y = [-2,5]
x = [-1,3]

# For each constraint, we create a DataFrame with 2 points
# (the endpoints of the line segments)
df1 = DataFrame(x=0*y, y=y, label="x = 0")
df2 = DataFrame(x=x, y=0, label="y = 0")
df3 = DataFrame(x=x, y=3, label="y = 3")
df4 = DataFrame(x=x, y=3 - x, label="x + y = 3")
df5 = DataFrame(x=x, y=(11 - 5*x)/3, label="5x + 3y = 11")

# Combine all of the DataFrames into one big DataFrame
df = vcat(df1, df2, df3, df4, df5)

# Plot all of the lines together
plot1 = plot(df, x="x", y="y", color="label", Geom.line,
         Scale.discrete_color_manual("blue","red", "green", "purple", "brown"),
         Guide.colorkey("Equation"),
         Guide.title("Optimization Problem #1"))

# Save the figure as a pdf
draw(PDF("figures/problem_1.pdf", 6inch, 4inch), plot1)

#### Shaded Feasible Region
df6 = DataFrame(x=[0,0,1,11/5,0], y=[0,3,2,0,0], label="Feasible\nRegion")

plot1 = plot(df, x="x", y="y", color="label", Geom.line,
         Scale.discrete_color_manual("blue","red", "green", "purple", "brown"),
         Guide.colorkey("Equation"),
         Guide.title("Optimization Problem #1"),
	layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("yellow"))))

draw(PDF("figures/problem_1_shaded.pdf", 6inch, 4inch), plot1)

#### Optimal Solution
df_opt = DataFrame(x=x_opt, y=y_opt)

plot1 = plot(layer(df_opt, x="x",y="y", Geom.point, Theme(default_color=color("black"))),
         layer(df, x="x", y="y", color="label", Geom.line),
         Scale.discrete_color_manual("blue","red", "green", "purple", "brown"),
         Guide.colorkey("Equation"),
         Guide.title("Optimization Problem #1"),
	layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("yellow"))))

draw(PDF("figures/problem_1_optimal.pdf", 6inch, 4inch), plot1)

#### Feasible Region only
plot1 = plot(layer(df_opt, x="x",y="y", Geom.point, Theme(default_color=color("black"))),
         layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=false), color="label", Theme(line_width=0.3mm)),
         Scale.discrete_color_manual("blue"),
         Guide.colorkey("Label"),
         Guide.title("Problem #1 Feasible Region"),
   layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("yellow"))),
   Scale.x_continuous(minvalue=-1, maxvalue=3),
   Scale.y_continuous(minvalue=-2, maxvalue=6))

draw(PDF("figures/problem_1_feasible.pdf", 6inch, 4inch), plot1)

#### Iso-cost lines
df_iso1 = DataFrame(x=x, y=(obj-x)/4, label="x + 4y = $obj")
df_iso2 = DataFrame(x=x, y=((obj/2)-x)/4, label="x + 4y = $(obj/2)")
df_iso3 = DataFrame(x=x, y=-x/4, label="x + 4y = 0")

df_iso = vcat(df_iso1, df_iso2, df_iso3)

plot1 = plot(layer(df_opt, x="x",y="y", Geom.point, Theme(default_color=color("black"))),
         layer(df_iso, x="x", y="y", Geom.line, color="label"),
         Scale.discrete_color_manual("black", "gray", "brown"),
         Guide.colorkey("Equation"),
         Guide.title("Problem #1 Iso-cost Lines"),
   layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("yellow"))),
   layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=false), Theme(default_color=color("blue"), line_width=1mm)),
   Scale.x_continuous(minvalue=-1, maxvalue=3),
   Scale.y_continuous(minvalue=-2, maxvalue=6))

draw(PDF("figures/problem_1_iso_lines.pdf", 6inch, 4inch), plot1)

plot1 = plot(layer(df_opt, x="x",y="y", Geom.point, Theme(default_color=color("black"))),
         layer(df_iso1, x="x", y="y", Geom.line, color="label"),
         Scale.discrete_color_manual("black"),
         Guide.colorkey("Equation"),
         Guide.title("Problem #1 Optimal Iso-cost"),
   layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("yellow"))),
   layer(df6, x="x", y="y", Geom.polygon(preserve_order=true, fill=false), Theme(default_color=color("blue"), line_width=1mm)),
   Scale.x_continuous(minvalue=-1, maxvalue=3),
   Scale.y_continuous(minvalue=-2, maxvalue=6))

draw(PDF("figures/problem_1_iso_opt.pdf", 6inch, 4inch), plot1)