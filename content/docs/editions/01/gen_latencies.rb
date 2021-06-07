folders = %w[go-gorilla javascript-express typescript-deno typescript-nest-express]
rates = [100,500,750,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000]

res = {}
rates.each do |rate|
  latencies = ["min", "mean", "p50", "p90", "p95", "p99", "max"]

  folders.each do |folder|
    res[rate] ||= {}
    res[rate][:ratio] ||= ["success ratio"]

    output = `cat results/#{folder}/results_dur-60s_rate-#{rate}.bin | vegeta report`
    lines = output.split("\n")

    latencies = latencies.zip(
      lines[3].split("]").last.strip.split(", ")
    )
    res[rate][:ratio] << lines[6].split("]").last.strip
  end

  res[rate][:latencies] = latencies.flatten
end

res.each do |rate, v|
  puts rate
  while (chunk = v[:ratio].shift(5)).size > 0
    print "| "
    print chunk.map {|s| s.ljust(20) }.join(" | ")
    print " |\n"
  end
  while (chunk = v[:latencies].shift(5)).size > 0
    print "| "
    print chunk.map {|s| s.ljust(20) }.join(" | ")
    print " |\n"
  end
end
