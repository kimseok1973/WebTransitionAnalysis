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

""" chains result
Iterations        = 1001:1:3000
Number of chains  = 1
Samples per chain = 2000
Wall duration     = 154.72 seconds
Compute duration  = 154.72 seconds
parameters        = entry, entry_input, entry_confirm, payment, pass[1], pass[2], pass[3], pass[4], pass[5], pass[6], s, entry_select
internals         = lp, n_steps, is_accept, acceptance_rate, log_density, hamiltonian_energy, hamiltonian_energy_error, max_hamiltonian_energy_error, tree_depth, numerical_error, step_size, nom_step_size

Summary Statistics
     parameters      mean       std      mcse   ess_bulk   ess_tail      rhat   ess_per_sec 
         Symbol   Float64   Float64   Float64    Float64    Float64   Float64       Float64 

          entry    0.4373    0.0302    0.0029   112.8126   262.6404    1.0116        0.7291
    entry_input    0.9325    0.0317    0.0032    98.0710   128.1721    1.0064        0.6339
  entry_confirm    0.9178    0.0425    0.0091    22.2925    59.9143    1.0692        0.1441
        payment    0.5731    0.0643    0.0062   105.0721   235.9708    1.0112        0.6791
        pass[1]    0.5021    0.1735    0.0150   126.7066   198.0739    1.0012        0.8189
        pass[2]    0.6593    0.0459    0.0044   112.6155   285.1276    1.0116        0.7279
        pass[3]    0.8974    0.0309    0.0031    96.1617   132.2006    1.0061        0.6215
        pass[4]    0.8313    0.0397    0.0085    22.2856    57.9026    1.0691        0.1440
        pass[5]    0.6711    0.0738    0.0073   103.8026   234.2260    1.0117        0.6709
        pass[6]    0.9147    0.0595    0.0037   189.4565   184.6593    1.0038        1.2245
              s   61.0457    4.5099    0.2584   300.9349   547.0406    1.0002        1.9450
   entry_select    0.4399    0.0323    0.0030   116.8697   315.6801    1.0125        0.7554

Quantiles
     parameters      2.5%     25.0%     50.0%     75.0%     97.5% 
         Symbol   Float64   Float64   Float64   Float64   Float64 

          entry    0.3805    0.4151    0.4378    0.4589    0.4960
    entry_input    0.8670    0.9106    0.9344    0.9568    0.9883
  entry_confirm    0.8193    0.8928    0.9208    0.9493    0.9879
        payment    0.4676    0.5256    0.5665    0.6140    0.7164
        pass[1]    0.2597    0.3587    0.4702    0.6205    0.8897
        pass[2]    0.5783    0.6254    0.6554    0.6910    0.7548
        pass[3]    0.8453    0.8740    0.8948    0.9174    0.9642
        pass[4]    0.7710    0.8021    0.8270    0.8528    0.9288
        pass[5]    0.5313    0.6187    0.6696    0.7234    0.8134
        pass[6]    0.7658    0.8840    0.9276    0.9601    0.9893
              s   52.8711   58.0312   60.8679   63.9855   70.1527
   entry_select    0.3794    0.4164    0.4405    0.4625    0.5025
"""