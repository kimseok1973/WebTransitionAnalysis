using Distributions,StatsPlots, Turing

@model function webpanel(xs,ys)
	lp ~ Beta(2,2)
	entry ~ Beta(2,2)
	entry_input ~ Beta(2,2)
	entry_confirm ~ Beta(2,2)
	payment ~ Beta(2,2)
	pass ~ filldist(Beta(2,2),6)
	s ~ Exponential(1)
	entry_select ~ Beta(2,2)

#	for i = 2:length(xs1)
	xs[2] ~ Normal(xs[1] * lp * pass[1], s)
	xs[3] ~ Normal(xs[2] * entry * pass[2], s)
	xs[4] ~ Normal(xs[3] * entry_input * pass[3], s)
	xs[5] ~ Normal(xs[4] * entry_confirm * pass[4], s)
	xs[6] ~ Normal(xs[5] * payment * pass[5],s)

	ys[2] ~ Normal(ys[1] * lp * pass[1], s)
	ys[3] ~ Normal(ys[2] * entry_select * pass[2], s)
	ys[4] ~ Normal(ys[3] * entry * pass[3], s)
	ys[5] ~ Normal(ys[4] * entry_input * pass[4], s)
	ys[6] ~ Normal(ys[5] * entry_confirm * pass[5], s)
	ys[7] ~ Normal(ys[6] * payment * pass[6],s)
end

begin
    xs = [475_976, 106_555, 30_569, 25_556, 19_453, 7_383]
    ys = [39_391, 8_423, 2_429, 941, 764,625,542,342]
end

model=webpanel(xs,ys)
c=sample(model,NUTS(),2000)
